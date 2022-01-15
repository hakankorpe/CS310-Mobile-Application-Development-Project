import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_footwear_project/routes/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final DBService db = DBService();
  final String serverKey =
      "BGAj3X11f26AYcykeR452COmkuuBnyOjHuRUMCaeUZtl-agK8lCkrQimMBstHzCIulViDQXvQJdfVXjhP2EDtqk";

  User? _userFromFirebase(User? user) {
    return user ?? null;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInAnon(StackTrace stackTrace) async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _userFromFirebase(user);
    } catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        stackTrace,
        reason: e.toString(),
      );
      print(e.toString());
      return null;
    }
  }

  Future getUserCredentials() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    try {
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return [credential, googleUser!.email];
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future signUpWithCredentials() async {}

  Future signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final credential = await getUserCredentials();

      var sameEmail = await db.userCollection
          .where('email', isEqualTo: credential[1])
          .get();

      if (sameEmail.docs.isEmpty) {
        googleSignIn.signOut();
        return credential;
      }

      // Once signed in, return the UserCredential
      String? registerToken =
          await FirebaseMessaging.instance.getToken(vapidKey: serverKey);

      final credentials =
          await FirebaseAuth.instance.signInWithCredential(credential[0]);
      if (registerToken != null) {
        await db.userCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "registerToken": registerToken,
        });
      }
      return credentials;
    } on FirebaseAuthException catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: e.toString(),
      );
      FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      //googleSignIn.disconnect();
      return e.message;
    } catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: e.toString(),
      );
      FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      //googleSignIn.disconnect();
    }
  }

  Future signUp(String mail, String pass, String name, String surname,
      String username, String signInType, dynamic credentials) async {
    try {
      UserCredential result = signInType == "mailAndPass"
          ? await _auth.createUserWithEmailAndPassword(
              email: mail, password: pass)
          : await _auth.signInWithCredential(credentials);
      User user = result.user!;

      // Add user to database before returning to profile
      DBService dbService = DBService();
      String userToken = await user.uid;

      String? registerToken =
          await FirebaseMessaging.instance.getToken(vapidKey: serverKey);
      dbService.addUser(name, surname, mail, userToken, username, pass,
          signInType, registerToken!);

      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: e.toString(),
      );
      //FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      return e.code.toString();
    } catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: e.toString(),
      );
      //FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      print(e.toString());
      String message = e.toString();
      return message;
    }
  }

  Future loginWithMailAndPass(String mail, String pass) async {
    DBService db = DBService();

    List<Map<String, dynamic>> users = await db.getAllCollectionItems(
        db.userCollection.where("email", isEqualTo: mail));

    if (users.isNotEmpty && users[0]["disabled"]) {
      if (users[0]["password"] != pass)
        return "wrong-password";
      else
        return "User is disabled";
    }

    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;
      String? registerToken =
          await FirebaseMessaging.instance.getToken(vapidKey: serverKey);
      if (registerToken != null) {
        await db.userCollection.doc(user.uid).update({
          "registerToken": registerToken,
        });
      }
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: e.toString(),
      );
      FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      return e.code.toString();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
        await googleSignIn.signOut();
      }
      await db.userCollection
          .doc(_auth.currentUser!.uid)
          .update({"registerToken": FieldValue.delete()});
      return await _auth.signOut();
    } catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: e.toString(),
      );
      FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      print(e.toString());
      return null;
    }
  }

  Future deleteAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: e.toString(),
      );
      FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  Future updatePassword(String oldPassword, String newPassword) async {
    final User currentUser = _auth.currentUser!;
    final cred = EmailAuthProvider.credential(
        email: currentUser.email!, password: oldPassword);

    currentUser.reauthenticateWithCredential(cred).then((value) {
      currentUser.updatePassword(newPassword).then((value) {
        db.updateUserPassword(currentUser.uid, newPassword, oldPassword);
        print("Password updated!!!");
      }).catchError((error) {
        print(error.toString());
        return error.toString();
      });
    });
  }
}
