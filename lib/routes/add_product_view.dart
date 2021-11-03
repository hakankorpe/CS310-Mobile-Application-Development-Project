import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:flutter/material.dart';


class AddProductView extends StatefulWidget {
  const AddProductView({Key? key}) : super(key: key);

  @override
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  @override
  Widget build(BuildContext context) {
    print("AddProductView build is called.");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Add Product"
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: NavigationBar(index: 3,),
    );
  }
}
