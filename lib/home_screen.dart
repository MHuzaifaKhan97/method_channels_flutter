import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {},
                  child: const Text("Get Message from native")),
              const SizedBox(height: 30),
              Text(message),
              const SizedBox(height: 30),
            ],
          )),
    );
  }
}
