import Flutter
import UIKit
//import SquareInAppPaymentsSDK

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
       // ✅ Set Square Application ID
    // SQIPInAppPaymentsSDK.squareApplicationID = "sandbox-sq0idb-17MXSY681Mo-gCp1iGORCg"

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
