import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/ui/product_review_tile.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';


class ReviewsView extends StatefulWidget {
  ReviewsView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  FootWearItem? product;
  int? quantity = 1;

  @override
  _ReviewsViewState createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
  DBService db = DBService();

  bool isBookmarked = false;
  FootWearItem? product;
  List<ProductReviewTile>? reviews;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String productId = arguments["productId"] ?? "";

    if (product == null) {
      db
          .getProductInfo(productId)
          .then((value) => db.returnFootwearItem(value))
          .then((value) {
        setState(() {
          product = value;
        });
      });
    }

    if (user != null) {
      db.isProductBookmarked(user!.uid, productId).then((value) {
        if ((value == true) && (isBookmarked == false)) {
          setState(() {
            isBookmarked = true;
          });
        }
      });
    }

    if (reviews == null) {
      db.getReviewsOfProduct(productId).then((value) {
        setState(() {
          reviews = value;
        });
      });
    }

    print("ReviewsView build is called.");

    setCurrentScreen(widget.analytics, "Reviews View", "reviewsView");

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: Dimen.appBarElevation,
        title: Text(
          "Product Page",
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
        iconTheme: kAppBarIconStyle,
        actions: [
          IconButton(
            onPressed: () {
              if (user == null) {
                Navigator.pushNamed(context, "/login");
              } else {
                setState(() {
                  if (isBookmarked) {
                    db.unBookmarkProduct(user!.uid, productId);
                  } else {
                    db.bookmarkProduct(user!.uid, productId);
                  }

                  isBookmarked = !isBookmarked;
                });
              }
            },
            icon: isBookmarked
                ? const Icon(
              Icons.bookmark,
              color: AppColors.appBarElementColor,
            )
                : const Icon(
              Icons.bookmark_border,
              color: AppColors.appBarElementColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.66,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: product?.image,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("/home",
                                  arguments: {"userID": product!.sellerToken, "username": product!.sellerName});
                            },
                            child: Text(product != null ? product!.sellerName : "",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      RatingBar.builder(
                        ignoreGestures: true,
                        initialRating:
                        product != null ? product!.sellerRating!.toDouble() : 0.0,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 18.52,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 5,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Text(
                          product != null ? product!.productName : "",
                          style: const TextStyle(
                              fontSize: 23,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          product != null ? product!.category! : "",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          product != null ? product!.gender! : "",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Shoe Size",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            const SizedBox(width: Dimen.sizedBox_5,),
                            Text(
                              product != null ? product!.footSize.toString() : "",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // Quantity Selector
                  Expanded(
                    flex: 2,
                    child: RatingBar.builder(
                      ignoreGestures: true,
                      initialRating:
                      product != null ? product!.rating!.toDouble() : 0.0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 5,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      product != null ? "${(product!.price!).toStringAsFixed(2)}₺" : "",
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          product != null
                              ? "${(product!.price! * (1 - product!.discount!)).toStringAsFixed(2)}₺"
                              : "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          product != null
                              ? "${(product!.discount! * 100).toStringAsFixed(2)}% Off"
                              : "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ActionChip(
                    backgroundColor: Colors.black,
                    avatar: const Icon(
                      Icons.change_circle,
                      color: Colors.white,
                    ),
                    label: Text(
                      widget.quantity.toString()!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      showMaterialNumberPicker(
                        context: context,
                        title: 'Quantity',
                        maxNumber: product!.stockCount!,
                        minNumber: 1,
                        selectedNumber: widget.quantity,
                        onChanged: (value) =>
                            setState(() => widget.quantity = value),
                      );
                    },
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      alignment: Alignment.center,
                      onPressed: () {
                        if (user == null) {
                          Navigator.pushNamed(context, "/login");
                        } else {
                          db
                              .addProductToCart(
                              user.uid, productId, widget.quantity!)
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Added to cart!')));
                            Navigator.popAndPushNamed(context, "/cart");
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.add_shopping_cart_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: const [
                        // Product Image
                        // Product Name
                        // Attributes or codenames
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: const [
                        // Brand Logo (Image)
                        // Location
                        // Rating (As a star representation)
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/description", arguments: {"productId": productId},);
                      },
                      child: const Text(
                        "Description",
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: const BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "Reviews",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(13.0),
                      color:  Colors.white,
                      height: 230,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12,),
                            const Text(
                              "Reviews",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                            Wrap(
                              children: reviews ?? [],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(index: 6,),
    );
  }
}
