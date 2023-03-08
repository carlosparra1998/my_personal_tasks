
import 'package:flutter/material.dart';

import 'view/home/home_screen.dart';

class MyPersonalTasksApp extends StatelessWidget {
  const MyPersonalTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Personal Tasks',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomeScreen(title: 'My tasks'),
    );
  }
}
