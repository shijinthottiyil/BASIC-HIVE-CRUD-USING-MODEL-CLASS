import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './view/screens/screen_home.dart';
import './model/model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ModelAdapter());
  await Hive.openBox('box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenHome(),
    );
  }
}
