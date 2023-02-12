import 'package:flutter/material.dart';

import '../service/utils.dart';
import 'textwidhet.dart';

class Pricewidget extends StatelessWidget {
  const Pricewidget(
      {Key? key,
      required this.saleprice,
      required this.price,
      required this.textprice,
      required this.isonsale})
      : super(key: key);
  final double saleprice, price;

  final String textprice;

  final bool isonsale;

  @override
  Widget build(BuildContext context) {
    final double userprice = isonsale ? saleprice : price;
    final utils = Utils(context);
    Size size = utils.screensize;
    Color color = utils.colors;
    return FittedBox(
      child: Row(
        children: [
          Textwidget(
              text:
                  '\৳${(userprice * int.parse(textprice)).toStringAsFixed(2)}',
              color: Colors.green,
              textsize: 20),
          const SizedBox(
            width: 8,
          ),
          // Visibility(
          //   visible: isonsale ? true : false,
          //   child: Text(
          //     '\$${(price * int.parse(textprice)).toStringAsFixed(2)}',
          //     style: TextStyle(
          //         fontSize: 16, decoration: TextDecoration.lineThrough),
          //   ),
          // )
        ],
      ),
    );
  }
}
