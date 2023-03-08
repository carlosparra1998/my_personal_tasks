import '../model/task.dart';

List<Task> sortList(List<Task> taskList) {
  taskList.sort((a, b) => a.priorityLevel.compareTo(b.priorityLevel));
  return taskList;
}