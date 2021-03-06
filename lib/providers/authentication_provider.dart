
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/utils/exception_utils.dart';
import 'package:my_message/utils/navigation_utils.dart';
import 'package:my_message/utils/route_generator.dart';

class AuthenticationProvider with ChangeNotifier {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get userState => _firebaseAuth.authStateChanges();
  Stream<User?> get userIdTokenChange => _firebaseAuth.idTokenChanges();
  Stream<User?> get userChange => _firebaseAuth.userChanges();
  
  void signUp({
    required String email,
    required String password,
    required String userName,
    required BuildContext context
  }) async {
    NavigationUtils.showLoadingDialog(context);
    try {
      UserCredential _userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      User? _user = _userCredentials.user;

      await currentUser?.updatePhotoURL("assets/images/user_images/unknown-image.jpeg");
      
      await FirebaseFirestore.instance
          .collection(Strings.usersCollection)
          .doc(_user?.uid)
          .set({
            Strings.userModelId: _user?.uid,
            Strings.userModelName: userName,
            Strings.userModelImagePath: _user?.photoURL
          });

      await currentUser?.updateDisplayName(userName);

      NavigationUtils.hideDialog(context);
      NavigationUtils.showMyDialog(
        context: context,
        bodyText: Strings.successRegister,
        onClick: () => Navigator.pushNamedAndRemoveUntil(
            context,
            PAGE_SIGN_IN,
            ModalRoute.withName(PAGE_SIGN_IN)
        )
      );
    } on FirebaseAuthException catch (error, stackTrace) {
      ExceptionUtils.printCatchError(error: error, stackTrace: stackTrace);
      NavigationUtils.hideDialog(context);
      if(error.code == 'weak-password') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorPasswordLength);
      } else if (error.code == 'email-already-in-use'){
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorAccountAlreadyExists);
      } else {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorAuthSignUp);
      }
    }
  }
  
  void signIn({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    NavigationUtils.showLoadingDialog(context);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      ).then((value) {
        NavigationUtils.hideDialog(context);
        Navigator.of(context).pushNamed(PAGE_MESSAGES);
      });
    } on FirebaseAuthException catch(error, stackTrace) {
      ExceptionUtils.printCatchError(error: error, stackTrace: stackTrace);
      NavigationUtils.hideDialog(context);
      if (error.code == 'user-not-found') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorNoUserForThisEmail);
      } else if (error.code == 'wrong-password') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorWrongPassword);
      } else if (error.code == 'user-disabled') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorUserDisabled);
      } else {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorGenerics);
      }
    }
  }

  void signOut({required BuildContext context}) async {
    NavigationUtils.showLoadingDialog(context);
    try {
      await _firebaseAuth.signOut().then((value) {
        NavigationUtils.hideDialog(context);
        Navigator.of(context).pushNamedAndRemoveUntil(PAGE_SIGN_IN, (Route<dynamic> route) => false);
      });
    } catch(error, stackTrace) {
      ExceptionUtils.printCatchError(error: error, stackTrace: stackTrace);
      NavigationUtils.hideDialog(context);
      NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorLogOut);
    }
  }

  Future<bool> reloadFirebase({required BuildContext context}) async {
    bool _isUserStillConnected = true;
    try {
      await _firebaseAuth.currentUser?.reload();
      User? _user = currentUser;
      if(_user == null) {
        _isUserStillConnected = false;
        showDisconnectedDialog(context: context);
      }
    } on FirebaseAuthException catch(error, stackTrace) {
      ExceptionUtils.printCatchError(error: error, stackTrace: stackTrace);
      _isUserStillConnected = false;
      showDisconnectedDialog(context: context);
    }
    return _isUserStillConnected;
  }

  void showDisconnectedDialog({required BuildContext context}) {
    NavigationUtils.showMyDialog(
        context: context,
        bodyText: Strings.errorUserNotFound,
        onClick: () => signOut(context: context)
    );
  }
  

}