import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
          let flutterChannel = FlutterMethodChannel(name: "test.flutter",
                                                         binaryMessenger: controller.binaryMessenger)
          flutterChannel.setMethodCallHandler({
             (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
              
              // guard let args = call.arguments as? [String : Any] else {return}
              // let param1 = args["param1"] as! String;

              if(call.method == "getMessage"){
//                   Return from success
                  // result ("Received callback from iOS \(param1) ")
                  result ("Received callback from iOS")
                  
//                  If i want to through Error
//                  result(FlutterError(code: "-1",
//                                         message: "something went wrong",
//                                         details: "something went wrong"))
              }
              
//              Invoke Flutter Method from native side
              DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                       
                       DispatchQueue.main.async {
                         // Call the desired channel message here.
                       }
                       
                       flutterChannel.invokeMethod("fromNative", arguments: "{\"message\":\"Hello from native iOS\"}")
                   }
                   
               })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
