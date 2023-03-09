import 'package:fluttertoast/fluttertoast.dart';

import '../model/task.dart';
import 'strings.dart' as s;

var priorities = [s.priority1, s.priority2, s.priority3];

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
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2);
}
