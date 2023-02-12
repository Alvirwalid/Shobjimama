import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/const.dart';
import '../model/productmodel.dart';
import '../providers/variables.dart';
import '../service/utils.dart';
import 'pricewidget.dart';
import 'textwidhet.dart';

class FeedWidget extends StatefulWidget {
  FeedWidget({super.key, required this.id, required this.currentProduct});

  String id;
  final currentProduct;

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

//double totalprice = 0;

//double totalprice = 10;

class _FeedWidgetState extends State<FeedWidget> {
  final pricetextcontroller = TextEditingController();
  final _passfocus = FocusNode();
  String price = '1';
  bool ischeck = false;
  StringProvider _stringProvider = StringProvider();

  double? total;

  @override
  void initState() {
    // TODO: implement initState
    pricetextcontroller.text = '1';

    _stringProvider = Provider.of<StringProvider>(context, listen: false);
    // updateString();

    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pricetextcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var setprice = Provider.of<StringProvider>(context);
    final utils = Utils(context);
    Color color = utils.colors;
    Size size = utils.screensize;
    final productList = Provider.of<ProductModel>(context);
    // final double userprice =
    //     productList.isOnSale ? productList.salePrice : productList.price;

    // total = productList.price;
    setState(() {
      //total = ischeck?;
    });
    getTotal() {
      return widget.currentProduct
          .fold(0.0,
              (double prev, element) => prev + (element.price * element.amount))
          .toStringAsFixed(2);
    }

    void updateString() async {
      SharedPreferences shr = await SharedPreferences.getInstance();

      // shr.setDouble(
      //     'total', ischeck ? total! * int.parse(pricetextcontroller.text) : 0);
      _stringProvider.setPrice('${getTotal()}');

      //print('${setprice.str}');
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        height: size.height * 0.18,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                color: Colors.green,
                offset: Offset(2, 2),
                blurStyle: BlurStyle.outer)
          ],
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        // child: Text('data'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$total'),
            Expanded(
              flex: 2,
              child: CustomCheckBox(
                value: ischeck,
                checkBoxSize: 30,
                checkedIconColor: Colors.green,
                uncheckedIconColor: Colors.red,
                checkedFillColor: Colors.green.withOpacity(0.2),
                onChanged: (bool? value) {
                  setState(() {
                    ischeck = value!;
                  });
                },
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FancyShimmerImage(
                      imageUrl: productList.imageUrl,
                      height: 90,
                      width: 110,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    productList.title,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          '\৳${(productList.price * productList.amount).toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),

                        // Text('${productList.price * productList.quantity}'),
                        SizedBox(
                          width: 3,
                        ),
                        productList.isPiece
                            ? Textwidget(
                                text: 'Piece', color: color, textsize: 18)
                            : Textwidget(text: 'kg', color: color, textsize: 18)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      _quantityController(
                        onpressed: () async {
                          productList.amount--;
                          updateString();
                          // pricetextcontroller.text =
                          //     (int.parse(pricetextcontroller.text) - 1)
                          //         .toString();
                        },
                        clr: Colors.red,
                        icon: CupertinoIcons.minus_circle,
                      ),
                      SizedBox(
                        width: 10,
                      ),

                      Container(
                        width: 20,
                        height: 20,
                        child: Text('${productList.amount}'),
                      ),

                      // Flexible(
                      //     flex: 2,
                      //     child: SizedBox(
                      //         width: 50,
                      //         child: TextFormField(
                      //           onEditingComplete: () => FocusScope.of(context)
                      //               .requestFocus(_passfocus),
                      //           onChanged: ((value) {
                      //             setState(() {
                      //               if (value.isEmpty) {
                      //                 pricetextcontroller.text = '1';
                      //               } else {}
                      //             });
                      //           }),
                      //           key: const ValueKey('quantity'),
                      //           keyboardType: TextInputType.number,
                      //           controller: pricetextcontroller,
                      //           maxLines: 1,
                      //           decoration: const InputDecoration(
                      //             border: UnderlineInputBorder(),
                      //           ),
                      //           textAlign: TextAlign.center,
                      //           cursorColor: Colors.green,
                      //           enabled: true,
                      //           inputFormatters: [
                      //             FilteringTextInputFormatter.allow(
                      //                 RegExp('[0-9]'))
                      //           ],
                      //         ))),
                      SizedBox(
                        width: 10,
                      ),
                      _quantityController(
                          clr: Colors.green,
                          icon: CupertinoIcons.plus_circle,
                          onpressed: () async {
                            double newtotal = 0;
                            setState(() {
                              updateString();
                              productList.amount++;

                              // pricetextcontroller.text =
                              //     (int.parse(pricetextcontroller.text) + 1)
                              //         .toString();

                              // productList.quantity = productList.quantity + 1;
                              // newtotal = productList.quantity + 1;
                            });
                            await FirebaseFirestore.instance
                                .collection('products')
                                .doc(widget.id)
                                .update({'quantity': newtotal});
                            // updateString();
                          }),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _quantityController(
      {required Color clr,
      required IconData icon,
      required Function onpressed}) {
    return Flexible(
      flex: 1,
      child: Material(
        color: clr,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            onTap: (() {
              onpressed();
              setState(() {});
            }),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
