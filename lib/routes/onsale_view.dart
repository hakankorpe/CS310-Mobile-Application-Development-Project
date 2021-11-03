import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:flutter/material.dart';


class OnSaleView extends StatefulWidget {
  const OnSaleView({Key? key}) : super(key: key);

  @override
  _OnSaleViewState createState() => _OnSaleViewState();
}

class _OnSaleViewState extends State<OnSaleView> {
  @override
  Widget build(BuildContext context) {
    print("OnSaleView build is called.");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Products"
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                      child: const Text(
                          "On Sale",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                      ),
                      onPressed: () {},
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
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                      child: const Text(
                          "Sold",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/sold");
                      },
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
                    child: const Text(
                        "Comments",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/commentApprove");
                    },
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
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'addProduct');
        },
        child: const Icon(
            Icons.add,
            size: 30,
        ),
      ),
      bottomNavigationBar: NavigationBar(index: 3,),
    );
  }
}
