import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_footwear_project/components/footwear_item.dart';
import 'package:cs310_footwear_project/services/storage.dart';
import 'package:cs310_footwear_project/ui/bookmarks_tile.dart';
import 'package:cs310_footwear_project/ui/onsale_tile.dart';
import 'package:cs310_footwear_project/ui/sold_tile.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Directory, File, Platform;

import 'package:path_provider/path_provider.dart';

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

  Future updateUserPassword(String token, String newPassword) async {
    userCollection.doc(token).update({'password': newPassword});
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

  Future getAllProducts() async {
    return productCollection.get().then((QuerySnapshot querySnapshot) {
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
      File image) async {
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
    }).then((value) {
      productCollection.doc(value.id).update({"product-id": value.id});

      // Uplaod the new image to Firebase
      storage.uploadProductPict(image, value.id);
    }).catchError((error) {
      print('Error: ${error.toString()}');

      return error.toString();
    });
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
      print(allProducts);
      return allProducts;
    });

    return await Future.wait(productList.map((product) async {
      Map<String, dynamic> userInfo = await getUserInfo(product["seller-id"]);
      Image img = await storage.returnImage(product["product-id"]);

      return OnSaleTile(
        product: await returnFootwearItem(product),
        remove: () => {},
        applyDiscount: () => {},
        stockUpdate: () => {},
        priceUpdate: () => {},
      );
    }));
  }

  Future getProductsSold(String sellerID) async {
    var allProducts = await productCollection
        .where('seller-id', isEqualTo: sellerID)
        //.where('remaining-stock-count', isGreaterThan: 0)
        .get()
        .then((value) {
      var result = value.docs;
      List<Map<String, dynamic>> allProducts = [];
      for (var doc in result) {
        if (doc.data() != null) {
          var data = doc.data() as Map<String, dynamic>;

          if (data['sold-count'] > 0) allProducts.add(data);
        }
      }
      return allProducts;
    });

    return await Future.wait(allProducts.map((product) async {
      Map<String, dynamic> userInfo = await getUserInfo(product["seller-id"]);
      Image img = await storage.returnImage(product["product-id"]);

      return SoldTile(
        product: await returnFootwearItem(product),
      );
    }));
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
    );
  }

  Future addProductToCart(String userID, String productID) async {
    cartCollection.doc(userID).set({
      productID: 1,
    });
  }

  Future updateProductQuantityAtCart(
      String userID, String productID, int newQuantity) async {
    cartCollection.doc(userID).update({productID: newQuantity});
  }

  Future getCartOfUser(String userID) async {
    return cartCollection
        .doc(userID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.data();
    });
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
}
