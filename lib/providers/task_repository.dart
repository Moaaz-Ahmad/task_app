import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_app/models/task.dart';

class TaskRepository {
  final FirebaseFirestore firestore;

  TaskRepository({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addTask(Task task) {
    return firestore.collection('tasks').doc(task.id).set(task.toFirestore());
  }

  Future<void> updateTask(Task task) {
    return firestore.collection('tasks').doc(task.id).update(task.toFirestore());
  }

  Future<void> deleteTask(String taskId) {
    return firestore.collection('tasks').doc(taskId).delete();
  }

  Stream<List<Task>> getTasks() {
    return firestore.collection('tasks').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Task.fromFirestore(doc.data())).toList();
    });
  }
}
