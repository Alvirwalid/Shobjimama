import 'dart:ffi';

import 'package:flutter/material.dart';

import '../model/cartmodel.dart';
import '../service/db_helper.dart';

class CartProvider extends ChangeNotifier {
  List<AddCartModel> cartlist = [];
  Future<bool> addcart(AddCartModel addCartModel) async {
    final rowId = await DBHelper.insertcart(addCartModel);
    if (rowId > 0) {
      addCartModel.id = rowId;
      notifyListeners();
      return true;
    }
    return false;
  }

  getallCarts() {
    DBHelper.getAllCarts().then((value) {
      cartlist = value;
      notifyListeners();
    });
  }

  updatecartquantity(int? id, int value) {
    DBHelper.updatequantity(id, value).then((_) {
      notifyListeners();
    });
  }

  updatecartprice(int? id, int value) {
    DBHelper.updatetotalprice(id, value.toString()).then((_) {
      notifyListeners();
    });
  }

  update(int? id, int value) {
    DBHelper.updateselection(id, value).then((_) {
      notifyListeners();
    });
  }

  int getsubtotal() {
    int i = 0, subt = 0;
    for (i = 0; i < cartlist.length; i++) {
      if(cartlist[i].select==1)
        {
          subt = subt + cartlist[i].totalprice;
        }
    }
    return subt;
  }
}
