import '../../model/task.dart';
import '../../utils/utils.dart';

class CacheRepository {
  final prioridades = ['🔴 Prioridad 1', '🟠 Prioridad 2', '🔵 Prioridad 3'];

  static List<Task> _taskList = [
    Task(1, "Hacer colada", "Hacer colada bien", 1),
    Task(2, "Hacer chocolate", "Hacer chocolate bien", 2),
    Task(3, "Hacer codigo", "Hacer codigo bien", 3),
    Task(4, "Hacer VOlar", "Hacer VOlar bien", 2)
  ];

  List<Task> get getTaskList{
    return _taskList;
  }

  set setTaskList(List<Task> listTask){
    _taskList = listTask;
  }
  set setTaskInList(Task task){
     _taskList.add(task);
  }

  void sortTaskList(){
    _taskList = sortList(_taskList);
  }
  void clearAndPutList(List<Task> taskList){
    _taskList = [];
    _taskList.addAll(taskList);
  }
}
