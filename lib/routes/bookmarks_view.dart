import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:flutter/material.dart';


class BookmarksView extends StatefulWidget {
  const BookmarksView({Key? key}) : super(key: key);

  @override
  _BookmarksViewState createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView> {
  @override
  Widget build(BuildContext context) {
    print("BookmarksView build is called.");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Bookmarks"
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: NavigationBar(index: 7,),
    );
  }
}
