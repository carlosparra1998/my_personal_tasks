import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../../view_model/theme_view_model.dart';
import '../dialogs/add_dialog.dart';

class HomeFloatingButton extends StatefulWidget {
  const HomeFloatingButton({super.key});

  @override
  State<HomeFloatingButton> createState() => _HomeFloatingButton();
}

class _HomeFloatingButton extends State<HomeFloatingButton> {
  @override
  Widget build(BuildContext context) {
    ThemeVM themeViewModel = context.watch<ThemeVM>();

    return FloatingActionButton(
      onPressed: () {
        addTaskDialog(context);
      },
      tooltip: 'Añadir nueva tarea',
      child: Icon(Icons.add, color: themeViewModel.themeColor,),
    );
  }
}
