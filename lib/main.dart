import 'package:cs310_footwear_project/routes/add_product_view.dart';
import 'package:cs310_footwear_project/routes/bookmarks_view.dart';
import 'package:cs310_footwear_project/routes/cart_view.dart';
import 'package:cs310_footwear_project/routes/category_main_view.dart';
import 'package:cs310_footwear_project/routes/category_selected_view.dart';
import 'package:cs310_footwear_project/routes/checkout_view.dart';
import 'package:cs310_footwear_project/routes/comment_approve_view.dart';
import 'package:cs310_footwear_project/routes/comments_view.dart';
import 'package:cs310_footwear_project/routes/description_view.dart';
import 'package:cs310_footwear_project/routes/edit_profile_view.dart';
import 'package:cs310_footwear_project/routes/home_view.dart';
import 'package:cs310_footwear_project/routes/login_view.dart';
import 'package:cs310_footwear_project/routes/onsale_view.dart';
import 'package:cs310_footwear_project/routes/orders_view.dart';
import 'package:cs310_footwear_project/routes/profile_view.dart';
import 'package:cs310_footwear_project/routes/register_view.dart';
import 'package:cs310_footwear_project/routes/reviews_view.dart';
import 'package:cs310_footwear_project/routes/search_view.dart';
import 'package:cs310_footwear_project/routes/sizechart_view.dart';
import 'package:cs310_footwear_project/routes/sold_view.dart';
import 'package:cs310_footwear_project/routes/walkthrough_view.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyFirebaseApp());
}

class MyFirebaseApp extends StatefulWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('No Firebase Connection!!! ${snapshot.error.toString()}'),
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return const AppBase();
          }

          return const MaterialApp(
            home: Center(
              child: Text("Connecting to Firebase...")
            ),
          );
        },
    );
  }
}

class AppBase extends StatelessWidget {
  const AppBase({
    Key? key,
  }) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      initialRoute: '/walkthrough',
      routes: {
        '/walkthrough' : (context) => WalkthroughView(analytics: analytics, observer: observer,),

        '/home': (context) => HomeView(analytics: analytics, observer: observer,),

        '/categoryMain': (context) => CategoryMainView(analytics: analytics, observer: observer,),
        '/categorySelected': (context) => CategorySelectedView(analytics: analytics, observer: observer,),

        '/profile': (context) => ProfileView(analytics: analytics, observer: observer,),
        '/orders': (context) => OrdersView(analytics: analytics, observer: observer,),
        '/editProfile': (context) => EditProfileView(analytics: analytics, observer: observer,),
        '/comments': (context) => CommentsView(analytics: analytics, observer: observer,),
        '/bookmarks': (context) => BookmarksView(analytics: analytics, observer: observer,),

        '/onSale': (context) => OnSaleView(analytics: analytics, observer: observer,),
        '/sold': (context) => SoldView(analytics: analytics, observer: observer,),
        '/commentApprove': (context) => CommentApproveView(analytics: analytics, observer: observer,),
        'addProduct': (context) => AddProductView(analytics: analytics, observer: observer,),

        '/search': (context) => SearchView(analytics: analytics, observer: observer,),

        '/description': (context) => DescriptionView(analytics: analytics, observer: observer,),
        '/sizeChart': (context) => SizeChartView(analytics: analytics, observer: observer,),
        '/reviews': (context) => ReviewsView(analytics: analytics, observer: observer,),

        '/cart': (context) => CartView(analytics: analytics, observer: observer,),
        '/checkout': (context) => CheckoutView(analytics: analytics, observer: observer,),

        '/login': (context) => LoginView(analytics: analytics, observer: observer,),
        '/register': (context) => RegisterView(analytics: analytics, observer: observer,),
      },
    );
  }
}