import 'dart:convert';
import 'dart:io';

import 'package:cs310_footwear_project/routes/login_view.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  AuthService auth = AuthService();
  DBService db = DBService();
  StorageService storage = StorageService();
  dynamic _userInfo;
  File? _image2;

  Future<void> initializeUserInfo(String userUID) async {
    final SharedPreferences prefs = await _prefs;
    Map<String, dynamic> userInfo = await db.getUserInfo(userUID);

    prefs.setString("user-info", jsonEncode(userInfo));

    setState(() {
      _userInfo = jsonDecode(prefs.getString("user-info")!);
    });

    print(_userInfo);

    storage.downloadImage(_userInfo['userToken']);
    Directory appDocDir = await getApplicationDocumentsDirectory();

    setState(() {
      _image2 = File('${appDocDir.path}/${_userInfo!['userToken']}.png');
    });
  }


  @override
  Widget build(BuildContext context) {
    print("ProfileView build is called.");
    final user = Provider.of<User?>(context);
    FirebaseAnalytics analytics = widget.analytics;
    FirebaseAnalyticsObserver observer = widget.observer;

    if ((user != null)) {

      if (_userInfo == null) initializeUserInfo(user.uid);

      setCurrentScreen(widget.analytics, "Profile View", "profileView");

      return Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appBarBackgroundColor,
          elevation: Dimen.appBarElevation,
          title: Text(
            "Profile",
            style: kAppBarTitleTextStyle,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(
              0, Dimen.parentMargin, 0, Dimen.parentMargin),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //const Divider(thickness: Dimen.divider_1_5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            ClipOval(
                              child: _image2 != null ?
                              Image.file(
                                _image2!,
                                width: 60,
                                height: 60,
                              ) : Image.network(
                                "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png",
                                width: 60,
                                height: 60,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                      color: Colors.black,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          (_userInfo?["name"] ?? "") +
                              " " +
                              (_userInfo?["surname"] ?? ""),
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Dimen.sizedBox_5,),
                        Text(
                          _userInfo?["username"] ?? "",
                          style: const TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/editProfile');
                          },
                          child: const Text(
                            "Edit Profile",
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            //backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.white,
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Rating:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              //TODO: find a BETTER star rating bar
                              RatingBar.builder(
                                initialRating: 3.5,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 20,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 5,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          )
                        ]),
                  ],
                ),
                const Divider(
                  thickness: Dimen.divider_1_5,
                ),
                const SizedBox(height: Dimen.sizedBox_30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/orders');
                      },
                      icon: const Icon(
                        Icons.shopping_bag,
                        color: Colors.black,
                      ),
                      label: Row(
                        children: const [
                          SizedBox(width: Dimen.sizedBox_30),
                          Text(
                            "My Orders",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      style: OutlinedButton.styleFrom(
                        //backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.white,
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: Dimen.divider_1_5,
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/bookmarks');
                      },
                      icon: const Icon(
                        Icons.bookmark,
                        color: Colors.black,
                      ),
                      label: Row(
                        children: const [
                          SizedBox(width: Dimen.sizedBox_30),
                          Text(
                            "My Bookmarks",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      style: OutlinedButton.styleFrom(
                        //backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.white,
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: Dimen.divider_1_5,
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/comments');
                      },
                      icon: const Icon(Icons.comment, color: Colors.black),
                      label: Row(
                        children: const [
                          SizedBox(width: Dimen.sizedBox_30),
                          Text(
                            "My Comments",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      style: OutlinedButton.styleFrom(
                        //backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.white,
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: Dimen.divider_1_5,
                    ),
                  ],
                ),
                const SizedBox(height: Dimen.sizedBox_90),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/onSale');
                  },
                  icon: const Icon(Icons.attach_money, color: Colors.black),
                  label: Row(
                    children: const [
                      SizedBox(width: Dimen.sizedBox_30),
                      Text(
                        "My Products",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                    //backgroundColor: Colors.white,
                    side: const BorderSide(
                      color: Colors.white,
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                const Divider(
                  thickness: Dimen.divider_1_5,
                ),
                const SizedBox(height: Dimen.sizedBox_90),
                OutlinedButton.icon(
                  icon: const Icon(Icons.logout, color: Colors.redAccent),
                  onPressed: () {
                    _userInfo = null;
                    auth.signOut();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logging out')));
                  },
                  label: const Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    //backgroundColor: Colors.white,
                    side: const BorderSide(
                      color: Colors.white,
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          index: 3,
        ),
      );
    } else {
      return LoginView(
        observer: observer,
        analytics: analytics,
      );
    }
  }
}
