import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  String _message = "";

  void setMessage(String msg) {
    setState(() {
      _message = msg;
    });
  }

  Future<void> _setLogEvent() async {
    await widget.analytics.logEvent(
        name: 'CS310_Test',
        parameters: <String, dynamic> {
          "string": "myString",
          "int" : 12,
          "long" : 123456789,
          "bool" : true,
        }
    );
    setMessage("setLogEvent succeeded.");
  }

  Future<void> _setCurrentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: "Home View",
        screenClassOverride: "HomeView",
    );
    setMessage("setCurrentScreen succeeded.");
  }

  Future<void> _setUserId() async {
    await widget.analytics.setUserId("sayanarman");
    setMessage("setUserId succeeded.");
  }

  @override
  Widget build(BuildContext context) {
    print("HomeView build is called.");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
            "Welcome to FootWear",
          style: kAppBarTitleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/cart");
            },
            icon: const Icon(
                Icons.shopping_cart,
              color: AppColors.appBarElementColor,
            ),
          ),
        ],
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        iconTheme: kAppBarIconStyle,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimen.regularMargin),
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Featured",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Dimen.sizedBox_5,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {Navigator.pushNamed(context, "/description");},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: const NetworkImage(
                                    "https://media.istockphoto.com/vectors/running-shoes-line-and-glyph-icon-fitness-and-sport-gym-sign-vector-vector-id898039038?k=20&m=898039038&s=612x612&w=0&h=Qxqdsi9LAtFVNYkgjnN6GVvQ4aDaRtwyIjinns3L6j0=",


                                  ),
                                  width: MediaQuery.of(context).size.width/3,
                                  height: MediaQuery.of(context).size.width/3,
                                ),
                                const Text(
                                  "Melinda",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                const Text(
                                  "Nike",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "3.99₺",
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                    Row(
                                      children: const [
                                        Text(
                                          "4.8",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                        ),
                                        Text(
                                          "(999+)",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: Dimen.sizedBox_15,),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {Navigator.pushNamed(context, "/description");},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: const NetworkImage(
                                    "https://media.istockphoto.com/vectors/running-shoes-line-and-glyph-icon-fitness-and-sport-gym-sign-vector-vector-id898039038?k=20&m=898039038&s=612x612&w=0&h=Qxqdsi9LAtFVNYkgjnN6GVvQ4aDaRtwyIjinns3L6j0=",


                                  ),
                                  width: MediaQuery.of(context).size.width/3,
                                  height: MediaQuery.of(context).size.width/3,
                                ),
                                const Text(
                                  "Melinda",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                const Text(
                                  "Nike",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "3.99₺",
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                    Row(
                                      children: const [
                                        Text(
                                          "4.8",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                        ),
                                        Text(
                                          "(999+)",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {Navigator.pushNamed(context, "/description");},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: const NetworkImage(
                                    "https://media.istockphoto.com/vectors/running-shoes-line-and-glyph-icon-fitness-and-sport-gym-sign-vector-vector-id898039038?k=20&m=898039038&s=612x612&w=0&h=Qxqdsi9LAtFVNYkgjnN6GVvQ4aDaRtwyIjinns3L6j0=",


                                  ),
                                  width: MediaQuery.of(context).size.width/3,
                                  height: MediaQuery.of(context).size.width/3,
                                ),
                                const Text(
                                  "Melinda",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                const Text(
                                  "Nike",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "3.99₺",
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                    Row(
                                      children: const [
                                        Text(
                                          "4.8",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                        ),
                                        Text(
                                          "(999+)",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Discounts",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Dimen.sizedBox_5,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {Navigator.pushNamed(context, "/description");},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: const NetworkImage(
                                    "https://media.istockphoto.com/vectors/running-shoes-line-and-glyph-icon-fitness-and-sport-gym-sign-vector-vector-id898039038?k=20&m=898039038&s=612x612&w=0&h=Qxqdsi9LAtFVNYkgjnN6GVvQ4aDaRtwyIjinns3L6j0=",


                                  ),
                                  width: MediaQuery.of(context).size.width/3,
                                  height: MediaQuery.of(context).size.width/3,
                                ),
                                const Text(
                                  "Melinda",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                const Text(
                                  "Nike",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "3.99₺",
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                    Row(
                                      children: const [
                                        Text(
                                          "4.8",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                        ),
                                        Text(
                                          "(999+)",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: Dimen.sizedBox_15,),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {Navigator.pushNamed(context, "/description");},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: const NetworkImage(
                                    "https://media.istockphoto.com/vectors/running-shoes-line-and-glyph-icon-fitness-and-sport-gym-sign-vector-vector-id898039038?k=20&m=898039038&s=612x612&w=0&h=Qxqdsi9LAtFVNYkgjnN6GVvQ4aDaRtwyIjinns3L6j0=",


                                  ),
                                  width: MediaQuery.of(context).size.width/3,
                                  height: MediaQuery.of(context).size.width/3,
                                ),
                                const Text(
                                  "Melinda",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                const Text(
                                  "Nike",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "3.99₺",
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                    Row(
                                      children: const [
                                        Text(
                                          "4.8",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                        ),
                                        Text(
                                          "(999+)",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {Navigator.pushNamed(context, "/description");},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: const NetworkImage(
                                    "https://media.istockphoto.com/vectors/running-shoes-line-and-glyph-icon-fitness-and-sport-gym-sign-vector-vector-id898039038?k=20&m=898039038&s=612x612&w=0&h=Qxqdsi9LAtFVNYkgjnN6GVvQ4aDaRtwyIjinns3L6j0=",


                                  ),
                                  width: MediaQuery.of(context).size.width/3,
                                  height: MediaQuery.of(context).size.width/3,
                                ),
                                const Text(
                                  "Melinda",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                const Text(
                                  "Nike",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "3.99₺",
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                    Row(
                                      children: const [
                                        Text(
                                          "4.8",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                        ),
                                        Text(
                                          "(999+)",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Just For You",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Dimen.sizedBox_5,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {Navigator.pushNamed(context, "/description");},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: const NetworkImage(
                                    "https://media.istockphoto.com/vectors/running-shoes-line-and-glyph-icon-fitness-and-sport-gym-sign-vector-vector-id898039038?k=20&m=898039038&s=612x612&w=0&h=Qxqdsi9LAtFVNYkgjnN6GVvQ4aDaRtwyIjinns3L6j0=",


                                  ),
                                  width: MediaQuery.of(context).size.width/3,
                                  height: MediaQuery.of(context).size.width/3,
                                ),
                                const Text(
                                  "Melinda",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                const Text(
                                  "Nike",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "3.99₺",
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                    Row(
                                      children: const [
                                        Text(
                                          "4.8",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                        ),
                                        Text(
                                          "(999+)",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: Dimen.sizedBox_15,),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {Navigator.pushNamed(context, "/description");},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: const NetworkImage(
                                    "https://media.istockphoto.com/vectors/running-shoes-line-and-glyph-icon-fitness-and-sport-gym-sign-vector-vector-id898039038?k=20&m=898039038&s=612x612&w=0&h=Qxqdsi9LAtFVNYkgjnN6GVvQ4aDaRtwyIjinns3L6j0=",


                                  ),
                                  width: MediaQuery.of(context).size.width/3,
                                  height: MediaQuery.of(context).size.width/3,
                                ),
                                const Text(
                                  "Melinda",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                const Text(
                                  "Nike",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "3.99₺",
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                    Row(
                                      children: const [
                                        Text(
                                          "4.8",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                        ),
                                        Text(
                                          "(999+)",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {Navigator.pushNamed(context, "/description");},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: const NetworkImage(
                                    "https://media.istockphoto.com/vectors/running-shoes-line-and-glyph-icon-fitness-and-sport-gym-sign-vector-vector-id898039038?k=20&m=898039038&s=612x612&w=0&h=Qxqdsi9LAtFVNYkgjnN6GVvQ4aDaRtwyIjinns3L6j0=",


                                  ),
                                  width: MediaQuery.of(context).size.width/3,
                                  height: MediaQuery.of(context).size.width/3,
                                ),
                                const Text(
                                  "Melinda",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                const Text(
                                  "Nike",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "3.99₺",
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                    Row(
                                      children: const [
                                        Text(
                                          "4.8",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                        ),
                                        Text(
                                          "(999+)",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        index: 0,
      ),
    );
  }
}
