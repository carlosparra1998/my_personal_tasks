import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/home/home_screen.dart';
import 'view_model/theme_view_model.dart';

class MyPersonalTasksApp extends StatelessWidget {
  const MyPersonalTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Personal Tasks',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomeScreen(title: 'My Personal Tasks'),
    );
  }
}
