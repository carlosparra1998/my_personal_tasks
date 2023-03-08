import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../dialogs/add_dialog.dart';

class HomeFloatingButton extends StatefulWidget {
  const HomeFloatingButton({super.key});

  @override
  State<HomeFloatingButton> createState() => _HomeFloatingButton();
}

class _HomeFloatingButton extends State<HomeFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        addTaskDialog(context);
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
