import 'package:flutter/material.dart';
import 'package:permission_request_page/permission_request_page.dart';

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
  Future<InitResult> _initFunction() async {
    InitResult initResult;
    try {
      initResult = const InitResult(complete: true);
    } catch (error, stackTrace) {
      initResult =
          InitResult(complete: false, error: error, stackTrace: stackTrace);
    }

    return initResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PermissionRequestPage(
        permissions: const [
          PermissionData(
            permissionType: PermissionType.location,
            description: 'Required to provide location services.',
            isNecessary: true,
          ),
          PermissionData(
            permissionType: PermissionType.storage,
            description:
                'Required to access the internal storage of the smartphone.',
            isNecessary: false,
          ),
          PermissionData(
            permissionType: PermissionType.notification,
            description: 'Required to provide notifications.',
            isNecessary: false,
          ),
        ],
        initFunction: _initFunction,
        nextPage: Container(),
      ),
    );
  }
}
