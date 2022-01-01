import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/storage.dart';
import 'package:cs310_footwear_project/ui/bookmarks_tile.dart';
import 'package:cs310_footwear_project/ui/cart_tile.dart';
import 'package:cs310_footwear_project/ui/comment_approve_tile.dart';
import 'package:cs310_footwear_project/ui/comments_tile.dart';
import 'package:cs310_footwear_project/ui/onsale_tile.dart';
import 'package:cs310_footwear_project/ui/order_updates_tile.dart';
import 'package:cs310_footwear_project/ui/order_tile.dart';
import 'package:cs310_footwear_project/ui/sold_tile.dart';
import 'package:cs310_footwear_project/ui/user_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:io' show Directory, File, Platform;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class DBService {
  StorageService storage = StorageService();

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('carts');
  final CollectionReference bookmarkCollection =
      FirebaseFirestore.instance.collection("bookmarks");
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection("orders");
  final CollectionReference reviewCollection =
      FirebaseFirestore.instance.collection("reviews");
  final CollectionReference soldCollection =
      FirebaseFirestore.instance.collection("solds");
  final CollectionReference addressCollection =
      FirebaseFirestore.instance.collection("address");

  final CollectionReference notificationCollection =
      FirebaseFirestore.instance.collection("notifications");

  Future addUserAutoID(
      String name, String surname, String mail, String token) async {
    userCollection
        .add({
          'name': name,
          'surname': surname,
          'userToken': token,
          'email': mail
        })
        .then((value) => print('User added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future addUser(String name, String surname, String mail, String token,
      String username, String password, String signInType) async {
    userCollection.doc(token).set({
      'name': name,
      'surname': surname,
      'userToken': token,
      'username': username,
      'email': mail,
      'password': password,
      'sign-in-type': signInType,
      'rating': 0,
    });
  }

  Future updateUserPassword(
      String token, String newPassword, String oldPassword) async {

    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: oldPassword);

    user!.reauthenticateWithCredential(cred).then((value) {
      user!.updatePassword(newPassword).then((_) {
        userCollection.doc(token).update({'password': newPassword});

        //Success, do something
      }).catchError((error) {
        print(error);
        //Error, show something
      });
    }).catchError((err) {
      print(err);
    });
  }

  Future<void> deleteUser(String userToken, String userPassword) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: userPassword);

    await user!.reauthenticateWithCredential(cred).then((value) {
      FirebaseAuth.instance.currentUser!.delete().then((value) => print("user with $userToken deleted"));
    }).catchError((err) {
      print(err);
    });
  }

  Future<void> disableUser(String userToken, String userPassword) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: userPassword);


    await user!.reauthenticateWithCredential(cred).then((value) {
      FirebaseAuth.instance.currentUser!.delete().then((value) => print("user with $userToken deleted"));
    }).catchError((err) {
      print(err);
    });
  }

  Future getUserInfo(String token) async {
    return userCollection
        .doc(token)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      //print(documentSnapshot.data());
      return documentSnapshot.data();
    });
  }

  Future<List<Map<String, dynamic>>> getAllCollectionItems(
      Query<Object?> query) {
    return query.get().then((QuerySnapshot querySnapshot) {
      List<Map<String, dynamic>> result = [];
      querySnapshot.docs.forEach((element) {
        result.add(element.data() as Map<String, dynamic>);
      });
      return result;
    });
  }

  Future addProductAuto(
      String productName,
      String brandName,
      String category,
      double price,
      int stockCount,
      double footSize,
      String productDetails,
      String sellerID,
      File image,
      String gender) async {
    productCollection.add({
      'product-id': "",
      'product-name': productName,
      'brand-name': brandName,
      'category': category,
      'initial-price': price,
      'current-price': price,
      'discount': 0,
      'initial-stock-count': stockCount,
      'remaining-stock-count': stockCount,
      'sold-count': 0,
      'foot-size': footSize,
      'details': productDetails,
      'seller-id': sellerID,
      'rating': 0,
      'comment-count': 0,
      "gender": gender
    }).then((value) {
      productCollection.doc(value.id).update({"product-id": value.id});

      // Uplaod the new image to Firebase
      storage.uploadProductPict(image, value.id);
    }).catchError((error) {
      print('Error: ${error.toString()}');

      return error.toString();
    });
  }

  Future<List<Map<String, dynamic>>> basicSearchProduct(
      String productName) async {
    Iterable<Map<String, dynamic>> allProducts =
        await getAllCollectionItems(productCollection);

    return allProducts
        .where((element) => element["product-name"]
            .toString()
            .toLowerCase()
            .contains(productName.toLowerCase()))
        .toList();
  }

  Future<List<UserTile>> basicSearchUser(String userName) async {
    Iterable<Map<String, dynamic>> allUsers =
        await getAllCollectionItems(userCollection);

    final wantedUsers = allUsers.where((element) =>
        element["username"].toString().toLowerCase().contains(userName));

    final result =
        await Future.wait(wantedUsers.map((e) async => returnUserTile(e)));

    result.forEach((element) => print(element));
    return result;
  }

  Future getProductsOnSale(String sellerID) async {
    var productList = await productCollection
        .where('seller-id', isEqualTo: sellerID)
        //.where('remaining-stock-count', isGreaterThan: 0)
        .get()
        .then((value) {
      var result = value.docs;
      List<Map<String, dynamic>> allProducts = [];
      for (var doc in result) {
        if (doc.data() != null) {
          var data = doc.data() as Map<String, dynamic>;

          if (data['remaining-stock-count'] > 0) allProducts.add(data);
        }
      }
      return allProducts;
    });

    return productList;
  }

  Future returnOnSaleTileFromMap(List<Map<String, dynamic>> productList) async {
    return await Future.wait(productList.map((product) async {
      return OnSaleTile(
        product: await returnFootwearItem(product),
        remove: () => {},
        applyDiscount: () => {},
        stockUpdate: () => {},
        priceUpdate: () => {},
      );
    }));
  }

  Future<List<SoldTile>> getProductsSold(String sellerID) async {
    List<Map<String, dynamic>> allSold = await getAllCollectionItems(
        await soldCollection.where('seller', isEqualTo: sellerID));

    return Future.wait(allSold.map((e) async {
      var productInfo = await getProductInfo(e["product-id"]);
      var userInfo = await getUserInfo(e["buyer"]);
      return SoldTile(
        product: await returnFootwearItem(productInfo),
        sellingPrice: e["selling-price"],
        soldCount: e["quantity"],
        profit: e["quantity"] * e["selling-price"],
        netGain:
            (e["selling-price"] - productInfo["initial-price"]) * e["quantity"],
        status: e["status"],
        buyer: userInfo["username"],
        soldID: e["sold-id"],
      );
    }).toList());
  }

  Future<UserTile> returnUserTile(Map<String, dynamic> userInfo) async {
    Image img = await storage.returnImage(userInfo["userToken"]);
    return UserTile(
      img: img,
      displayName: '${userInfo["name"]} ${userInfo["surname"]}',
      rating: userInfo["rating"].toDouble(),
      username: userInfo["username"],
      userID: userInfo["userToken"],
    );
  }

  Future<FootWearItem> returnFootwearItem(Map<String, dynamic> product) async {
    Map<String, dynamic> userInfo = await getUserInfo(product["seller-id"]);
    Image img = await storage.returnImage(product["product-id"]);
    return FootWearItem(
      img: img,
      productToken: product["product-id"],
      productName: product["product-name"],
      brandName: product["brand-name"],
      sellerName: userInfo["username"],
      price: product["current-price"].toDouble(),
      rating: product["rating"].toDouble(),
      reviews: product["comment-count"],
      stockCount: product["remaining-stock-count"],
      soldCount: product["sold-count"],
      discount: product["discount"].toDouble(),
      initialPrice: product["initial-price"].toDouble(),
      category: product["category"],
      description: product["details"],
      sellerToken: product["seller-id"],
      gender: product["gender"] ?? "Unisex",
    );
  }

  Future addProductToCart(String userID, String productID, int quantity) async {
    cartCollection.doc(userID).set(
      {
        productID: FieldValue.increment(quantity),
      },
      SetOptions(merge: true),
    );
  }

  Future updateProductQuantityAtCart(
      String userID, String productID, int newQuantity) async {
    cartCollection.doc(userID).update({productID: newQuantity});
  }

  Future getCartOfUser(String userID) async {
    var allProducts = await cartCollection
        .doc(userID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.data() as Map<String, dynamic>;
    });

    return await getCartItemsFromProductIDs(allProducts, userID);
  }

  Future<List<CartTile>> getCartItemsFromProductIDs(
      Map<String, dynamic> allProducts, String userID) async {
    List<dynamic> productIDs = [];
    allProducts.keys.forEach((key) {
      productIDs.add(key);
    });

    return await Future.wait(productIDs.map((productId) async {
      var tempCartTile = CartTile(
          product: await returnFootwearItem(await getProductInfo(productId)));

      tempCartTile.quantity = allProducts[productId];
      tempCartTile.userID = userID;

      return tempCartTile;
    }));
  }

  Future getBookmarksOfUser(
    String userID,
  ) async {
    var allProducts = await bookmarkCollection
        .doc(userID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.data() as Map<String, dynamic>;
    });

    List<dynamic> productIDs = allProducts["productIDs"];

    return await Future.wait(productIDs.map((productId) async => BookmarksTile(
        product: await returnFootwearItem(await getProductInfo(productId)))));
  }

  Future getProductInfo(String productToken) async {
    return productCollection
        .doc(productToken)
        .get()
        .then((DocumentSnapshot documentSnapshot) => documentSnapshot.data());
  }

  Future bookmarkProduct(String userID, String productID) async {
    var doc = bookmarkCollection.doc(userID);
    doc.get().then((DocumentSnapshot documentSnapshot) {
      if (!documentSnapshot.exists) {
        doc.set({
          "productIDs": [productID],
        });
      } else {
        doc.update({
          "productIDs": FieldValue.arrayUnion([productID])
        });
      }
    });
  }

  Future unBookmarkProduct(String userID, String productID) async {
    bookmarkCollection.doc(userID).update({
      "productIDs": FieldValue.arrayRemove([productID])
    });
  }

  Future<bool> isProductBookmarked(String userID, String productID) async {
    var allProducts = await bookmarkCollection
        .doc(userID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return (documentSnapshot.data() ?? {"productIDs": []})
          as Map<String, dynamic>;
    });

    List<dynamic> productIds = allProducts["productIDs"];
    return productIds.contains(productID);
  }

  Future<void> updatePriceOfProduct(
      String productToken, double newCurrentPrice) async {
    productCollection
        .doc(productToken)
        .update({"current-price": newCurrentPrice});
  }

  Future<void> updateStockOfProduct(
      String productToken, int newStockCount) async {
    productCollection
        .doc(productToken)
        .update({"remaining-stock-count": newStockCount});
  }

  Future<void> updateDiscountOfProduct(
      String productToken, double newDiscount) async {
    productCollection.doc(productToken).update({"discount": newDiscount});
  }

  Future<void> deleteProductOnSale(String productToken) async {
    productCollection.doc(productToken).delete();
  }

  Future<void> createOrder(String userToken) async {
    var cart = await cartCollection
        .doc(userToken)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.data() as Map<String, dynamic>;
    });

    var deneme = Map.fromEntries(await Future.wait(cart.entries.map(
        (entry) async =>
            MapEntry(entry.key, await getProductInfo(entry.key)))));

    Map<String, Map<String, dynamic>> orderProductInfo = {};
    cart.forEach((key, value) {
      Map<String, dynamic> singleProductInfo = {};
      singleProductInfo["quantity"] = value;
      singleProductInfo["status"] = "Order Received";

      Map<String, dynamic> productInfo = deneme[key];

      singleProductInfo["selling-price"] =
          productInfo["current-price"] * (1 - productInfo["discount"]);
      orderProductInfo[key] = singleProductInfo;
    });

    DateTime now = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String dateOnly = formatter.format(now);
    //String dateOnly = DateTime(now.year, now.month, now.day).toString();

    String orderID = "";

    await orderCollection.add({
      "order-id": "",
      "order-date": dateOnly,
      "buyer": userToken,
      "products": orderProductInfo,
    }).then((value) {
      orderID = value.id;
      orderCollection.doc(value.id).update({"order-id": value.id});
    });

    await notificationCollection.add({
      "receiver": userToken,
      "order-id": orderID,
      "date": DateTime.now().millisecondsSinceEpoch,
      "viewed": false,
      "status": "Order Received",
      "notification-id": "",
    }).then((value) {
      notificationCollection.doc(value.id).update({"notification-id": value.id});
    });

    // empty cart
    await emptyCart(userToken, cart);

    cart.forEach((key, value) {
      Map<String, dynamic> productInfo = deneme[key];
      soldCollection.add({
        "sold-id": "",
        "product-id": key,
        "sold-date": dateOnly,
        "quantity": value,
        "buyer": userToken,
        "seller": productInfo["seller-id"],
        "selling-price":
            productInfo["current-price"] * (1 - productInfo["discount"]),
        "status": "Order Received",
        "order-id": orderID,
        "review-given": false,
      }).then((value) {
        soldCollection.doc(value.id).update({"sold-id": value.id});
      });
    });

    // Update the remaining product count of sold products
    // Update the sold count of a product
    cart.forEach((key, value) {
      productCollection.doc(key).update({
        "remaining-stock-count": FieldValue.increment(-1 * value),
        "sold-count": FieldValue.increment(value),
      });
    });
  }

  Future<void> emptyCart(String userToken, Map<String, dynamic> cart) async {
    cart.keys.forEach((productToken) {
      cartCollection.doc(userToken).update({
        productToken: FieldValue.delete(),
      });
    });
  }

  Future<void> updateOrderStatus(String soldID, String newUpdate) async {
    //  UPDATE SOLDS COLLECTION

    var soldItem = await soldCollection
        .doc(soldID)
        .get()
        .then((value) => value.data() as Map<String, dynamic>);

    soldCollection.doc(soldID).update({
      "status": newUpdate,
    });

    await notificationCollection.add({
      "receiver": soldItem["buyer"],
      "order-id": soldItem["order-id"],
      "date": DateTime.now().millisecondsSinceEpoch,
      "viewed": false,
      "status": "New Update",
      "notification-id": "",
    }).then((value) {
      notificationCollection.doc(value.id).update({"notification-id": value.id});
    });



    /*final userNotification = notificationCollection.where("order-id",
        isEqualTo: soldItem["order-id"]);
    final result = await userNotification.get();

    if (result.docChanges.isNotEmpty) {
      final doc = result.docChanges.first.doc;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data["status"] = newUpdate;
      data["date"] = DateTime.now().millisecondsSinceEpoch;
      await notificationCollection.add(data);
    }*/

    // ADD NOTIFICATION FOR THAT USER
  }

  Future<void> addReview(String userToken, String productToken,
      String sellerToken, String comment, double rating, String orderID) async {
    DateTime now = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String dateOnly = formatter.format(now);
    //String dateOnly = DateTime(now.year, now.month, now.day).toString();

    await reviewCollection.add({
      "review-id": "",
      "status": "Pending",
      "comment": comment,
      "rating": rating,
      "user-id": userToken,
      "seller-id": sellerToken,
      "product-id": productToken,
      "review-date": dateOnly,
    }).then((value) {
      reviewCollection.doc(value.id).update({"review-id": value.id});
    });

    List<Map<String, dynamic>> orderToUpdate = await getAllCollectionItems(
        soldCollection
            .where("order-id", isEqualTo: orderID)
            .where("product-id", isEqualTo: productToken));

    String soldID = orderToUpdate[0]["sold-id"];

    soldCollection.doc(soldID).update({"review-given": true});

    List<Map<String, dynamic>> productInfo = await getAllCollectionItems(
        productCollection.where("product-id", isEqualTo: productToken));

    int commentCount = int.parse(productInfo[0]["comment-count"]);

    // UPDATE THE PRODUCT RATING
    // UPDATE REVIEW COUNT
    await productCollection.doc(productToken).update({
      "rating":
          (commentCount * double.parse(productInfo[0]["rating"]) + rating) /
              (commentCount + 1),
      "comment-count": FieldValue.increment(1),
    });

    // UPDATE THE USER RATING
    List<Map<String, dynamic>> reviewInfo = await getAllCollectionItems(
        reviewCollection.where("seller-id", isEqualTo: sellerToken));

    double totalRating = 0;
    for (int i = 0; i < reviewInfo.length; i++)
      totalRating += double.parse(reviewInfo[i]["rating"]);

    await userCollection.doc(sellerToken).update({
      "rating": totalRating / reviewInfo.length,
    });
  }

  Future<void> approveReview(String reviewID) async {
    reviewCollection.doc(reviewID).update({"status": "Approved"});
  }

  Future<void> denyReview(String reviewID) async {
    reviewCollection.doc(reviewID).update({"status": "Denied"});
  }

  Future<List<String>> getBrandNames() async {
    List<Map<String, dynamic>> allProducts =
        await getAllCollectionItems(productCollection);

    Set<String> distinctBrandNames = {
      ...allProducts.map((productInfo) => productInfo["brand-name"].toString())
    };
    return distinctBrandNames.toList() as List<String>;
  }

  Future<List<double>> getFootSizes() async {
    List<Map<String, dynamic>> allProducts =
        await getAllCollectionItems(productCollection);

    Set<double> distinctFootSizes = {
      ...allProducts.map((productInfo) => productInfo["foot-size"])
    };
    return distinctFootSizes.toList() as List<double>;
  }

  Future<List<FootWearItem>> getCategoryProducts(String category) async {
    var productList = await productCollection
        .where('category', isEqualTo: category)
        .get()
        .then((value) {
      var result = value.docs;
      List<Map<String, dynamic>> allProducts = [];
      for (var doc in result) {
        if (doc.data() != null) {
          var data = doc.data() as Map<String, dynamic>;
          allProducts.add(data);
        }
      }
      return allProducts;
    });

    return await Future.wait(productList
        .map((productInfos) => returnFootwearItem(productInfos))
        .toList());
  }

  Future<void> addAddress(
      String userToken, String mainAddress, String detailedAddress) async {
    addressCollection.doc(userToken).set(
      {mainAddress: detailedAddress},
      SetOptions(merge: true),
    );
  }

  Future<List<OrderTile>> getOrdersOfUser(String userToken) async {
    List<Map<String, dynamic>> allOrdersOfUser = await getAllCollectionItems(
        soldCollection.where("buyer", isEqualTo: userToken));

    return Future.wait(allOrdersOfUser.map((orderInfo) async {
      var productInfo = await getProductInfo(orderInfo["product-id"]);

      return OrderTile(
        product: await returnFootwearItem(productInfo),
        userID: userToken,
        quantity: orderInfo["quantity"],
        orderDate: orderInfo["sold-date"].toString(),
        status: orderInfo["status"],
        orderID: orderInfo["order-id"],
        reviewGiven: orderInfo["review-given"] as bool,
      );
    }).toList());
  }

  Future<List<CommentsTile>> getCommentsOfUser(String userToken) async {
    List<Map<String, dynamic>> allComments = await getAllCollectionItems(
        reviewCollection.where("user-id", isEqualTo: userToken));

    return Future.wait(allComments.map((commentInfo) async {
      var productInfo = await getProductInfo(commentInfo["product-id"]);
      //var buyerInfo = await getUserInfo(commentInfo["user-id"]);

      return CommentsTile(
        product: await returnFootwearItem(productInfo),
        comment: commentInfo["comment"],
        reviewDate: commentInfo["review-date"],
        status: commentInfo["status"],
        rating: commentInfo["rating"],
      );
    }).toList());
  }

  Future<List<OrderUpdatesTile>> getOrderUpdates(String userID) async {
    var result = await getAllCollectionItems(notificationCollection
        .where("receiver", isEqualTo: userID)
        .where("order-id", isNull: false)
        .where("viewed", isEqualTo: false));
    result.sort((b, a) => a["date"].compareTo(b["date"]));

    return result
        .map((e) => OrderUpdatesTile(
            notificationDate: e["date"],
            orderNumber: e["order-id"],
            updateMessage: e["status"], 
            notificationID: e["notification-id"],))
        .toList();
  }

  Future<List<CommentApproveTile>> getCommentsToApprove(
      String userToken) async {
    List<Map<String, dynamic>> allCommentToApprove =
        await getAllCollectionItems(reviewCollection
            .where("seller-id", isEqualTo: userToken)
            .where("status", isEqualTo: "Pending"));

    return Future.wait(allCommentToApprove.map((commentInfo) async {
      var productInfo = await getProductInfo(commentInfo["product-id"]);
      var buyerInfo = await getUserInfo(commentInfo["user-id"]);

      return CommentApproveTile(
        product: await returnFootwearItem(productInfo),
        username: buyerInfo["username"],
        comment: commentInfo["comment"],
        denyComment: () {},
        approveComment: () {},
        reviewID: commentInfo["review-id"],
      );
    }).toList());
  }

  Future<void> readNotification(String notiticationID) async {
    notificationCollection.doc(notiticationID).update({"viewed": true});
  }
}
