import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MaterialApp(home: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooted Device Checker'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final isRooted = await checkRootStatus();
            final message = isRooted
                ? 'This device is rooted!'
                : 'This device is not rooted.';
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Root Status'),
                content: Text(message),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: const Text('Check Root Status'),
        ),
      ),
    );
  }
  Future<bool> checkRootStatus() async {
    try {
      const platform = MethodChannel('rooted_device_checker');
      final isRooted = await platform.invokeMethod('isDeviceRooted');
      return isRooted;
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
      return false;
    }
  }
}
