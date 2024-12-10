import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/screens/auth/social_auth_details_screen.dart';

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

static singUpWithGoogle(BuildContext context)async{
  try{
  final GoogleSignInAccount? gUser= await GoogleSignIn().signIn();

  if(gUser == null) return;

  final GoogleSignInAuthentication gAuth = await gUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: gAuth.accessToken,
    idToken: gAuth.idToken
  );

  final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  
  final userId = userCredential.user?.uid;

    if (userId != null) {
      // Navigate to SocialAuthDetailsScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SocialAuthDetailsScreen(userId: userId),
        ),
      );
    }

  }

  catch(e){
    print(e.toString());
  }
}


static signInWithGoogle(BuildContext context)async{
  try{
  final GoogleSignInAccount? gUser= await GoogleSignIn().signIn();

  if(gUser == null) return;

  final GoogleSignInAuthentication gAuth = await gUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: gAuth.accessToken,
    idToken: gAuth.idToken
  );

   await FirebaseAuth.instance.signInWithCredential(credential).catchError((e){
    Navigator.pushNamed(context, '/signIn');
  });
  
  print('Login Successfully');
  Navigator.pushNamed(context, '/dashboard');

  }
  catch(e){
    print(e.toString());
  }
}

static captureGoogleUserDetails({required BuildContext context,required String username,File? image,required String userId})async{
  try{
    if(username.isNotEmpty){
  await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
    String? downloadUrl = image != null ? await _uploadToStorage(image) : null;
    UserModel user = UserModel(email: FirebaseAuth.instance.currentUser!.email!, uid: userId, username: username,profileUrl: downloadUrl);
    await FirebaseFirestore.instance.collection('users').doc(userId).set(user.toJson()).catchError((e){
      Navigator.pushNamed(context, '/signup');
      print(e.toString());
    });
    Navigator.pushNamed(context,'/dashboard');
    print('registerd successully');
  }
  }
  catch(e){
    print('error occured');
    print(e.toString());
  }
}
}

