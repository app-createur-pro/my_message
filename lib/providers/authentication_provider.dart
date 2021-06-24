
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/utils/navigation_utils.dart';
import 'package:my_message/utils/route_generator.dart';

import 'authentication_state.dart';

class AuthenticationProvider with ChangeNotifier {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  AuthenticationState authDataModel = InitAuthState();
  StreamSubscription<User?>? userStateChangeSubscription;
  bool isConnected = false;

  AuthenticationProvider() {
    userStateChangeSubscription = listenUserStateChange();
  }

  Stream<User?> get userState => _firebaseAuth.authStateChanges();
  Stream<User?> get userIdTokenChange => _firebaseAuth.idTokenChanges();
  Stream<User?> get userChange => _firebaseAuth.userChanges();

  StreamSubscription<User?> listenUserStateChange() {
    return StreamGroup.merge([
      userState,
      userIdTokenChange,
      userChange
    ]).listen((User? user) {

    });
  }

  void register({required String email, required String password, required BuildContext context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      NavigationUtils.showMyDialog(context: context, bodyText: "L'inscription est un succès");
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorPasswordWeak);
      } else if (e.code == 'email-already-in-use') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorAccountAlreadyExists);
      }
    } catch (e) {
      print(e);
    }
  }

  void signIn({required String email, required String password, required BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamed(context, PAGE_MESSAGES);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorNoUserForThisEmail);
      } else if (e.code == 'wrong-password') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorWrongPassword);
      } else if (e.code == 'user-disabled') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorUserDisabled);
      }
    }
  }

  void signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch(e){
      print(e.toString());
    }
  }

}