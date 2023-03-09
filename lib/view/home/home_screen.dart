import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_tasks/repositories/cache/cache_repository.dart';
import 'package:my_personal_tasks/view/home/dialogs/modify_dialog.dart';
import 'package:my_personal_tasks/view/home/widgets/app_bar.dart';
import 'package:provider/provider.dart';

import '../../model/task.dart';
import '../../utils/utils.dart';
import '../../view_model/task_view_model.dart';
import 'widgets/floating_button.dart';
import 'widgets/list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HomeAppBar(context, widget.title),
        body: const HomeListView(),
        floatingActionButton: const HomeFloatingButton());
  }
}
