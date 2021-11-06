import 'package:flutter/material.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    print("HomeView build is called.");

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(),
            const Text("Welcome"),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/cart");
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
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
                    const SizedBox(height: 5,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {},
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
                          const SizedBox(width: 15,),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {},
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
                            onPressed: () {},
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
                    const SizedBox(height: 5,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {},
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
                          const SizedBox(width: 15,),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {},
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
                            onPressed: () {},
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
                    const SizedBox(height: 5,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {},
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
                          const SizedBox(width: 15,),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {},
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
                            onPressed: () {},
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
