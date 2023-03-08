import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/task_view_model.dart';

PreferredSizeWidget HomeAppBar(BuildContext context, String title){
  TaskVM taskViewModel = context.watch<TaskVM>();
  
  return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                color: Colors.black,
                icon: Icon(taskViewModel.getDarkTheme
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () {
                  taskViewModel.changeDarkTheme();
                })
          ],
        );
}