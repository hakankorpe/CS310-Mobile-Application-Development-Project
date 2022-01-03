import 'package:cs310_footwear_project/routes/profile_view.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/auth.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  RegisterView(
      {Key? key,
      required this.analytics,
      required this.observer,
      this.credentials})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  dynamic credentials;
  String? get mailAddress => credentials?[1];

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  AuthService auth = AuthService();
  DBService db = DBService();

  final _formKey = GlobalKey<FormState>();
  String name = "";
  String surname = "";
  String username = "";
  String email = "";
  String pass = "";
  String pass2 = "";

  @override
  Widget build(BuildContext context) {
    print("RegisterView build is called.");
    final user = Provider.of<User?>(context);
    FirebaseAnalytics analytics = widget.analytics;
    FirebaseAnalyticsObserver observer = widget.observer;

    if (user == null) {
      setCurrentScreen(widget.analytics, "Register View", "registerView");

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
                  const SizedBox(
                    height: Dimen.sizedBox_30,
                  ),
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
                  const SizedBox(
                    height: Dimen.sizedBox_20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          validator: (value) {
                            if (value == null) {
                              return 'Name field cannot be empty!';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return 'Name field cannot be empty!';
                              }

                              RegExp exp = RegExp(r"[a-zA-Z]+(\s[a-zA-Z]+)*");
                              RegExpMatch? match = exp.firstMatch(value);

                              if (value != match?[0].toString()) {
                                return 'Please enter only letters for your name!';
                              }
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null) {
                              name = value;
                            }
                          },
                          onChanged: (value) {
                            if (value != null) {
                              name = value;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: Dimen.sizedBox_15,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          validator: (value) {
                            if (value == null) {
                              return 'Surname field cannot be empty!';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return 'Surname field cannot be empty!';
                              }
                              RegExp exp = RegExp(r"[a-zA-Z]+(\s[a-zA-Z]+)*");
                              RegExpMatch? match = exp.firstMatch(value);

                              if (value != match?[0].toString()) {
                                return 'Please enter only letters for your surname!';
                              }
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null) {
                              surname = value;
                            }
                          },
                          onChanged: (value) {
                            if (value != null) {
                              surname = value;
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
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          validator: (value)  {
                            if (value == null) {
                              return 'Username field cannot be empty!';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return 'Username field cannot be empty!';
                              }
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null) {
                              username = value;
                            }
                          },
                          onChanged: (value) {
                            if (value != null) {
                              username = value;
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
                          enabled: widget.mailAddress == null,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: widget.mailAddress ?? "",
                          decoration: InputDecoration(
                            hintText: widget.mailAddress ?? "Email",
                            border: const OutlineInputBorder(
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
                          onChanged: (value) {
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
                        child: widget.mailAddress != null
                            ? Container()
                            : TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                                enableSuggestions: false,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                onChanged: (value) {
                                  if (value != null) {
                                    pass = value;
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
                        child: widget.mailAddress != null
                            ? Container()
                            : TextFormField(
                                enabled: widget.mailAddress == null,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                                enableSuggestions: false,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                validator: (value) {
                                  if (value == null) {
                                    return 'Password field cannot be empty!';
                                  } else {
                                    String trimmedValue = value.trim();
                                    if (trimmedValue.isEmpty) {
                                      return 'Password field cannot be empty!';
                                    }
                                    if (value != pass) {
                                      return 'Please enter the same password!';
                                    }
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  if (value != null) {
                                    pass2 = value;
                                  }
                                },
                                onChanged: (value) {
                                  if (value != null) {
                                    pass2 = value;
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
                        child: OutlinedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print('Mail: ' + email + "\nPass: " + pass);
                              _formKey.currentState!.save();
                              print("CurrentState Save is called.");
                              print('Mail: ' + email + "\nPass: " + pass);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Registering......')));

                              if (await db.checkUsernameForRegister(username)) {
                                auth
                                    .signUp(
                                    email,
                                    pass,
                                    name,
                                    surname,
                                    username,
                                    widget.mailAddress != null
                                        ? "google-sign-in"
                                        : "mailAndPass",
                                    widget.credentials?[0])
                                    .then((value) {
                                  if (value is String) {
                                    return ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                        SnackBar(content: Text("${value}")));
                                  }
                                });
                              }
                              else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('This username has already taken by another user!\n'
                                            'Please enter another username.')));
                              }
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
        bottomNavigationBar: NavigationBar(
          index: 3,
        ),
      );
    } else {
      return ProfileView(analytics: analytics, observer: observer);
    }
  }
}
