import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FootWearItem extends StatelessWidget {
  Image? image;
  String? imageUrl;

  final String brandName;
  final String sellerName;
  final String productName;

  final double price;
  final double rating;
  double? initialPrice;

  final int reviews;
  int? stockCount;
  int? soldCount;
  double? discount;

  FootWearItem(
      {Key? key,
      required this.brandName,
      required this.productName,
      required this.sellerName,
      required this.price,
      required this.rating,
      required this.reviews,
      this.initialPrice,
      this.stockCount,
      this.discount,
      this.soldCount,
      Image? img})
      : super(key: key) {
    image = img ??
        Image.network(
            "https://media.istockphoto.com/vectors/running-shoes-line-and-glyph-icon-fitness-and-sport-gym-sign-vector-vector-id898039038?k=20&m=898039038&s=612x612&w=0&h=Qxqdsi9LAtFVNYkgjnN6GVvQ4aDaRtwyIjinns3L6j0=");
  }

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
          Container(
            child: image,
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
