import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    print("ProfileView build is called.");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Column(
                        children: const [
                          CircleAvatar(
                            radius: 35,
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "LeBron James",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "lebrbjames",
                        style: TextStyle(
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
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Row(
                      children: const [
                        Text(
                          "Rating:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        //TODO: find star rating bar
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ],
                    )
                  ]),
                ],
              ),
              const Divider(
                thickness: 2.0,
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_bag,
                      color: Colors.black,
                    ),
                    label: Row(
                      children: const [
                        SizedBox(width: 25),
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
                    thickness: 1.5,
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark,
                      color: Colors.black,
                    ),
                    label: Row(
                      children: const [
                        SizedBox(width: 25),
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
                    thickness: 1.0,
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.comment, color: Colors.black),
                    label: Row(
                      children: const [
                        SizedBox(width: 25),
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
                    thickness: 1.5,
                  ),
                ],
              ),
              const SizedBox(height: 90),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.attach_money, color: Colors.black),
                label: Row(
                  children: const [
                    SizedBox(width: 25),
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
                thickness: 1.5,
              ),
              const SizedBox(height: 90),
              OutlinedButton(
                onPressed: () {},
                child: const Text(
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
  }
}
