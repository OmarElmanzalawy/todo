import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo/models/user_model.dart';

class AuthService {

  static Future<String> _uploadToStorage(File image)async{
    Reference reference = FirebaseStorage.instance.ref().child('profilePics').child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

 static void registerUser({required String username,required String email,required String password, File? image })async{
    try{
      if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty){
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    String? downloadUrl = image != null ? await _uploadToStorage(image) : null;
    UserModel user = UserModel(email: email, profileUrl: downloadUrl, uid: userCredential.user!.uid, username: username);
    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set(user.toJson());
    print('registerd successully');
      }
      else{

      }
    }
    catch(e){
      //Display snackbar
    }
  }

}