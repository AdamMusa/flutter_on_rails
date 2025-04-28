import 'package:flutter/material.dart';
import 'package:flutter_on_rails/flutter_on_rails.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MaterialApp(home: MainScreen()));
}
