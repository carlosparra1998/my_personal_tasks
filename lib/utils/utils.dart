import '../model/task.dart';

var prioridades = ['🔴 Prioridad 1', '🟠 Prioridad 2', '🔵 Prioridad 3'];

List<Task> taskList = [
  Task(1, "Hacer colada", "Hacer colada bien", 1),
  Task(2, "Hacer chocolate", "Hacer chocolate bien", 2),
  Task(3, "Hacer codigo", "Hacer codigo bien", 3),
  Task(4, "Hacer VOlar", "Hacer VOlar bien", 2)
];

List<Task> sortList(List<Task> taskList) {
  taskList.sort((a, b) => a.priorityLevel.compareTo(b.priorityLevel));
  return taskList;
}