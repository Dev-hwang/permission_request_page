import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_request_page/models/permission_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/init_result.dart';
import 'models/permission_data.dart';
import 'permission_request_page_utils.dart';

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

  /// App icon asset path to display in view header and splash view.
  final String? appIconAssetPath;

  /// The text style of the request message to be displayed in the view header.
  final TextStyle? requestMessageStyle;

  /// The color of the permission icon to be displayed in the list item.
  final Color? permissionIconColor;

  /// The text style of the permission name to be displayed in the list item.
  final TextStyle? permissionNameStyle;

  /// The text style of the permission description to be displayed in the list item.
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

      const String contentPrefix = '어플리케이션을 사용하려면 필수 표시된 권한(';
      const String contentSuffix = ')을 허용해야 합니다.';
      final deniedPermissions = result.deniedPermissions;
      final sb = StringBuffer();
      for (var i = 0; i < deniedPermissions.length; i++) {
        if (i != 0) sb.write(', ');
        sb.write(deniedPermissions[i].permissionType.defaultName());
      }

      _showSystemDialog(content: contentPrefix + sb.toString() + contentSuffix);
    }).whenComplete(() {
      _isRequestingPermissions = false;
    });
  }

  void _startAppInitialization() async {
    _isSplashViewVisible.value = true;

    final initResult = await widget.initFunction();
    if (initResult.complete) {
      Timer(widget.splashDuration, () async {
        await _animationController.reverse();
        final route = MaterialPageRoute(builder: (_) => widget.nextPage);
        Navigator.pushReplacement(context, route);
      });
    } else {
      if (initResult.showsError) {
        _showSystemDialog(
          content: initResult.errorMessage ?? '앱 초기화에 실패하여 앱을 시작할 수 없습니다.',
          positiveButtonText: '재시도',
          negativeButtonText: '종료',
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
    Widget dialogActionBuilder({
      required String text,
      required VoidCallback? onPressed,
      bool positive = false,
    }) {
      if (Platform.isAndroid) {
        return TextButton(child: Text(text), onPressed: onPressed);
      } else {
        return CupertinoDialogAction(
          isDefaultAction: positive,
          child: Text(text),
          onPressed: onPressed,
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
            text: negativeButtonText ?? '취소',
            onPressed: onNegativeButtonPressed,
            positive: false,
          );
          dialogActions.add(negativeAction);
        }
        final positiveAction = dialogActionBuilder(
          text: positiveButtonText ?? '확인',
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
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  void dispose() {
    _isSplashViewVisible.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
