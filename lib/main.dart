import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'view_model/task_view_model.dart';


void main() {
   runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskVM()),
      ],
      child: const MyPersonalTasksApp(),
    ),
  );
}
