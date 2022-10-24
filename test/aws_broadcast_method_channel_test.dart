import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aws_broadcast/aws_broadcast_method_channel.dart';

void main() {
  MethodChannelAwsBroadcast platform = MethodChannelAwsBroadcast();
  const MethodChannel channel = MethodChannel('aws_broadcast');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
