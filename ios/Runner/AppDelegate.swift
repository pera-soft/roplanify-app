import UIKit
import Flutter
import FirebaseCore
import GoogleMaps
import flutter_config

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      var apikey: Optional<String> = FlutterConfigPlugin.env(for: "GOOGLE_MAPS_API_KEY");
      if apikey != nil {
          GMSServices.provideAPIKey(apikey!);
      }
     
      FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
