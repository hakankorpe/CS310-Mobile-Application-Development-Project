import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_footwear_project/services/storage.dart';
import 'dart:io' show File, Platform;

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
    return productCollection
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
  }

  Future getProductsSold(String sellerID) async {
    return productCollection
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
      print(allProducts);
      return allProducts;
    });
  }

  Future addProductToCart(String userID, String productID) async {
    cartCollection.doc(userID).set({
      productID: 1,
    });
  }
  
  Future updateProductQuantityAtCart(String userID, String productID, int newQuantity) async {
    cartCollection
      .doc(userID)
      .update({productID: newQuantity});
  }

  Future getCartOfUser(String userID) async {
    return cartCollection
        .doc(userID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
          return documentSnapshot.data();
        });
  }

  Future getBookmarksOfUser(String userID,) async {
    return bookmarkCollection
        .doc(userID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.data();
    });
  }

  Future bookmarkProduct(String userID, String productID) async {
    bookmarkCollection.doc(userID).update({productID: true});
  }

  Future unBookmarkProduct(String userID, String productID) async {
    bookmarkCollection.doc(userID).update({productID: false});
  }
}
