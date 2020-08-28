//To Decouple Authentication and make is more feasable

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  User({@required this.uid});

  final String uid;
}

abstract class Authbase {
  Stream<User> get onAuthStateChanged;

  Future<User> currentUser();

  Future<User> signInAnonymously();

  Future<void> signOut();

  Future<User> SigninWithGoogle();

  Future<User> SigInWithEmailAndPassword(String email, String password);

  Future<User> CreateUserWithEmailAndPassword(String email, String password);
}

class Auth implements Authbase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userfromfiirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userfromfiirebase);
  }

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userfromfiirebase(user);
  }

  @override
  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userfromfiirebase(authResult.user);
  }

  @override
  Future<User> SigInWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userfromfiirebase(authResult.user);
  }

  @override
  Future<User> CreateUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userfromfiirebase(authResult.user);
  }

  @override
  Future<User> SigninWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleauth = await googleAccount.authentication;
      if (googleauth.accessToken != null && googleauth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: googleauth.idToken, accessToken: googleauth.accessToken),
        );
        return _userfromfiirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'Error_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
          code: 'Error_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
