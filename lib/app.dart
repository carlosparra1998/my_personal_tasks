import 'package:flutter/material.dart';

import 'utils/strings.dart' as s;
import 'view/home/home_screen.dart';

class MyPersonalTasksApp extends StatelessWidget {
  const MyPersonalTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: s.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomeScreen(title: s.appTitle),
    );
  }
}
