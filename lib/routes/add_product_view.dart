import 'dart:ffi';

import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/auth.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/services/storage.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show File, Platform;

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show basename;


class AddProductView extends StatefulWidget {
  const AddProductView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {

  StorageService storage = StorageService();
  AuthService auth = AuthService();
  DBService db = DBService();
  dynamic _userInfo;


  final _formKey = GlobalKey<FormState>();
  double price = 0.0;
  String productName = "";
  String brandName = "";
  int stockCount = 0;
  double footSize = 0.0;
  String productDetails = "";

  bool isIOS = Platform.isIOS;

  File? _image2;

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  _imgFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    // Store the image permanently
    final imagePermanent = await saveImagePermanently(image!.path);

    setState(() {
      _image2 = imagePermanent;
    });
  }

  _imgFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    // Store the image permanently
    final imagePermanent = await saveImagePermanently(image!.path);

    setState(() {
      _image2 = imagePermanent;
    });
  }

  Future<void> _showPicker(context) async {
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
    print("AddProductView build is called.");

    setCurrentScreen(widget.analytics, "Add Product View", "addProductView");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
            "Add Product",
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
        iconTheme: kAppBarIconStyle,
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Product Image",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          Container(
                            child: _image2 != null ? Image.file(
                                File(_image2!.path),
                              height: 180,
                              width: 180,
                            )
                                : const SizedBox(
                                child: Center(
                                    child: Text("No image is selected!")
                                ),
                                width: 180,
                                height: 180,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () async {
                              // Select the new image
                              await _showPicker(context);
                              print("Path is " + _image2!.path);

                              // Uplaod the new image to Firebase
                              await storage.uploadProfilePict(_image2!, 'test');
                            },
                            child: const Text(
                              "Upload image for product",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: "Price (₺)",
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
                                return 'Please enter a price!';
                              } else {
                                String trimmedValue = value.trim();
                                if (trimmedValue.isEmpty) {
                                  return 'Please enter a price!';
                                }
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                price = value as double;
                              }
                            },
                            onChanged: (value) {
                              if (value != null) {
                                price = value as double;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: "Product Name",
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
                                return 'Please enter a price!';
                              } else {
                                String trimmedValue = value.trim();
                                if (trimmedValue.isEmpty) {
                                  return 'Please enter a price!';
                                }
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                price = value as double;
                              }
                            },
                            onChanged: (value) {
                              if (value != null) {
                                price = value as double;
                              }
                            },
                          ),
                          const SizedBox(height: Dimen.sizedBox_15,),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: "Brand Name",
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
                                return 'Please enter a brand name!';
                              } else {
                                String trimmedValue = value.trim();
                                if (trimmedValue.isEmpty) {
                                  return 'Please enter a brand name!';
                                }
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                brandName = value;
                              }
                            },
                            onChanged: (value) {
                              if (value != null) {
                                brandName = value;
                              }
                            },
                          ),
                          const SizedBox(height: Dimen.sizedBox_15,),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: "Category",
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
                                return 'Please enter a category for product!';
                              } else {
                                String trimmedValue = value.trim();
                                if (trimmedValue.isEmpty) {
                                  return 'Please enter a category for product!';
                                }
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                brandName = value;
                              }
                            },
                            onChanged: (value) {
                              if (value != null) {
                                brandName = value;
                              }
                            },
                          ),
                          const SizedBox(height: Dimen.sizedBox_15,),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: "Stock Count",
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
                                return 'Please enter a stock count!';
                              } else {
                                String trimmedValue = value.trim();
                                if (trimmedValue.isEmpty) {
                                  return 'Please enter a stock count!';
                                }
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                stockCount = value as int;
                              }
                            },
                            onChanged: (value) {
                              if (value != null) {
                                stockCount = value as int;
                              }
                            },
                          ),
                          const SizedBox(height: Dimen.sizedBox_15,),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: "Foot Size",
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
                                return 'Please enter a foot size!';
                              } else {
                                String trimmedValue = value.trim();
                                if (trimmedValue.isEmpty) {
                                  return 'Please enter a foot size!';
                                }
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                footSize = value as double;
                              }
                            },
                            onChanged: (value) {
                              if (value != null) {
                                footSize = value as double;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimen.sizedBox_30,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                            "Product Details",
                          style: kButtonDarkTextStyle,

                        ),
                      ),
                    ],
                  ),
                  color: Colors.black,
                  height: Dimen.sizedBox_20,
                ),
                const SizedBox(height: Dimen.sizedBox_15,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                        child: TextFormField(
                          maxLines: 7,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            hintText: "Product Details",
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
                              return 'Please enter a brief product description!';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return 'Please enter a brief product description!';
                              }
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null) {
                              productDetails = value;
                            }
                          },
                          onChanged: (value) {
                            if (value != null) {
                              productDetails = value;
                            }
                          },
                        ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimen.sizedBox_5,),
                OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {

                      }
                    },
                    child: Text(
                        "Add Product to Database",
                      style: kButtonDarkTextStyle,
                    ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        )
      ),
      bottomNavigationBar: NavigationBar(index: 7,),
    );
  }
}
