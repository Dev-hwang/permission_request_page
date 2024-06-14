import 'dart:async';
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localization.dart';
import 'models/custom_text.dart';
import 'models/init_result.dart';
import 'models/permission_data.dart';
import 'models/permission_type.dart';
import 'permission_request_page_utils.dart';

export 'models/custom_text.dart';
export 'models/init_result.dart';
export 'models/permission_data.dart';
export 'models/permission_type.dart';

/// The initialization function that is granted the required permissions and is to be executed.
typedef InitFunction = Future<InitResult> Function();

/// Builder for building custom splash view.
typedef SplashViewBuilder = Widget Function();

/// Builder for building custom permission view header.
typedef PermissionViewHeaderBuilder = Widget Function();

/// Builder for building custom permission list item.
typedef PermissionListItemBuilder = Widget Function(PermissionData permission);

/// A widget for building a page that requests permissions and initializes the app.
class PermissionRequestPage extends StatefulWidget {
  const PermissionRequestPage({
    Key? key,
    required this.permissions,
    this.customText,
    this.appIconAssetPath,
    this.requestMessageStyle,
    this.permissionIconColor,
    this.permissionNameStyle,
    this.permissionDescStyle,
    this.splashViewBuilder,
    this.permissionViewHeaderBuilder,
    this.permissionListItemBuilder,
    this.splashDuration = const Duration(seconds: 1),
    required this.initFunction,
    required this.nextPage,
  }) : super(key: key);

  /// List of permissions to request.
  final List<PermissionData> permissions;

  /// The text to be displayed on the permission request screen.
  final CustomText? customText;

  /// App icon asset path to display in view header and splash view.
  final String? appIconAssetPath;

  /// The text style of the request message to be displayed in the view header.
  ///
  /// Reference `Theme.of(context).textTheme.titleLarge` by default.
  final TextStyle? requestMessageStyle;

  /// The color of the permission icon to be displayed in the list item.
  ///
  /// Reference `Theme.of(context).textTheme.bodyMedium.color` by default.
  final Color? permissionIconColor;

  /// The text style of the permission name to be displayed in the list item.
  ///
  /// Reference `Theme.of(context).textTheme.titleMedium` by default.
  final TextStyle? permissionNameStyle;

  /// The text style of the permission description to be displayed in the list item.
  ///
  /// Reference `Theme.of(context).textTheme.bodyMedium` by default.
  final TextStyle? permissionDescStyle;

  /// Builder for building custom splash view.
  final SplashViewBuilder? splashViewBuilder;

  /// Builder for building custom permission view header.
  final PermissionViewHeaderBuilder? permissionViewHeaderBuilder;

  /// Builder for building custom permission list item.
  final PermissionListItemBuilder? permissionListItemBuilder;

  /// The duration the splash view is displayed.
  final Duration splashDuration;

  /// The initialization function that is granted the required permissions and is to be executed.
  final InitFunction initFunction;

  /// The next page to go to when the required permissions are granted and the app initialization is successful.
  final Widget nextPage;

  @override
  State<StatefulWidget> createState() => _PermissionRequestPageState();
}

class _PermissionRequestPageState extends State<PermissionRequestPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final _filteredPermissions = <PermissionData>[];
  final _isSplashViewVisible = ValueNotifier<bool>(true);
  bool _isRequestingPermissions = false;

  void _initAnimationController() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();
  }

  void _checkPermissions(List<PermissionData> permissions) async {
    final prefs = await SharedPreferences.getInstance();
    final isCheckFirst = prefs.getBool('isCheckFirst') ?? true;

    PermissionRequestPageUtils.instance
        .checkPermissions(permissions)
        .then((result) {
      if (permissions.isEmpty || (result.isGranted && !isCheckFirst)) {
        _startAppInitialization();
        return;
      }

      _isSplashViewVisible.value = false;
    });
  }

  void _requestPermissions(List<PermissionData> permissions) async {
    if (_isRequestingPermissions) return;

    _isRequestingPermissions = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCheckFirst', false);

    PermissionRequestPageUtils.instance
        .requestPermissions(permissions)
        .then((result) {
      if (permissions.isEmpty || result.isGranted) {
        _startAppInitialization();
        return;
      }

      final contentBuffer = StringBuffer(
          widget.customText?.popupTextWhenPermissionDenied ??
              Localization.dictionary['msgWhenPermissionDenied']);
      contentBuffer.write('[');
      final deniedPermissions = result.deniedPermissions;
      for (var i = 0; i < result.deniedPermissions.length; i++) {
        if (i != 0) contentBuffer.write(',');
        contentBuffer.write(deniedPermissions[i].permissionType.defaultName());
      }
      contentBuffer.write(']');

      _showSystemDialog(content: contentBuffer.toString());
    }).whenComplete(() {
      _isRequestingPermissions = false;
    });
  }

  void _startAppInitialization() async {
    _isSplashViewVisible.value = true;

    final initResult = await widget.initFunction();
    if (initResult.complete) {
      Timer(widget.splashDuration, () {
        _animationController.reverse().then((_) {
          final route = MaterialPageRoute(builder: (_) => widget.nextPage);
          Navigator.pushReplacement(context, route);
        });
      });
    } else {
      if (initResult.showsError) {
        _showSystemDialog(
          content: initResult.errorMessage ??
              Localization.dictionary['appInitializationErrMsg'],
          positiveButtonText: Localization.dictionary['dialogRetryButtonText'],
          negativeButtonText: Localization.dictionary['dialogExitButtonText'],
          onPositiveButtonPressed: _startAppInitialization,
          onNegativeButtonPressed: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
          },
        );
      }
    }
  }

  void _showSystemDialog({
    required String content,
    String? positiveButtonText,
    String? negativeButtonText,
    VoidCallback? onPositiveButtonPressed,
    VoidCallback? onNegativeButtonPressed,
  }) {
    dialogActionBuilder({
      required String text,
      required VoidCallback? onPressed,
      bool positive = false,
    }) {
      final actionChild = Text(text);
      actionEvent() {
        onPressed?.call();
        Navigator.of(context).pop();
      }

      if (Platform.isAndroid) {
        return TextButton(onPressed: actionEvent, child: actionChild);
      } else {
        return CupertinoDialogAction(
          isDefaultAction: positive,
          onPressed: actionEvent,
          child: actionChild,
        );
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final dialogContent = Text(content);
        final dialogActions = <Widget>[];

        if (onNegativeButtonPressed != null) {
          final negativeAction = dialogActionBuilder(
            text: negativeButtonText ??
                Localization.dictionary['dialogNegativeButtonText'],
            onPressed: onNegativeButtonPressed,
            positive: false,
          );
          dialogActions.add(negativeAction);
        }
        final positiveAction = dialogActionBuilder(
          text: positiveButtonText ??
              Localization.dictionary['dialogPositiveButtonText'],
          onPressed: onPositiveButtonPressed,
          positive: true,
        );
        dialogActions.add(positiveAction);

        if (Platform.isAndroid) {
          return AlertDialog(
            content: dialogContent,
            actions: dialogActions,
          );
        } else {
          return CupertinoAlertDialog(
            content: dialogContent,
            actions: dialogActions,
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initAnimationController();
    PermissionRequestPageUtils.instance
        .filterByPlatform(widget.permissions)
        .then((filteredPermissions) {
      _filteredPermissions.addAll(filteredPermissions);
      _checkPermissions(filteredPermissions);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isSplashViewVisible,
      builder: (_, value, __) {
        return PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              transitionType: SharedAxisTransitionType.horizontal,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: value ? _buildSplashView() : _buildPermissionView(),
        );
      },
    );
  }

  Widget _buildSplashView() {
    Widget splashView;
    if (widget.splashViewBuilder != null) {
      splashView = widget.splashViewBuilder!();
    } else {
      splashView = Center(
        child: widget.appIconAssetPath == null
            ? const Icon(Icons.android_rounded, size: 80)
            : Image.asset(widget.appIconAssetPath!, height: 80),
      );
    }

    return FadeTransition(opacity: _fadeAnimation, child: splashView);
  }

  Widget _buildPermissionView() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildPermissionViewHeader(),
          Expanded(child: _buildPermissionListView()),
          _buildPermissionRequestButton(),
        ],
      ),
    );
  }

  Widget _buildPermissionViewHeader() {
    if (widget.permissionViewHeaderBuilder != null) {
      return widget.permissionViewHeaderBuilder!.call();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 0, 10),
          child: widget.appIconAssetPath == null
              ? const Icon(Icons.android_rounded, size: 50)
              : Image.asset(widget.appIconAssetPath!, height: 50),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
          child: Text(
            widget.customText?.permissionViewHeaderText ??
                Localization.dictionary['permissionViewHeaderText'],
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.merge(widget.requestMessageStyle),
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildPermissionListView() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _filteredPermissions.length,
      itemBuilder: (_, index) =>
          _buildPermissionListItem(_filteredPermissions[index]),
    );
  }

  Widget _buildPermissionListItem(PermissionData permission) {
    if (widget.permissionListItemBuilder != null) {
      return widget.permissionListItemBuilder!.call(permission);
    }

    final TextStyle? permissionNameStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(height: 1.2)
        .merge(widget.permissionNameStyle);
    final TextStyle? permissionDescStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.merge(widget.permissionDescStyle);
    final Color? permissionIconColor =
        widget.permissionIconColor ?? permissionDescStyle?.color;

    String permissionName =
        permission.permissionName ?? permission.permissionType.defaultName();
    final bool isNecessary = permission.isNecessary;
    if (isNecessary) {
      permissionName += ' ${Localization.necessary(isNecessary)}';
    }
    final String permissionDesc =
        permission.description ?? permission.permissionType.defaultDesc();
    final Icon permissionIcon =
        permission.permissionType.defaultIcon(color: permissionIconColor);

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          permissionIcon,
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(permissionName, style: permissionNameStyle),
                const SizedBox(height: 2),
                Text(permissionDesc, style: permissionDescStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionRequestButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(const RoundedRectangleBorder()),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          widget.customText?.permissionRequestButtonText ??
              Localization.dictionary['permissionRequestButtonText'],
          style: Theme.of(context).textTheme.labelLarge,
        ),
        onPressed: () => _requestPermissions(_filteredPermissions),
      ),
    );
  }

  @override
  void dispose() {
    _isSplashViewVisible.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
