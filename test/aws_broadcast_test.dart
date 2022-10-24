import 'package:flutter_test/flutter_test.dart';
import 'package:aws_broadcast/aws_broadcast.dart';
import 'package:aws_broadcast/aws_broadcast_platform_interface.dart';
import 'package:aws_broadcast/aws_broadcast_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAwsBroadcastPlatform
    with MockPlatformInterfaceMixin
    implements AwsBroadcastPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  void getPermission() {
    // TODO: implement getPermission
  }

  @override
  void initBroadcast() {
    // TODO: implement initBroadcast
  }

  @override
  void stopBroadcast() {
    // TODO: implement stopBroadcast
  }

  @override
  void startBroadcast(String IVS_RTMPS_URL, String IVS_STREAMKEY) {
    // TODO: implement startBroadcast
  }
}

void main() {
  final AwsBroadcastPlatform initialPlatform = AwsBroadcastPlatform.instance;

  test('$MethodChannelAwsBroadcast is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAwsBroadcast>());
  });

  test('getPlatformVersion', () async {
    AwsBroadcast awsBroadcastPlugin = AwsBroadcast();
    MockAwsBroadcastPlatform fakePlatform = MockAwsBroadcastPlatform();
    AwsBroadcastPlatform.instance = fakePlatform;

    expect(await awsBroadcastPlugin.getPlatformVersion(), '42');
  });
}
