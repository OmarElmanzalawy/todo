import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/utils/app_utils.dart';

class FirestoreService {

  static Future<void> addTask(TaskModel task,String userId) async {
  CollectionReference tasks = FirebaseFirestore.instance.collection('users').doc(userId).collection('tasks');
  
  print('A task with id ${task.id} has been created');
  await tasks.doc(task.id).set(task.toJson());
  print('added');
}

static Future<void> deleteTask(TaskModel task)async{
print('FIRESTORE DELETE');
final id = task.id;
print(id);
DocumentReference taskRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('tasks').doc(task.id);
print('firestore id: ${taskRef.id}');

await taskRef.delete().then((value)=> print('Task(${task.title}) is deleted')).catchError((error){print(error);});
}

static Future<void> completeTask(TaskModel task)async{
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users')
  .doc(uid).collection('tasks').doc(task.id).get();

  if((doc.data() as dynamic)['status'] == TaskStatus.unfinished.toString()){
    await  FirebaseFirestore.instance.collection('users')
  .doc(uid).collection('tasks').doc(task.id).update({
    'status': TaskStatus.finished.toString()
  }).then((_)=> print('Task Completed')).catchError((e)=> print(e));
  }
  else{
    print('Task is already completed');
  }

}

static Future<void> editTask({
    required TaskModel taskModel, 
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    TimeOfDay? deadline,
    required TaskStatus status,})
    async{

    final String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(uid)
    .collection('tasks').doc(taskModel.id).get();

    await FirebaseFirestore.instance.collection('users').doc(uid)
    .collection('tasks').doc(taskModel.id).update(
      {
        'description': descriptionController.text,
        'title': titleController.text,
        'deadline': deadline!= null ? AppUtils.timeOfDayToString(deadline!) : null
      });



    }

  static Future<void> clearTasks()async{
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).collection('tasks').get().then((snapshots){
     for(DocumentSnapshot doc in snapshots.docs){
        doc.reference.delete();
     }
    }
    );
  }

static Future<void> loadTasks()async{


}

}