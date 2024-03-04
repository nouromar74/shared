import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
  let channel = FlutterMethodChannel(name: "rooted_device_checker", binaryMessenger: controller.binaryMessenger)
  channel.setMethodCallHandler { (call, result) in
      if call.method == "isDeviceRooted" {
          let isRooted = self.checkRootStatus()
          result(isRooted)
      } else {
          result(FlutterMethodNotImplemented)
      }
  }

  private func checkRootStatus() -> Bool {
      // Implement your root-checking logic here for iOS
      return false
  }
}
