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
import 'package:cs310_footwear_project/routes/notifications_view.dart';
import 'package:cs310_footwear_project/routes/onsale_view.dart';
import 'package:cs310_footwear_project/routes/orders_view.dart';
import 'package:cs310_footwear_project/routes/profile_view.dart';
import 'package:cs310_footwear_project/routes/register_view.dart';
import 'package:cs310_footwear_project/routes/reviews_view.dart';
import 'package:cs310_footwear_project/routes/search_view.dart';
import 'package:cs310_footwear_project/routes/sizechart_view.dart';
import 'package:cs310_footwear_project/routes/sold_view.dart';
import 'package:cs310_footwear_project/routes/walkthrough_view.dart';
import 'package:cs310_footwear_project/services/auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyFirebaseApp());
}

Future<bool> checkFirstSeen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool _seen = (prefs.getBool('seen') ?? false);

  print(_seen);

  if (!_seen) {
    prefs.setBool("seen", true);
  }

  return _seen;
}

class MyFirebaseApp extends StatefulWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    final AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print("${notification.title}\n${notification.body}");
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              //icon: 'app_icon',
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                    'No Firebase Connection!!! ${snapshot.error.toString()}'),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          FlutterError.onError =
              FirebaseCrashlytics.instance.recordFlutterError;
          return const AppBase();
        }

        return const MaterialApp(
          home: Center(child: Text("Connecting to Firebase...")),
        );
      },
    );
  }
}

class AppBase extends StatefulWidget {
  const AppBase({Key? key}) : super(key: key);

  @override
  _AppBaseState createState() => _AppBaseState();
}

class _AppBaseState extends State<AppBase> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  final Future<bool> firstOpen = checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: FutureBuilder(
        future: checkFirstSeen(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              navigatorObservers: <NavigatorObserver>[observer],
              initialRoute: (snapshot.data == true) ? "/home" : "/walkthrough",
              routes: {
                '/walkthrough': (context) => WalkthroughView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/home': (context) => HomeView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/categoryMain': (context) => CategoryMainView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/categorySelected': (context) => CategorySelectedView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/profile': (context) => ProfileView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/orders': (context) => OrdersView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/editProfile': (context) => EditProfileView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/comments': (context) => CommentsView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/bookmarks': (context) => BookmarksView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/onSale': (context) => OnSaleView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/sold': (context) => SoldView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/commentApprove': (context) => CommentApproveView(
                      analytics: analytics,
                      observer: observer,
                    ),
                'addProduct': (context) => AddProductView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/search': (context) => SearchView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/description': (context) => DescriptionView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/sizeChart': (context) => SizeChartView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/reviews': (context) => ReviewsView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/cart': (context) => CartView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/checkout': (context) => CheckoutView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/login': (context) => LoginView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/register': (context) => RegisterView(
                      analytics: analytics,
                      observer: observer,
                    ),
                '/notification': (context) => NotificationView(
                      analytics: analytics,
                      observer: observer,
                    ),
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
