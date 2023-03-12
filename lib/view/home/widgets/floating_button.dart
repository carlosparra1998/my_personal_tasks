import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/strings.dart' as s;
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
      key: const Key(s.fab1Key),
      onPressed: () {
        addTaskDialog(context);
      },
      tooltip: s.addNewTask,
      child: Icon(Icons.add, color: themeViewModel.themeColor,),
    );
  }
}
