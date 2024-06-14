import 'package:flutter/material.dart';
import 'package:permission_request_page/permission_request_page.dart';

// 1. Declare the required permissions in your app.
const List<PermissionData> _kPermission = [
  PermissionData(
    permissionType: PermissionType.location,
    permissionName: 'Location',
    description: 'Required to provide location services.',
    isNecessary: true,
  ),
  PermissionData(
    permissionType: PermissionType.storage,
    permissionName: 'Storage',
    description: 'Required to access the internal storage of the smartphone.',
    isNecessary: false,
  ),
  PermissionData(
    permissionType: PermissionType.notification,
    permissionName: 'Notification',
    description: 'Required to provide notifications.',
    isNecessary: false,
  ),
];

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // 2. Write an init function to execute when all required permissions are granted.
  Future<InitResult> _initFunction() async {
    InitResult initResult;
    try {
      // Write your app initialization code.
      initResult = const InitResult(complete: true);
    } catch (error, stackTrace) {
      // Write code to handle app initialization errors.
      initResult =
          InitResult(complete: false, error: error, stackTrace: stackTrace);
    }

    // If the complete value of InitResult is true, it navigates to the nextPage.
    return initResult;
  }

  @override
  Widget build(BuildContext context) {
    // 3. Add a PermissionRequestPage widget under Scaffold.
    return Scaffold(
      body: PermissionRequestPage(
        permissions: _kPermission,
        initFunction: _initFunction,
        nextPage: Container(),
      ),
    );
  }
}
