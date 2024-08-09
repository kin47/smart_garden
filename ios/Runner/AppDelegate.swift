import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyBWTrBuTBn56lXWa3JQU1j5YvqFcRwtQzY")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      if #available(iOS 10.0, *){
          UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      }
  }
}
