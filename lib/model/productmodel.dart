import 'package:flutter/cupertino.dart';
import 'package:shobjimama/service/db_helper.dart';

class ProductModel with ChangeNotifier {
  final String id, title, imageUrl, productCategoryName;

  double price, salePrice;
  int quantity;

  int amount = 0;

  final bool isOnSale, isPiece;

  ProductModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.productCategoryName,
      required this.price,
      required this.quantity,
      required this.salePrice,
      required this.isOnSale,
      required this.isPiece});
}
