import 'dart:convert';
import 'dart:io' show Directory, File, Platform;
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/auth.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/services/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show basename;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class EditProfileView extends StatefulWidget {
  EditProfileView(
      {Key? key, required this.analytics, required this.observer, this.image2})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  File? image2;

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  StorageService storage = StorageService();
  AuthService auth = AuthService();
  DBService db = DBService();
  dynamic _userInfo;

  bool isIOS = Platform.isIOS;

  final _formKey = GlobalKey<FormState>();
  String oldPass = "";
  String newPass = "";
  String newPassAgain = "";

  //XFile? _image;

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  _imgFromCamera(String userID) async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    // Store the image permanently
    final imagePermanent = await saveImagePermanently(image.path);

    setState(() {
      imageCache!.clear();
      imageCache!.clearLiveImages();

      widget.image2 = imagePermanent;
      storage.uploadProfilePict(widget.image2!, userID);
    });
  }

  _imgFromGallery(String userID) async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    // Store the image permanently
    final imagePermanent = await saveImagePermanently(image.path);

    setState(() {
      widget.image2 = imagePermanent;
      storage.uploadProfilePict(widget.image2!, userID);
    });
  }

  Future<void> _showPicker(context, String userID) async {
    !isIOS
        ? showModalBottomSheet(
            context: context,
            builder: (BuildContext bc) {
              return SafeArea(
                child: Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text("Photo Library"),
                      onTap: () {
                        _imgFromGallery(userID);
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo_camera),
                      title: const Text("Camera"),
                      onTap: () {
                        _imgFromCamera(userID);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            })
        : showCupertinoModalPopup(
            context: context,
            builder: (BuildContext bc) {
              return SafeArea(
                child: CupertinoActionSheet(
                  actions: <CupertinoActionSheetAction>[
                    CupertinoActionSheetAction(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Photo Library"),
                          Icon(CupertinoIcons.photo_on_rectangle),
                        ],
                      ),
                      onPressed: () {
                        _imgFromGallery(userID);
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Camera"),
                          Icon(CupertinoIcons.photo_camera),
                        ],
                      ),
                      onPressed: () {
                        _imgFromCamera(userID);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            });
  }

  Future<void> showAlertDialog(
      String title, String message, String buttonText) async {
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
                    onPressed: () {
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
          }
        });
  }

  Future<void> initializeUserInfo(String userUID) async {
    final SharedPreferences prefs = await _prefs;
    Map<String, dynamic> userInfo = await db.getUserInfo(userUID);

    prefs.setString("user-info", jsonEncode(userInfo));

    //setState(() {
    _userInfo = jsonDecode(prefs.getString("user-info")!);
    //});

    print(_userInfo);

    await storage.downloadImage(_userInfo['userToken']);

    imageCache!.clear();
    imageCache!.clearLiveImages();

    Directory appDocDir = await getApplicationDocumentsDirectory();
    setState(() {
      widget.image2 = File('${appDocDir.path}/${_userInfo!['userToken']}.png');
    });
  }

  @override
  Widget build(BuildContext context) {
    print("EditProfileView build is called.");
    final user = Provider.of<User?>(context);

    if (_userInfo == null) initializeUserInfo(user!.uid);

    setCurrentScreen(widget.analytics, "Edit Profile View", "editProfileView");

    db.getUserInfo(user!.uid).then((value) {
      //_userInfo = value;
    });

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
          "Edit Profile",
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
        iconTheme: kAppBarIconStyle,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.popAndPushNamed(context, "/profile"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        (_userInfo?["name"] ?? "") +
                            " " +
                            (_userInfo?["surname"] ?? ""),
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ClipOval(
                        //_userInfo["sign-in-type"] != "google-sign-in"
                        child: widget.image2 != null
                            ? Image.file(
                                widget.image2!,
                                width: 120,
                                height: 120,
                              )
                            : Image.network(
                                "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png",
                                width: 120,
                                height: 120,
                              ),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          // Select the new image
                          _showPicker(context, user.uid);
                          print("Path is " + widget.image2!.path);

                          // Uplaod the new image to Firebase
                          //storage.uploadProfilePict(_image2!, user.uid);
                        },
                        child: const Text(
                          "Change profile picture",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      showAlertDialog(
                          "Deleting Account",
                          "Do you really want to delete your account on Footwear? This action cannot be undone!",
                          "Delete");
                    },
                    child: const Text(
                      "Delete Account",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      showAlertDialog(
                          "Disabling Account",
                          "Do you really want to disable your account on Footwear? This action cannot be undone!\n" +
                              "You can reactive your account by logging in again anytime.",
                          "Disable");
                    },
                    child: const Text(
                      "Disable Account",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellowAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              _userInfo?["sign-in-type"] == "mailAndPass"
                  ? Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  obscureText: true,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  keyboardType: TextInputType.text,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                    hintText: "Old Password",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black,
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
                                      if (trimmedValue !=
                                          _userInfo["password"]) {
                                        return 'Please enter your old password correctly!';
                                      }
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    if (value != null) {
                                      oldPass = value;
                                    }
                                  },
                                  onChanged: (value) {
                                    if (value != null) {
                                      oldPass = value;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  obscureText: true,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  keyboardType: TextInputType.text,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                    hintText: "New Password",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black,
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
                                      if (trimmedValue ==
                                          _userInfo["password"]) {
                                        return 'Your new password should be different than your last password!';
                                      }
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    if (value != null) {
                                      newPass = value;
                                    }
                                  },
                                  onChanged: (value) {
                                    if (value != null) {
                                      newPass = value;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  obscureText: true,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  keyboardType: TextInputType.text,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                    hintText: "New Password Again",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Password field cannot be empty!';
                                    } else {
                                      String trimmedValue = value.trim();
                                      if (trimmedValue.isEmpty) {
                                        return 'Password field cannot be empty!';
                                      }
                                      if (value != newPass) {
                                        return 'Please enter the same password!';
                                      }
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    if (value != null) {
                                      newPassAgain = value;
                                    }
                                  },
                                  onChanged: (value) {
                                    if (value != null) {
                                      newPassAgain = value;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Form(
                      key: _formKey,
                      child: Column(),
                    ),
              const SizedBox(
                height: 20,
              ),
              _userInfo?["sign-in-type"] == "mailAndPass"
                  ? OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Updating password...')));

                          db
                              .updateUserPassword(user.uid, newPass, oldPass)
                              .then((value) {
                            if (value is String) {
                              return ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("${value}")));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Password updated!')));
                            }
                          });
                        }
                      },
                      child: const Text(
                        "Change password",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.lightGreenAccent),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        index: 7,
      ),
    );
  }
}
