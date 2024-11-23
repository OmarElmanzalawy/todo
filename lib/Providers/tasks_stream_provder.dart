import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/task_model.dart';

final tasksStreamProvider = StreamProvider<List<TaskModel>>((ref) {
  final tasksStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('tasks')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      return TaskModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  });
  return tasksStream;
});