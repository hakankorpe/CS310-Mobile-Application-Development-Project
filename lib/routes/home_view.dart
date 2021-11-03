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
          children: const [
            Spacer(),
            Text("Welcome"),
            Spacer(),
            Icon(Icons.shopping_cart),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        index: 0,
      ),
    );
  }
}
