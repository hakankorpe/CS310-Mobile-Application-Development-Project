import 'dart:io';

import 'package:cs310_footwear_project/routes/profile_view.dart';
import 'package:cs310_footwear_project/routes/register_view.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/auth.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String pass = "";
  String _message = '';

  AuthService auth = AuthService();

  bool isIOS = Platform.isIOS;

  void setmessage(String msg) {
    setState(() {
      _message = msg;
    });
  }

  void _showButtonPressDialog(BuildContext context, String provider) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('$provider Button Pressed!'),
      backgroundColor: Colors.black26,
      duration: const Duration(milliseconds: 400),
    ));
  }

  Future<void> showAlertDialog(
      String title, String message, String buttonText,) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (!isIOS) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: Text(message),
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      await DBService().activateUser(email);
                      await  auth.loginWithMailAndPass(email, pass);
                      Navigator.of(context).pop();
                    },
                    child: Text(buttonText)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"))
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: Text(message),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      DBService().activateUser(email).then((value) {
                        auth.loginWithMailAndPass(email, pass);
                      }).then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(buttonText)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"))
              ],
            );
          }
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("LoginView build is called.");
    final user = Provider.of<User?>(context);
    FirebaseAnalytics analytics = widget.analytics;
    FirebaseAnalyticsObserver observer = widget.observer;

    if (user == null) {
      setCurrentScreen(widget.analytics, "Login View", "loginView");

      return Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        appBar: AppBar(
          iconTheme: kAppBarIconStyle,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: Dimen.sizedBox_30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            "Login",
                            style: kSelectedViewButtonTextStyle,
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black,
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
                          onPressed: () {
                            Navigator.popAndPushNamed(context, "/register");
                          },
                          child: Text(
                            "Register",
                            style: kUnselectedViewButtonTextStyle,
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
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
                    ],
                  ),
                  const SizedBox(
                    height: Dimen.sizedBox_50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          validator: (value) {
                            if (value == null) {
                              return 'E-mail field cannot be empty!';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return 'E-mail field cannot be empty!';
                              }
                              if (!EmailValidator.validate(trimmedValue)) {
                                return 'Please enter a valid email';
                              }
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null) {
                              email = value;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: Dimen.sizedBox_20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          enableSuggestions: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          validator: (value) {
                            if (value == null) {
                              return 'Password field cannot be empty!';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return 'Password field cannot be empty!';
                              }
                              if (trimmedValue.length < 8) {
                                return 'Your password must contain at least 8 characters!';
                              }
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null) {
                              pass = value;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: Dimen.sizedBox_15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print('Mail: ' + email + "\nPass: " + pass);
                              _formKey.currentState!.save();
                              print("CurrentState Save is called.");
                              print('Mail: ' + email + "\nPass: " + pass);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Logging in')));



                              auth
                                  .loginWithMailAndPass(email, pass)
                                  .then((value) {
                                if (value is String) {
                                  if (value != "User is disabled")
                                  return ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                          SnackBar(content: Text("${value}")));

                                  else {
                                    showAlertDialog("Account Disabled", "Your account has been disabled. Do you want to reactive again?", "Activate");
                                  }
                                }
                              });
                              //Navigator.popAndPushNamed(context, "/profile");
                            }
                          },
                          child: Text(
                            "Log In",
                            style: kButtonDarkTextStyle,
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: Dimen.sizedBox_15,
                  ),
                  SignInButton(Buttons.Google, onPressed: () {
                    auth.signInWithGoogle().then((value) {
                      if (value?[1] is String) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterView(
                                analytics: analytics,
                                observer: observer,
                                credentials: value)));
                      }
                    });
                  }),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          index: 3,
        ),
      );
    } else {
      return ProfileView(analytics: analytics, observer: observer);
    }
  }
}
