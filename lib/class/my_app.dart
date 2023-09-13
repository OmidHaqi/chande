import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("reBase App")),
        body:  const Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}
