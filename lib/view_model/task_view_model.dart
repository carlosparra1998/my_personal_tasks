import 'package:flutter/material.dart';
import 'package:my_personal_tasks/repositories/cache/cache_repository.dart';

import '../model/task.dart';

class TaskVM with ChangeNotifier {

  List<Task> getTaskList() => CacheRepository().getTaskList;

  void setTaskList(List<Task> listTask) => CacheRepository().setTaskList = listTask;
  void setTaskInList(Task task) => CacheRepository().setTaskInList = task;
  void sortTaskList() => CacheRepository().sortTaskList();
  void clearAndPutList(List<Task> listTask) => CacheRepository().clearAndPutList(listTask);

}