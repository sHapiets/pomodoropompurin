import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AccountManager {
  AccountManager._();
  static final singleton = AccountManager._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? currentUser;
  final ValueNotifier<bool> loggedIn = ValueNotifier(false);

  Future<void> autoLogin() async {
    currentUser = _auth.currentUser;

    if (currentUser != null) {
      await currentUser!.reload();
      currentUser = _auth.currentUser;
      loggedIn.value = true;
    } else {
      loggedIn.value = false;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      currentUser = credential.user;
      loggedIn.value = true;
      return currentUser;
    } catch (e) {
      debugPrint("Login error: $e");
      return null;
    }
  }

  Future<User?> register(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      currentUser = credential.user;

      if (currentUser != null) {
        await _firestore.collection('users').doc(currentUser!.uid).set({
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return currentUser;
    } catch (e) {
      debugPrint("Register error: $e");
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    currentUser = null;
  }

  String? get uid => currentUser?.uid;
}
