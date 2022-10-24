import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:aws_broadcast/aws_broadcast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _awsBroadcastPlugin = AwsBroadcast();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _awsBroadcastPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  _awsBroadcastPlugin.getPlatformVersion();
                },
                child: Text("获取版本")),
            TextButton(
                onPressed: () {
                  _awsBroadcastPlugin.getPermission();
                },
                child: Text("请求权限")),
            TextButton(
                onPressed: () {
                  _awsBroadcastPlugin.startBroadcast(
                      "rtmps://12e645927ee4.global-contribute.live-video.net:443/app/",
                      "sk_eu-west-1_XeMLms18ozDs_vJY5GSUmoGvPJcm6FIWvfnbZdw3Zvx");
                },
                child: Text("开始直播")),
            TextButton(
                onPressed: () {
                  _awsBroadcastPlugin.stopBroadcast();
                },
                child: Text("停止直播")),
            TextButton(
                onPressed: () {
                  _awsBroadcastPlugin.initBroadcast();
                },
                child: Text("初始化")),
          ],
        ),
      ),
    );
  }
}
