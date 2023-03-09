import 'package:fluttertoast/fluttertoast.dart';

import '../model/task.dart';

var priorities = ['🔴 Prioridad 1', '🟠 Prioridad 2', '🔵 Prioridad 3'];

List<Task> sortList(List<Task> taskList) {
  taskList.sort((a, b) => a.priorityLevel.compareTo(b.priorityLevel));
  return taskList;
}

List<Task> listTaskFromJson(List<Map<String, dynamic>> json) {
  List<Task> listTask = [];
  for (dynamic task in json) {
    listTask.add(Task(
        task['id'], task['title'], task['description'], task['priorityLevel']));
  }
  return listTask;
}

void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg, // message
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2);
}
