import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shobjimama/model/productmodel.dart';

class ProductProvider with ChangeNotifier {
  final List<ProductModel> productList = [];

  List<ProductModel> get getProduct {
    return productList;
  }

  Future<void> fetchData() async {
    try {
      // await FirebaseFirestore.instance.collection("pr").get().then((event) {
      //   for (var doc in event.docs) {
      //     //print("${doc.id} => ${doc.data()}");

      //     productList.insert(
      //         0,
      //         ProductModel(
      //             id: doc['id'],
      //             title: doc['title'],
      //             imageUrl: doc['imageUrl'],
      //             productCategoryName: doc['productcategoryname'],
      //             price: double.parse(doc['price']),
      //             isOnSale: doc['isOnSale'],
      //             salePrice: doc['salePrice'],
      //             isPiece: doc['isPiece']));
      //   }
      // });
      await FirebaseFirestore.instance
          .collection('products')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          double price = 0.0;
          price = double.parse(doc['price']);
          notifyListeners();
          productList.insert(
              0,
              ProductModel(
                  id: doc['id'],
                  title: doc['title'],
                  imageUrl: doc['imageUrl'],
                  productCategoryName: doc['productcategoryname'],
                  price: double.parse('${doc['price']}'),
                  quantity: int.parse('${doc['quantity']}'),
                  isOnSale: doc['isOnSale'],
                  salePrice: double.parse('${doc['salePrice']}'),
                  isPiece: doc['isPiece']));
          notifyListeners();
        });
        notifyListeners();
      });
    } on FirebaseException catch (err) {
      Get.snackbar('Error Occured', '$err');
    } catch (err) {
      Get.snackbar('Error Occured', '$err',
          backgroundColor: Colors.teal, colorText: Colors.white);
    }
  }

  ProductModel findById(String productId) {
    return productList.firstWhere((element) => element.id == productId);
  }

  List<ProductModel> findByCategory(String categoryName) {
    return productList
        .where((element) =>
            element.productCategoryName.toLowerCase() ==
            categoryName.toLowerCase())
        .toList();
  }

  void updatequantity({
    required String id,
    required int quantity,
  }) async {
    FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .update({'quantity': quantity.toString()}).then((value) {
      print('update successfully');
    });
  }

//   getstream()async{
// StreamProvider<QuerySnapshot>(
//   create: FirebaseFirestore.instance.collection('products').snapshots(),
//    initialData: )

//   }

  gettotalPrice() {
    double total = 0.0;
    productList.forEach((element) {
      total += element.price * element.quantity;
    });
    //notifyListeners();
    return total;
  }
}
