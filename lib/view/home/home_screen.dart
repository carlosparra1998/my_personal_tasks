import 'package:flutter/material.dart';
import 'package:my_personal_tasks/view/home/widgets/app_bar.dart';

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
        appBar: homeAppBar(context, widget.title),
        body: const HomeListView(),
        floatingActionButton: const HomeFloatingButton());
  }
}
