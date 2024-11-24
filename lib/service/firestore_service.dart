import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/models/task_model.dart';

class FirestoreService {

  static Future<void> addTask(TaskModel task,String userId) async {
  CollectionReference tasks = FirebaseFirestore.instance.collection('users').doc(userId).collection('tasks');
  
  print('A task with id ${task.id} has been created');
  await tasks.doc(task.id).set(task.toJson());
  print('added');
}

static Future<void> deleteTask(TaskModel task)async{

final id = task.id;
print(id);
DocumentReference taskRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('tasks').doc(task.id);
print('firestore id: ${taskRef.id}');

await taskRef.delete().then((value)=> print('Task(${task.title}) is deleted'));
}


/*static Future<void> loadTasks()async{

  final tasks = FirebaseFirestore.instance.collection('Tasks').get();


}*/

}