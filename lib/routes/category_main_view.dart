import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:flutter/material.dart';

class CategoryMainView extends StatefulWidget {
  const CategoryMainView({Key? key}) : super(key: key);

  @override
  _CategoryMainViewState createState() => _CategoryMainViewState();
}

class _CategoryMainViewState extends State<CategoryMainView> {
  @override
  Widget build(BuildContext context) {
    print("CategoryMainView build is called.");
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Spacer(),
            Text("Categories"),
            Spacer(),
            Icon(Icons.shopping_cart),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        index: 2,
      ),
    );
  }
}
