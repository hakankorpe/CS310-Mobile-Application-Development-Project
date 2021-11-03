import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:flutter/material.dart';


class CommentApproveView extends StatefulWidget {
  const CommentApproveView({Key? key}) : super(key: key);

  @override
  _CommentApproveViewState createState() => _CommentApproveViewState();
}

class _CommentApproveViewState extends State<CommentApproveView> {
  @override
  Widget build(BuildContext context) {
    print("CommentApproveView build is called.");
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
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/onSale");
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
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
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(index: 3,),
    );
  }
}
