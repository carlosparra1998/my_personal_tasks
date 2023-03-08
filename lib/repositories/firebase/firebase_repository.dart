import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/task.dart';
import '../../utils/utils.dart';

class FirebaseRepository {
  static var collection = FirebaseFirestore.instance.collection('tasks');

  Future<List<Task>> getTaskList() async {
    try {
      var snapshot = await collection.get();
      return listTaskFromJson(snapshot.docs.map((doc) => doc.data()).toList());
    } on Exception {
      return [];
    }
  }

  Future<void> setTaskList(List<Task> taskList) async {
    try {
      for (Task task in taskList) {
        await collection.doc(task.id.toString()).set({
          "id": task.id,
          "title": task.title,
          "description": task.description,
          "priorityLevel": task.priorityLevel
        });
      }
    } on Exception {}
  }

  Future<void> setTaskInList(Task task) async {
    try {
      await collection.doc(task.id.toString()).set({
        "id": task.id,
        "title": task.title,
        "description": task.description,
        "priorityLevel": task.priorityLevel
      });
    } on Exception {}
  }

  Future<void> deleteTaskInList(int id) async {
    try {
      await collection.doc(id.toString()).delete();
    } on Exception {}
  }
}
