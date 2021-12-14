import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FootWearItem extends StatelessWidget {
  final String imageUrl;

  final String brandName;
  final String sellerName;

  final double price;
  final double rating;
  final int reviews;
  int? stockCount;
  double? discount;


  FootWearItem({
    Key? key,
    required this.imageUrl,
    required this.brandName,
    required this.sellerName,
    required this.price,
    required this.rating,
    required this.reviews,
    this.stockCount,
    this.discount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: () {
        Navigator.pushNamed(context, "/description");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(
              imageUrl,
            ),
            width: MediaQuery.of(context).size.width / 3.5,
            height: MediaQuery.of(context).size.width / 3.5,
          ),
          Text(
            sellerName,
            style: const TextStyle(color: Colors.black),
          ),
          Text(
            brandName,
            style: const TextStyle(color: Colors.black),
          ),
          IntrinsicWidth(
            child: Row(
              children: [
                Text(
                  "$price₺",
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Text(
                      "$rating",
                      style: const TextStyle(color: Colors.black),
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                    Text(
                      reviews > 999 ? "999+" : "$reviews",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
