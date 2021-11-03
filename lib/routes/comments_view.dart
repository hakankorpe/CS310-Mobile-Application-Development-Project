import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:flutter/material.dart';


class CommentsView extends StatefulWidget {
  const CommentsView({Key? key}) : super(key: key);

  @override
  _CommentsViewState createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  @override
  Widget build(BuildContext context) {
    print("CommentsView build is called.");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Comments"
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: NavigationBar(index: 3,),
    );
  }
}
