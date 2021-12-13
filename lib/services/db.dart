import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection("products");

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

  Future getUserInfo(String token) async {
    return userCollection
        .doc(token)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      //print(documentSnapshot.data());
      return documentSnapshot.data();
    });
  }

  Future addProductAuto(String productName, String brandName, String category,
      double price, int stockCount, double footSize, String productDetails, String sellerID) async {
    productCollection
      .add({
        'product-name': productName,
        'brand-name': brandName,
        'category': category,
        'price': price,
        'stock-count': stockCount,
        'foot-size': footSize,
        'details': productDetails,
        'seller-id': sellerID,
      })
        .then((value) => print("Product added!"))
        .catchError((error) => print('Error: ${error.toString()}'));
  }
}
