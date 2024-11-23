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

 static Future<bool> registerUser({required String username,required String email,required String password, File? image })async{
    try{
      if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty){
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user!.updateDisplayName(username);
    String? downloadUrl = image != null ? await _uploadToStorage(image) : null;
    UserModel user = UserModel(email: email, uid: userCredential.user!.uid, username: username,profileUrl: downloadUrl);
    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set(user.toJson());
    print('registerd successully');
    return true;
      }
      else{
       return false;
      }
    }
    catch(e){
      //Display snackbar
      return false;
    }
  }

static Future<bool> login({required String email,required String password})async{

  try{
    if(email.isNotEmpty && password.isNotEmpty){
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return true;
    }
    return false;
  }
  catch (e){
    print(e.toString());
    return false;
  }

}

}