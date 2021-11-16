import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("SearchView build is called.");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/cart");
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                            Icons.search,
                          color: Colors.black,
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                    ),
                  ],
                ),
                //const SizedBox(height: 5,),
                const Divider(thickness: 1.5, color: Colors.black38,),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Text("Add Filters Button Later On"),
                  ],
                ),
                const SizedBox(height: 10,),
                const Text(
                    "4 Results for \"Nike\"",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    const SizedBox(width: 15,),
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
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    const SizedBox(width: 15,),
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        index: 1,
      ),
    );
  }
}
