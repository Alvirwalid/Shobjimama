const String tablecart = 'tbl_cart';
const String tablecartid = 'id';
const String tablecartproductselect = 'selected';
const String tablecartproductname = 'product_name';
const String tablecartproductprice = 'price';
const String tablecartproductsize = 'size';
const String tablecartproductquantity = 'quantity';
const String tablecartproductimage = 'image';
const String tablecartproducttotalprice = 'total_price';

class AddCartModel {
  int? id;
  String product_name;
  int price;
  int select;
  String size;
  String image;
  int quantity;
  int totalprice;

  AddCartModel({
    this.id,
    required this.product_name,
    required this.select,
    required this.price,
    required this.size,
    required this.image,
    required this.quantity,
    required this.totalprice,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      tablecartproductname: product_name,
      tablecartproductselect:select,
      tablecartproductprice: price,
      tablecartproductsize: size,
      tablecartproductimage: image,
      tablecartproductquantity: quantity,
      tablecartproducttotalprice: totalprice,
    };
    if (id != null) {
      map[tablecartid] = id;
    }
    return map;
  }

  factory AddCartModel.fromMap(Map<String, dynamic> map) => AddCartModel(
        id: map[tablecartid],
        product_name: map[tablecartproductname],
        select: map[tablecartproductselect],
        price: map[tablecartproductprice],
        size: map[tablecartproductsize],
        image: map[tablecartproductimage],
        quantity: map[tablecartproductquantity],
        totalprice: map[tablecartproducttotalprice],
      );
}
