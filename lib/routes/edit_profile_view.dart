import 'dart:io' show File, Platform;
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {

  bool isIOS = Platform.isIOS;

  final _formKey = GlobalKey<FormState>();
  String oldPass = "";
  String newPass = "";
  String newPassAgain = "";

  XFile? _image;

  _imgFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    !isIOS ? showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Wrap(
                children: [
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Photo Library"),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text("Camera"),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
          );
        }
    )
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
                    _imgFromGallery();
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
                    _imgFromCamera();
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
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    print("EditProfileView build is called.");

    setCurrentScreen(widget.analytics, "Edit Profile View", "editProfileView");

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
                      const Text(
                        "LeBron James",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CircleAvatar(
                        radius: 60.0,
                        child: ClipRRect(
                          child: _image != null
                              ? Image.file(File(_image!.path))
                              : Image.network("https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png"),
                          borderRadius: BorderRadius.all(Radius.circular(60.0)),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {_showPicker(context);},
                        child: const Text(
                          "Change profile picture",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
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
                    onPressed: () {},
                    child: const Text(
                      "Delete Account",
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
              const SizedBox(height: 30,),
              Form(
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
                            decoration: const InputDecoration(
                              hintText: "Old Password",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightBlueAccent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
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
                            decoration: const InputDecoration(
                              hintText: "New Password",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightBlueAccent,
                                ),
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            obscureText: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: "New Password Again",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightBlueAccent,
                                ),
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text(
                  "Change password",
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightGreenAccent),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(index: 7,),
    );
  }
}
