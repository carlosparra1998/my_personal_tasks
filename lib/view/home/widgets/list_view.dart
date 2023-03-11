import 'package:flutter/material.dart';
import 'package:my_personal_tasks/repositories/cache/cache_repository.dart';
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
    final keys = GlobalKey<AnimatedListState>();

    return StreamBuilder<Object>(
        stream: taskViewModel.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          StreamResponse? streamTasks;
          streamTasks =
              ((snapshot.data) as StreamResponse?) ?? StreamResponse([]);

          Widget buildTask(StreamResponse streamTasks, int index,
              Animation<double> animation) {
            TaskVM taskViewModel = context.watch<TaskVM>();
            ThemeVM themeViewModel = context.watch<ThemeVM>();
            return FadeTransition(
              opacity: animation,
              child: Card(
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
                      keys.currentState!.removeItem(
                          index,
                          (context, animation) =>
                              buildTask(streamTasks!, index, animation),
                          duration: Duration(seconds: 1));
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
              ),
            );
          }

          return Container(
            color: themeViewModel.themeColor,
            child: Center(
                child: AnimatedList(
              key: keys,
              padding: const EdgeInsets.all(8),
              initialItemCount: streamTasks.response.length,
              itemBuilder: (context, index, animation) {
                return buildTask(streamTasks!, index, animation);
              },
            )),
          );
        });
  }
}
