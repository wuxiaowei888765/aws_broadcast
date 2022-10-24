import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'aws_broadcast_method_channel.dart';

abstract class AwsBroadcastPlatform extends PlatformInterface {
  /// Constructs a AwsBroadcastPlatform.
  AwsBroadcastPlatform() : super(token: _token);

  static final Object _token = Object();

  static AwsBroadcastPlatform _instance = MethodChannelAwsBroadcast();

  /// The default instance of [AwsBroadcastPlatform] to use.
  ///
  /// Defaults to [MethodChannelAwsBroadcast].
  static AwsBroadcastPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AwsBroadcastPlatform] when
  /// they register themselves.
  static set instance(AwsBroadcastPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  void getPermission() {
    throw UnimplementedError('getPermission() has not been implemented.');
  }

  void initBroadcast() {
    throw UnimplementedError('initBroadcast() has not been implemented.');
  }

  void startBroadcast(String IVS_RTMPS_URL,String IVS_STREAMKEY) {
    throw UnimplementedError('startBroadcast() has not been implemented.');
  }

  void stopBroadcast() {
    throw UnimplementedError('stopBroadcast() has not been implemented.');
  }
}
