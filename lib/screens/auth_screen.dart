import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = 'auth-screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  var _isFbLoading = false;
  void _submitAuthForm(String email, String userName, String password,
      bool isLogin, File image) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user.uid + 'jpg');
        await ref.putFile(image);
        final photoUrl = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set(
                {'username': userName, 'email': email, 'user_image': photoUrl});
      }
    } on PlatformException catch (error) {
      var message = 'An error occured, Please check your credentials.';
      if (error != null) {
        message = error.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print(error);
    }
  }

  Future<void> _fbLogin() async {
    setState(() {
      _isFbLoading = true;
    });
    try {
      AccessToken accessToken = await FacebookAuth.instance.login();
      // print(accessToken.toJson());

      final AuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.token);
      UserCredential authResult;
      authResult = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user.uid)
          .set({
        'username': authResult.user.displayName,
        'email': authResult.user.email,
        'user_image': authResult.user.photoURL
      });
    } on FacebookAuthException catch (e) {
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
      setState(() {
        _isFbLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Image.asset('assets/images/loading.jpg')),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AuthForm(_submitAuthForm, _isLoading, _fbLogin, _isFbLoading),
              ],
            )
          ],
        ));
  }
}
