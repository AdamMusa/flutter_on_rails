import 'package:flutter/material.dart';
import 'package:flutter_on_rails/flutter_on_rails.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(url: "http://172.20.10.12:3000/demo/native"),
    ),
  );
}
