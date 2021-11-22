import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/styles.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  FirebaseAuth auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  late String email;
  late String pass;


  void _showButtonPressDialog(BuildContext context, String provider) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('$provider Button Pressed!'),
      backgroundColor: Colors.black26,
      duration: Duration(milliseconds: 400),
    ));
  }

  @override
  void initState() {
    super.initState();

    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print("User is signed up.");
      }
      else {
        print("User is signed in.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("LoginView build is called.");
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: Dimen.sizedBox_30,),
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
                  const SizedBox(height: Dimen.sizedBox_50,),
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
                  const SizedBox(height: Dimen.sizedBox_15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {},
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
                  const SizedBox(height: Dimen.sizedBox_15,),
                  SignInButton(
                    Buttons.Google,
                    onPressed: () {
                      _showButtonPressDialog(context, 'Google');
                    },
                  ),
                  const SizedBox(height: Dimen.sizedBox_15,),
                  SignInButton(
                    Buttons.FacebookNew,
                    onPressed: () {
                      _showButtonPressDialog(context, 'FacebookNew');
                    },
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
