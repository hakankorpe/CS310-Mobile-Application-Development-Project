import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/analytics.dart';
import 'package:cs310_footwear_project/services/db.dart';
import 'package:cs310_footwear_project/ui/navigation_bar.dart';
import 'package:cs310_footwear_project/utils/color.dart';
import 'package:cs310_footwear_project/utils/dimension.dart';
import 'package:cs310_footwear_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';



class DescriptionView extends StatefulWidget {
  DescriptionView({Key? key, required this.analytics, required this.observer, this.product}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  FootWearItem? product;
  int? quantity = 1;

  @override
  _DescriptionViewState createState() => _DescriptionViewState();
}

class _DescriptionViewState extends State<DescriptionView> {
  
  DBService db = DBService();

  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    print("DescriptionView build is called.");

    setCurrentScreen(widget.analytics, "Description View", "descriptionView");

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
              setState(() {
                if (isBookmarked) {
                  db.unBookmarkProduct(
                      "MFR2EFaE6AezehbiIRdZGR4AHS82", "Ba1PWE2AAcz373xRC2GH");
                } else {
                  db.bookmarkProduct("MFR2EFaE6AezehbiIRdZGR4AHS82", "Ba1PWE2AAcz373xRC2GH");
                }
                
                isBookmarked = !isBookmarked;
              });
            },
            icon: isBookmarked ? const Icon(
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
                  const Expanded(flex: 15, child: Image(
                      image: NetworkImage(
                          "https://images.restocks.net/products/GY3438/adidas-yeezy-boost-350-v2-light-1-1000.png")
                  ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("Adidas",
                              textAlign: TextAlign.center,style: TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 7,),
                      Row(
                        children: [
                          Text("6.4/10",
                              textAlign: TextAlign.center,style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      SizedBox(height: 13,),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex:6, child:Column(
                    children: const [
                      Text(
                        "Yeezy Boost 350 v2 'Light'",
                        style: TextStyle(
                          fontSize: 23,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Sneakers",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                  ),
                  // Quantity Selector
                  Expanded(flex: 1, child:Text("RATING BAR"), //TODO: rating bar must be added here.
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(flex:2, child: Text(
                    "1300₺",
                  textAlign: TextAlign.right,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  ),
                  Expanded(flex:2, child:Column(
                    children: const [
                      Text(
                        "900₺",
                          textAlign: TextAlign.left,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "30% Off",
                          textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  ),
                  Expanded(flex:1, child:Container(color: Colors.black12,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(widget.quantity.toString(), textAlign: TextAlign.center),
                          IconButton(
                            constraints: const BoxConstraints(minHeight: 30),
                            onPressed: (){
                              showMaterialNumberPicker(
                                context: context,
                                title: 'Quantity',
                                maxNumber: 91,
                                minNumber: 1,
                                selectedNumber: widget.quantity,
                                onChanged: (value) => setState(() => widget.quantity = value),
                              );
                            },
                            icon: const Icon(Icons.arrow_downward_rounded),
                            iconSize: 17,
                          ),
                        ]
                    ),
                  ),
                  ),
                  // Quantity Selector
                  Expanded(flex: 2, child:IconButton(
                    alignment: Alignment.center,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart!')));
                    },
                    icon: const Icon(
                      Icons.add_shopping_cart_rounded,
                      color: Colors.black,
                    ),
                  ),
                  ),
                ],
              ),
              const Divider(height: 15,
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
                        onPressed: () {},
                        child: const Text(
                          "Description",
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
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/sizeChart");
                      },
                      child: const Text(
                        "Size Chart",
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
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/reviews");
                      },
                      child: const Text(
                        "Reviews",
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
                        height: 230.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12,),
                            const Text(
                              "Product Details",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: const [
                                    Text(
                                      "lkhvabdfalkvhjablkvjhsdbjhalkfblhjıvbfdjlkdsvlkjdlkjhvskvuvuıgvdlıuvaglvıugdlıuvlıudgvlaısugdlıuagdlıagldsvugalıuagdvlaugdlıvuglıudgvalıvglavkudlvaglıvuglaıugdlaıudglvıakugdlıugdlıaugdlıuvgdlıuvaglvug",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
