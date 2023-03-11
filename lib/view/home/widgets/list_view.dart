import 'package:flutter/material.dart';
import 'package:my_personal_tasks/repositories/cache/cache_repository.dart';
import 'package:provider/provider.dart';

import '../../../model/stream_response.dart';
import '../../../model/task.dart';
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

          Widget buildTask(Task task, int index, Animation<double> animation,
              bool functional) {
            TaskVM taskViewModel = context.watch<TaskVM>();
            ThemeVM themeViewModel = context.watch<ThemeVM>();
            return FadeTransition(
              opacity: animation,
              child: Card(
                color: themeViewModel.cardColor,
                child: ListTile(
                  onTap: () {
                    if (functional) {
                      modifyTaskDialog(
                        context,
                        task.title,
                        task.description,
                        task.priorityLevel,
                        task.id,
                      );
                    }
                  },
                  contentPadding: const EdgeInsets.all(0),
                  leading: Checkbox(
                    key : Key('completeCheck'),
                    activeColor: (task.priorityLevel == 1)
                        ? Colors.red
                        : (task.priorityLevel == 2
                            ? Colors.orange
                            : Colors.blue),
                    side: BorderSide(
                      color: (task.priorityLevel == 1)
                          ? Colors.red
                          : (task.priorityLevel == 2
                              ? Colors.orange
                              : Colors.blue), //your desire colour here
                      width: 2.5,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onChanged: (_) {
                      if (functional) {
                        keys.currentState!.removeItem(
                            index,
                            (context, animation) =>
                                buildTask(task, index, animation, false),
                            duration: const Duration(milliseconds: 450));

                        taskViewModel.removeTaskInList(index, task.id);
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
                      }
                    },
                    value: !functional,
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(color: themeViewModel.fontColor),
                  ),
                  subtitle: Text(
                    task.description,
                    style: TextStyle(color: themeViewModel.subtitleColor),
                  ),
                ),
              ),
            );
          }

          return Container(
            color: themeViewModel.themeColor,
            child: Center(
                key: Key("listView"),
                child: AnimatedList(
                  key: keys,
                  padding: const EdgeInsets.all(8),
                  initialItemCount: streamTasks.response.length,
                  itemBuilder: (context, index, animation) {
                    return buildTask(
                        streamTasks!.response[index], index, animation, true);
                  },
                )),
          );
        });
  }
}
