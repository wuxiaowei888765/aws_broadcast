import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'aws_broadcast_platform_interface.dart';

/// An implementation of [AwsBroadcastPlatform] that uses method channels.
class MethodChannelAwsBroadcast extends AwsBroadcastPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('aws_broadcast');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> stopBroadcast() async {
    await methodChannel.invokeMethod('stopBroadcast');
  }

  @override
  Future<void> startBroadcast(String IVS_RTMPS_URL,String IVS_STREAMKEY) async {
    await methodChannel.invokeMethod('startBroadcast',{"IVS_RTMPS_URL":IVS_RTMPS_URL,"IVS_STREAMKEY":IVS_STREAMKEY});
  }

  @override
  Future<void> initBroadcast() async {
    await methodChannel.invokeMethod('initBroadcast');
  }

  @override
  Future<void> getPermission() async {
    await methodChannel.invokeMethod('getPermission');
  }
}
