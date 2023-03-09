import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../../model/task.dart';
import '../../../repositories/firebase/firebase_repository.dart';
import '../../../view_model/task_view_model.dart';
import '../../../view_model/theme_view_model.dart';
import '../dialogs/modify_dialog.dart';

class HomeListView extends StatefulWidget {
  const HomeListView({super.key});

  @override
  State<HomeListView> createState() => _HomeListView();
}

class _HomeListView extends State<HomeListView> {
  @override
  Widget build(BuildContext context) {
    TaskVM taskViewModel = context.watch<TaskVM>();
    ThemeVM themeViewModel = context.watch<ThemeVM>();

    return StreamBuilder<Object>(
        stream: taskViewModel.stream,
        builder: (context, snapshot) {
          return (snapshot.connectionState != ConnectionState.waiting)
              ? Container(
                  color: themeViewModel.themeColor,
                  child: Center(
                      child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: taskViewModel.getTaskList().length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: themeViewModel.cardColor,
                        child: ListTile(
                          onTap: () {
                            modifyTaskDialog(
                              context,
                              taskViewModel.getTaskList()[index].title,
                              taskViewModel.getTaskList()[index].description,
                              taskViewModel.getTaskList()[index].priorityLevel,
                              taskViewModel.getTaskList()[index].id,
                            );
                          },
                          contentPadding: EdgeInsets.all(0),
                          leading: Checkbox(
                            side: BorderSide(
                              color: (taskViewModel
                                          .getTaskList()[index]
                                          .priorityLevel ==
                                      1)
                                  ? Colors.red
                                  : (taskViewModel
                                              .getTaskList()[index]
                                              .priorityLevel ==
                                          2
                                      ? Colors.orange
                                      : Colors.blue), //your desire colour here
                              width: 2.5,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onChanged: (bool? value) {
                              taskViewModel.removeTaskInList(
                                  index, taskViewModel.getTaskList()[index].id);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                duration: Duration(milliseconds: 2300),
                                content: Text('Tarea completada'),
                                action: SnackBarAction(
                                  label: 'Deshacer',
                                  onPressed: () {
                                    taskViewModel.undoRemoveTaskInList();
                                    setState(() {});
                                  },
                                ),
                              ));
                            },
                            value: false,
                          ),
                          title: Text(taskViewModel.getTaskList()[index].title, style: TextStyle(color: themeViewModel.fontColor),),
                          subtitle: Text(
                              taskViewModel.getTaskList()[index].description, style: TextStyle(color: themeViewModel.subtitleColor),),
                        ),
                      );
                    },
                  )),
                )
              : Center(child: CircularProgressIndicator());
        });
  }
}
