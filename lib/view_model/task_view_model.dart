import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_personal_tasks/repositories/cache/cache_repository.dart';
import 'package:my_personal_tasks/repositories/firebase/firebase_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../model/stream_response.dart';
import '../model/task.dart';

class TaskVM with ChangeNotifier {

  int _idLast = 0;

  get getIdLast => _idLast;

  void setIdLast(int id){
    _idLast = id;
  }

  final StreamController<StreamResponse> _streamController =
      BehaviorSubject<StreamResponse>();

  Stream<StreamResponse> get stream {
    if (!_streamController.hasListener) {
      enableStream();
    }
    return _streamController.stream;
  }

  void enableStream() async{
    List<Task> taskList = await FirebaseRepository().getTaskList();
    

    if(taskList.isNotEmpty){
      setIdLast(taskList.last.id);
      setTaskList(taskList);
      _streamController.add(
          StreamResponse("OK", taskList));
    }
    else{
      _streamController.add(
          StreamResponse("KO", getTaskList()));
    }

    notifyListeners();

  }

  List<Task> getTaskList() => CacheRepository().getTaskList;
  List<Task> getTaskListTemp() => CacheRepository().getTaskListTemp;

  void setTaskList(List<Task> listTask) {
    CacheRepository().setTaskList = listTask;
    CacheRepository().sortTaskList();
    notifyListeners();
  }

  void setTaskListTemp(List<Task> listTaskTemp) {
    CacheRepository().setTaskList = listTaskTemp;
    notifyListeners();
  }

  void setTaskInList(Task task) {
    CacheRepository().setTaskInList = task;
    FirebaseRepository().setTaskInList(task);
    setIdLast(task.id);
    CacheRepository().sortTaskList();
    notifyListeners();
  }

  void modifyTaskInList(
      int id, String title, String description, int priorityLevel) {
    CacheRepository()
        .modifyTaskInList(id, title, description, priorityLevel);
    FirebaseRepository().setTaskInList(Task(id, title, description, priorityLevel));
    sortTaskList();
    notifyListeners();
  }

  void removeTaskInList(int index, int id) {
    CacheRepository().removeTaskInList(index);
    FirebaseRepository().deleteTaskInList(id);
    notifyListeners();
  }

  void undoRemoveTaskInList() {
    CacheRepository().undoRemoveTaskInList();
    FirebaseRepository().setTaskList(CacheRepository().getTaskList);
    notifyListeners();
  }

  void sortTaskList() {
    CacheRepository().sortTaskList();
    notifyListeners();
  }
}
