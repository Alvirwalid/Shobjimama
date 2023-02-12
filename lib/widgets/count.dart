import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shobjimama/model/productmodel.dart';
import 'package:shobjimama/providers/productprovider.dart';
import 'package:shobjimama/service/db_helper.dart';

import '../service/globalmethod.dart';

class Count extends StatefulWidget {
  Count(
      {super.key,
      required this.productId,
      required this.quantity,
      required this.isSelect});

  String productId;
  int quantity;
  bool isSelect = false;

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool istrue = false;
  getAddAndQuantity() async {
    setState(() {
      count = widget.quantity;
    });
    // FirebaseFirestore.instance
    //     .collection('products')
    //     .doc(widget.productId)
    //     .get()
    //     .then((DocumentSnapshot value) {
    //   if (this.mounted) {
    //     if (value.exists) {
    //       setState(() {
    //         count = value['quantity'];
    //       });
    //     }
    //   }
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    getAddAndQuantity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    List<ProductModel> productList = provider.getProduct;

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text('${widget.isSelect}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                if (count > 1) {
                  setState(() {
                    count--;
                    istrue = false;
                  });

                  if (widget.isSelect == true) {
                    await FirebaseFirestore.instance
                        .collection('products')
                        .doc(widget.productId)
                        .update({'quantity': '${count.toString()}'});
                  }

                  ///provider.updatequantity(id: widget.productId, quantity: 90);
                }
              },
              child: Icon(
                Icons.remove,
                size: 24,
                color: Color(0xffd0b84c),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "$count",
              style: TextStyle(
                color: Color(0xffd0b84c),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  count++;
                });

                if (widget.isSelect == true) {
                  await FirebaseFirestore.instance
                      .collection('products')
                      .doc(widget.productId)
                      .update({'quantity': '${count.toString()}'});
                }
              },
              child: Icon(Icons.add, size: 24, color: Color(0xffd0b84c)),
            )
          ],
        ),
      ],
    );
  }
}
