import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:flutter/material.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("RegisterView build is called.");
    return Scaffold(
      appBar: AppBar(
        title: const Text("AppName"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, "/login");
                          },
                          child: const Text(
                              "Login",
                            style: TextStyle(
                              color: Colors.black,
                            ),
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
                        child: const Text(
                            "Register",
                          style: TextStyle(
                            color: Colors.white
                          ),
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
                const SizedBox(height: 20,),
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
                    const SizedBox(width: 15,),
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
                const SizedBox(height: 20,),
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
                const SizedBox(height: 20,),
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
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(
                          "Register",
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(index: 3,),
    );
  }
}
