import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coinsProvider = StateNotifierProvider<CoinsNotifier,double>((ref) => CoinsNotifier()..initialize());

class CoinsNotifier extends StateNotifier<double>{

  CoinsNotifier() : super(0);

  Future<void> initialize()async{
    await fetchCoinsFromFireStore();
  }
  
  Future<void> taskReward({double reward = 10})async{
    state += reward;
    await updateFireStoreBalance(state);
  }

  Future<void> updateFireStoreBalance(double balance)async{
    final user = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'balance': balance,
    });
  }

  Future<void> fetchCoinsFromFireStore()async{
    final doc = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

    state = doc.get('balance');
  }

}