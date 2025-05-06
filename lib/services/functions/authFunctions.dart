import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_flutter/utils/string_const.dart';
import 'package:demo_flutter/utils/ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<void> handleSignUp({
  required BuildContext context,
  required String email,
  required String password,
  required String name,
  required int age,
}) async {

  print("::: handle sign up");

  showProgressDialogEasyLoading();
  try {
    final userCredential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;

    if(user == null) throw Exception("User creation failed");

    await FirebaseFirestore.instance
        .collection(FireStoreConstants.COLLECTION_USERS)
        .doc(user.uid)
        .set({
      FireStoreConstants.EMAIL: email,
      FireStoreConstants.NAME: name,
      FireStoreConstants.AGE: age,
    });

    getGreenSnackBar(context: context,message: "User Signed Up Successfully");

  } catch (error) {
    handleErrors(context, error);
  }finally{
    dismissProgressEasyLoading();
  }
}