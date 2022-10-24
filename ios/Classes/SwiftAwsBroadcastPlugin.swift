import Flutter
import UIKit
import AmazonIVSBroadcast



public class SwiftAwsBroadcastPlugin: NSObject, FlutterPlugin, IVSBroadcastSession.Delegate {
    
    
    public func broadcastSession(_ session: IVSBroadcastSession, didChange state: IVSBroadcastSession.State) {
        
    }
    
    public func broadcastSession(_ session: IVSBroadcastSession, didEmitError error: Error) {
        
    }
    
    
    var broadcast:IVSBroadcastSession? = nil;
    
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "aws_broadcast", binaryMessenger: registrar.messenger())
    let instance = SwiftAwsBroadcastPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if call.method == "getPlatformVersion" { // 默认的实现
          print("iOS " + UIDevice.current.systemVersion)
        result("iOS " + UIDevice.current.systemVersion)
      }else if call.method == "getPermission" {// 获取权限
          print("iOS getPermission")
        getPermission()
      }else if call.method == "initBroadcast"{// 获取权限
          print("iOS initBroadcast") 
        initBroadcast()
      }else if call.method == "startBroadcast"{// 开启直播
        let arguments = call.arguments as! [String: String]
          startBroadcast(IVS_RTMPS_URL: arguments["IVS_RTMPS_URL"]!,IVS_STREAMKEY: arguments["IVS_STREAMKEY"]!)
      }else if call.method == "stopBroadcast"{// 关闭直播
          stopBroadcast()
        }
  }
    // 关闭直播
    func stopBroadcast(){
        broadcast?.stop()
    }
    
    //开启直播
    func startBroadcast(IVS_RTMPS_URL:String,IVS_STREAMKEY:String ){
        do{
            try broadcast?.start(with: URL(string: IVS_RTMPS_URL)!, streamKey: IVS_STREAMKEY)
        }catch{
            
        }
    }
    
    //初始化直播
    func initBroadcast(){
         do{
             broadcast = try IVSBroadcastSession(
              configuration: IVSPresets.configurations().standardLandscape(),
              descriptors: IVSPresets.devices().frontCamera(),
              delegate: self)
        }catch{
               
           }
    }
    
    //获取权限
    func getPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: break // permission already granted.
        case .notDetermined:
           AVCaptureDevice.requestAccess(for: .video) { granted in
               // permission granted based on granted bool.
           }
        case .denied, .restricted: break // permission denied.
        @unknown default: break // permissions unknown.
        }
    }
}
