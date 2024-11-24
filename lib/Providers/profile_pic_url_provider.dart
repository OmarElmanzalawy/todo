import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profilePicUrlProvider = StateNotifierProvider<ProfilePicUrlNotifier,String?>((ref) {
  return ProfilePicUrlNotifier();
});

class ProfilePicUrlNotifier extends StateNotifier<String?> {
  ProfilePicUrlNotifier(): super(null);
  
  Future<void> fetchProfilePicture()async{
  final DocumentSnapshot docRef = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
   state = docRef.get('profilephoto');
}


}