import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    print("SearchView build is called.");
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          index: 1,
        ),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Spacer(),
              Text("Welcome"),
              Spacer(),
              Icon(Icons.shopping_cart),
            ],
          ),
        ));
  }
}
