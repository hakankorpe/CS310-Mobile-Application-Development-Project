import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String imageUrl;
  final String CategoryName;

  CategoryItem({
    Key? key,
    required this.imageUrl,
    required this.CategoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: () {
        Navigator.pushNamed(context, "/categorySelected", arguments: {"categoryName": CategoryName});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: NetworkImage(
              imageUrl,
            ),
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 3,
          ),
          const SizedBox(height: Dimen.sizedBox_5,),
          Text(
            CategoryName,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: Dimen.sizedBox_5,),
        ],
      ),
    );
  }
}
