import '../../model/task.dart';
import '../../utils/utils.dart';

class CacheRepository {

  static List<Task> _taskList = [];

  static List<Task> _taskListTemp = [];

  List<Task> get getTaskList{
    return _taskList;
  }

  List<Task> get getTaskListTemp{
    return _taskListTemp;
  }

  set setTaskList(List<Task> listTask){
    _taskList = [];
    _taskList.addAll(listTask);
  }
  set setTaskInList(Task task){
     _taskList.add(task);
  }

  set setTaskListTemp(List<Task> listTaskTemp){
    _taskListTemp = listTaskTemp;
  }

  void removeTaskInList(int index){
    _taskListTemp = [];
    _taskListTemp.addAll(_taskList);
    _taskList.removeAt(index);
  }
   void undoRemoveTaskInList(){
    _taskList = [];
    _taskList.addAll(_taskListTemp);
   }

  void sortTaskList(){
    _taskList = sortList(_taskList);
  }

  void modifyTaskInList(int id, String title, String description, int priorityLevel){
    int index = _taskList.indexWhere((element) => element.id == id);
    _taskList[index].title = title;
    _taskList[index].description = description;
    _taskList[index].priorityLevel = priorityLevel;
  }
}
