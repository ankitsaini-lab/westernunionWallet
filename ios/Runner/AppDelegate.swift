import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Block screenshots and screen recording on iOS
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(blockScreenCapture),
      name: UIScreen.capturedDidChangeNotification,
      object: nil
    )
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  @objc func blockScreenCapture() {
    if UIScreen.main.isCaptured {
      self.window?.isHidden = true
    } else {
      self.window?.isHidden = false
    }
  }

  override func applicationWillResignActive(_ application: UIApplication) {
    self.window?.isHidden = true
  }

  override func applicationDidBecomeActive(_ application: UIApplication) {
    self.window?.isHidden = false
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
