import 'aws_broadcast_platform_interface.dart';

class AwsBroadcast {
  Future<String?> getPlatformVersion() {
    return AwsBroadcastPlatform.instance.getPlatformVersion();
  }

  void getPermission() {
    AwsBroadcastPlatform.instance.getPermission();
  }

  void startBroadcast(String IVS_RTMPS_URL,String IVS_STREAMKEY) {
    AwsBroadcastPlatform.instance.startBroadcast(IVS_RTMPS_URL,IVS_STREAMKEY);
  }

  void stopBroadcast() {
    AwsBroadcastPlatform.instance.stopBroadcast();
  }

  void initBroadcast() {
    AwsBroadcastPlatform.instance.initBroadcast();
  }
}
