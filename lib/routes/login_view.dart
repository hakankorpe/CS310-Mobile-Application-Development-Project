import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  void _showButtonPressDialog(BuildContext context, String provider) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('$provider Button Pressed!'),
      backgroundColor: Colors.black26,
      duration: Duration(milliseconds: 400),
    ));
  }

  @override
  Widget build(BuildContext context) {
    print("LoginView build is called.");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("AppName"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                          ),
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
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.black
                          ),
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
                const SizedBox(height: 50,),
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
                const SizedBox(height: 20,),
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
                const SizedBox(height: 15 ,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15 ,),
                SignInButton(
                  Buttons.Google,
                  onPressed: () {
                    _showButtonPressDialog(context, 'Google');
                  },
                ),
                const SizedBox(height: 15 ,),
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

      bottomNavigationBar: NavigationBar(index: 3,),
    );
  }
}
