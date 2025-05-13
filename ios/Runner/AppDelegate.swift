import UIKit
import Flutter
import flutter_branch_sdk

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    // Correct: Use instance of FlutterBranchSdkPlugin
    FlutterBranchSdkPlugin.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions ?? [:])

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    FlutterBranchSdkPlugin.sharedInstance().application(application, open: url, options: options)
    return super.application(application, open: url, options: options)
  }

  override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    FlutterBranchSdkPlugin.sharedInstance().application(application, continue: userActivity, restorationHandler: restorationHandler as! ([Any]) -> Void)
    return super.application(application, continue: userActivity, restorationHandler: restorationHandler)
  }
}
