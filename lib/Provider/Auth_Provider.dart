import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_property/Models/FirebaseUserModel.dart';
import 'package:e_property/Screens/Forgot/forgot_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../Screens/Home/Home_Screen.dart';
import '../Screens/Login/loginScreen.dart';

class AuthProvider extends ChangeNotifier {
  // SignUp Screen

  signUp(
    BuildContext context, {
    required String? email,
    required String? password,
    required File? image,
    required String? downloadUrl,
    required String? name,
    required int? phone,
    required String? city,
  }) async {
    try {
      if (image == null) {
        Fluttertoast.showToast(msg: "please pick an image");
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.toString(), password: password.toString());

        // add image in Strorage
        final postID = DateTime.now().microsecondsSinceEpoch.toString();
        // current user id
        final currentUser = FirebaseAuth.instance.currentUser;
        // add image in specific file in storage
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('${currentUser?.uid}/images')
            .child('image');

        await ref.putFile(image);
        // download image url and store in variable
        downloadUrl = await ref.getDownloadURL();

        // Create Firebase
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

        // call UserModel
        UserModel userModel = UserModel();

        userModel.name = name;
        userModel.city = city;
        userModel.email = email;
        userModel.number = phone;
        userModel.uid = currentUser?.uid;
        userModel.image = downloadUrl;

        // send data to firebase
        await firebaseFirestore
            .collection("user")
            .doc(currentUser?.uid)
            .set(userModel.toMap());

        Fluttertoast.showToast(msg: "Register Successfully");

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Navigator.pop(context);
        print("please enter Strong Password");
        Fluttertoast.showToast(msg: "please enter Strong Password");
      } else if (e.code == 'email-already-in-use') {
        Navigator.pop(context);
        print('This Email already have taken');
        Fluttertoast.showToast(msg: "This Email already have taken");
      }
    }

    notifyListeners();
  }

  // Login Screen
  login(BuildContext context,
      {required String? email, required String? password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());

      Fluttertoast.showToast(msg: "Login Successfully");

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("no user Found for that email");
        Fluttertoast.showToast(msg: 'No user found for that email');
      } else if (e.code == 'wrong-password') {
        print("wrong password");
        Fluttertoast.showToast(msg: "your password is wrong");
      }
    }
    notifyListeners();
  }

  // Forgot Password

  forgot(BuildContext context, {required String? email}) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.toString());
      Fluttertoast.showToast(msg: "Password Send Successfully");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ForgotScreen()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.pop(context);
        print("no user found for that email");
        Fluttertoast.showToast(msg: "no user found for that email");
      }
    }
    notifyListeners();
  }
}
