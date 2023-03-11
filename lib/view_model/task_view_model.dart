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

  void setIdLast(int id) {
    _idLast = id;
  }

  final StreamController<StreamResponse> _streamController =
      BehaviorSubject<StreamResponse>();

  Stream<StreamResponse> get stream {
    if (!_streamController.hasListener) {
      firebaseToCache();
    }
    return _streamController.stream;
  }

  void firebaseToCache() async {
    List<Task> taskList = await FirebaseRepository().getTaskList();

    if (taskList.isNotEmpty) {
      setIdLast(taskList.last.id);
      setTaskList(taskList);
    }

    updateStream();
    notifyListeners();
  }

  void updateStream() {
    _streamController.add(StreamResponse(getTaskList()));
  }

  List<Task> getTaskList() => CacheRepository().getTaskList;

  void setTaskList(List<Task> listTask) {
    CacheRepository().setTaskList = listTask;
    CacheRepository().sortTaskList();

    updateStream();
    notifyListeners();
  }

  void setTaskInList(Task task) {
    CacheRepository().setTaskInList = task;
    FirebaseRepository().setTaskInList(task);
    setIdLast(task.id);
    CacheRepository().sortTaskList();

    updateStream();
    notifyListeners();
  }

  void modifyTaskInList(
      int id, String title, String description, int priorityLevel) {
    CacheRepository().modifyTaskInList(id, title, description, priorityLevel);
    FirebaseRepository()
        .setTaskInList(Task(id, title, description, priorityLevel));
    CacheRepository().sortTaskList();

    updateStream();
    notifyListeners();
  }

  void removeTaskInList(int index, int id) {
    CacheRepository().removeTaskInList(index);
    FirebaseRepository().deleteTaskInList(id);

    updateStream();
    //notifyListeners(); => Para la animación no es necesario, se actualiza el UI
  }

  void undoRemoveTaskInList() {
    CacheRepository().undoRemoveTaskInList();
    FirebaseRepository().setTaskList(CacheRepository().getTaskList);
    
    updateStream();
    notifyListeners();
  }
}
