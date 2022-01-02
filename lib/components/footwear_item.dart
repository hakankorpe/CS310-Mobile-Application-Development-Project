import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FootWearItem extends StatelessWidget {
  Image? image;
  String? imageUrl;
  String? productToken;
  String? category;
  String? description;

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

  String? sellerToken;
  double? sellerRating;
  String? gender;

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
      this.productToken,
      this.soldCount,
        this.category,
        this.description,
        this.sellerToken,
        this.gender,
        this.sellerRating,
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
        Navigator.pushNamed(context, "/description",
            arguments: {"productId": productToken});
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: image,
            width: MediaQuery.of(context).size.width / 3.5,
            height: MediaQuery.of(context).size.width / 3.5,
          ),
          Text(
            productName,
            style: const TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Text(
            sellerName,
            style: const TextStyle(color: Colors.black),
          ),
          IntrinsicWidth(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${price.toStringAsFixed(2)}₺",
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$rating",
                      style: const TextStyle(color: Colors.black),
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (reviews > 0) Text(
                      "$reviews+",
                      //reviews > 999 ? "999+" : "$reviews",
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
