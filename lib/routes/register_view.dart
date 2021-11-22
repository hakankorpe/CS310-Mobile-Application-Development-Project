import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signupUser() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: pass
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == "email-already-in-use") {
        print("This email is already in use!!!");
      }
      else if (error.code == "weak-password") {

      }
    }
  }

  Future<void> loginUser() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: pass
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        signupUser();
      }
      if (error.code == "wrong-password") {

      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  late String email;
  late String pass;


  @override
  Widget build(BuildContext context) {
    print("RegisterView build is called.");
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
            "FootWear",
            style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Dimen.sizedBox_30,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, "/login");
                          },
                          child: Text(
                              "Login",
                            style: kUnselectedViewButtonTextStyle,
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 0,
                            ),
                          ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                            "Register",
                          style: kSelectedViewButtonTextStyle,
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimen.sizedBox_20,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlueAccent,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimen.sizedBox_15,),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Surname",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlueAccent,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimen.sizedBox_20,),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: "Username",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimen.sizedBox_20,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: "E-Mail Address",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimen.sizedBox_20,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: const InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimen.sizedBox_20,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: const InputDecoration(
                            hintText: "Password again",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimen.sizedBox_20,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();


                          }
                        },
                        child: Text(
                          "Register",
                          style: kButtonDarkTextStyle,
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(index: 3,),
    );
  }
}
