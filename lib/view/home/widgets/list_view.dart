import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/stream_response.dart';
import '../../../utils/strings.dart' as s;
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          StreamResponse? streamTasks;
          streamTasks =
              ((snapshot.data) as StreamResponse?) ?? StreamResponse([]);

          return Container(
            color: themeViewModel.themeColor,
            child: Center(
                child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: streamTasks.response.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: themeViewModel.cardColor,
                  child: ListTile(
                    onTap: () {
                      modifyTaskDialog(
                        context,
                        streamTasks!.response[index].title,
                        streamTasks.response[index].description,
                        streamTasks.response[index].priorityLevel,
                        streamTasks.response[index].id,
                      );
                    },
                    contentPadding: const EdgeInsets.all(0),
                    leading: Checkbox(
                      side: BorderSide(
                        color: (streamTasks!.response[index].priorityLevel == 1)
                            ? Colors.red
                            : (streamTasks.response[index].priorityLevel == 2
                                ? Colors.orange
                                : Colors.blue), //your desire colour here
                        width: 2.5,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onChanged: (bool? value) {
                        taskViewModel.removeTaskInList(
                            index, streamTasks!.response[index].id);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(milliseconds: 2300),
                          content: const Text(s.taskComplete),
                          action: SnackBarAction(
                            label: s.undoAction,
                            onPressed: () {
                              taskViewModel.undoRemoveTaskInList();
                              setState(() {});
                            },
                          ),
                        ));
                      },
                      value: false,
                    ),
                    title: Text(
                      streamTasks.response[index].title,
                      style: TextStyle(color: themeViewModel.fontColor),
                    ),
                    subtitle: Text(
                      streamTasks.response[index].description,
                      style: TextStyle(color: themeViewModel.subtitleColor),
                    ),
                  ),
                );
              },
            )),
          );
        });
  }
}
