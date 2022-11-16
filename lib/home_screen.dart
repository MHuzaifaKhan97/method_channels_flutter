import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String message = "";
  String nativeToFlutter = "";

  static const platform = MethodChannel('test.flutter');

  @override
  initState() {
    super.initState();
    initNativeMethodHandler();
  }

  Future<void> initNativeMethodHandler() async {
    platform.setMethodCallHandler((call) async {
      final argument = call.arguments.toString();
      switch (call.method) {
        case "fromNative":
          Map<String, dynamic> json =
              jsonDecode(argument) as Map<String, dynamic>;
          nativeToFlutter = json["message"];
          break;
      }
      setState(() {});
    });
  }

  Future<void> getMessageFromNative() async {
    try {
      message = await platform.invokeMethod("getMessage", {"param1": 22});
    } on PlatformException catch (e) {
      message = "failed to call getMessage $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Method Channels Example"),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await getMessageFromNative();
                    setState(() {});
                  },
                  child: const Text("Get Message from native")),
              const SizedBox(height: 30),
              Text(message),
              const SizedBox(height: 30),
              Text(nativeToFlutter),
            ],
          )),
    );
  }
}
