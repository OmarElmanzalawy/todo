import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/models/task_model.dart';

class FirestoreService {

  static Future<void> addTask(TaskModel task,WidgetRef ref) async {
  CollectionReference tasks = FirebaseFirestore.instance.collection('Tasks');
  
  await tasks.doc(task.id.toString()).set(task.toJson()).whenComplete((){
    ref.read(tasksProvider.notifier).addTasks(task);
  });
  print('added');
}

/*static Future<void> loadTasks()async{

  final tasks = FirebaseFirestore.instance.collection('Tasks').get();


}*/

}