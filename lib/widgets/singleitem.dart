import 'package:custom_check_box/custom_check_box.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shobjimama/providers/productprovider.dart';
import 'package:shobjimama/widgets/textwidhet.dart';

import '../model/productmodel.dart';
import '../service/utils.dart';
import 'count.dart';

class SingleItem extends StatefulWidget {
  SingleItem(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.productPrice,
      required this.productCategoryName,
      required this.productId,
      required this.productQuantity,
      required this.isOnSale,
      required this.isPiece});

  // bool isBool = false;
  String productImage;
  String productName;
  // bool wishList = false;
  double productPrice;
  String productId;
  int productQuantity;
  String productCategoryName;
  bool isOnSale;
  bool isPiece;
  // Function onDelete;
  //var productUnit;

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  //ProductProvider? productProvider;
  List<bool>? _isChecked;
  List<ProductModel>? prod;

  int? count;
  getCount() {
    setState(() {
      count = widget.productQuantity;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    var productProvider = Provider.of<ProductProvider>(context, listen: false);

    prod = productProvider.getProduct;
    _isChecked = List<bool>.filled(prod!.length, false);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    getCount();
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    productProvider.getProduct;
    Size size = Utils(context).screensize;
    Color color = Utils(context).colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FancyShimmerImage(
                  imageUrl: widget.productImage,
                  height: 90,
                  width: 110,
                  boxFit: BoxFit.fill,
                ),
              ),
              Text(
                widget.productName,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 10,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      '\৳${widget.productPrice}',
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
                    widget.isPiece
                        ? Textwidget(text: 'Piece', color: color, textsize: 18)
                        : Textwidget(text: 'kg', color: color, textsize: 18)
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Count(
                productId: widget.productId,
                quantity: 1,
              )
            ],
          ),
        )
      ],
    );
  }
}
