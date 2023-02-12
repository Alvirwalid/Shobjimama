import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_check_box/custom_check_box.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shobjimama/screen/user.dart';

import '../const/const.dart';
import '../const/firebase_auth.dart';
import '../model/productmodel.dart';
import '../provider/darkthemeprovider.dart';
import '../providers/productprovider.dart';
import '../service/globalmethod.dart';
import '../service/streamtotal.dart';
import '../service/utils.dart';
import '../widgets/categories.dart';

import '../widgets/count.dart';
import '../widgets/textwidhet.dart';
import 'auth/loginpage.dart';

class TesPage extends StatefulWidget {
  TesPage({super.key});
  static const routename = '/TesPage';

  @override
  State<TesPage> createState() => _TesPageState();
}

class _TesPageState extends State<TesPage> {
  List<bool>? _isChecked;

  List<ProductModel>? prod;

  List<String> _texts = [
    "InduceSmile.com",
    "Flutter.io",
    "google.com",
    "youtube.com",
    "yahoo.com",
    "gmail.com"
  ];

  String? name, email;
  final User? user = authinstance.currentUser;

  void getUserdata() async {
    var uid = user!.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot doc) {
      name = doc['name'];
      email = doc['email'];
    });
  }

  //  getAddAndQuantity() async {
  //   FirebaseFirestore.instance
  //       .collection('products')
  //       .doc(widget.productId)
  //       .get()
  //       .then((DocumentSnapshot value) {
  //     if (this.mounted) {
  //       if (value.exists) {
  //         setState(() {
  //           count = value['quantity'];
  //         });
  //       }
  //     }
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    // var productProvider = Provider.of<ProductProvider>(context, listen: false);
    //  List<ProductModel> productList = productProvider.getProduct;

    // _isChecked = List<bool>.filled(productList.length, false);
    getUserdata();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    var productProvider = Provider.of<ProductProvider>(context, listen: false);

    prod = productProvider.getProduct;
    _isChecked = List<bool>.filled(prod!.length, false);

    super.didChangeDependencies();
  }

  int dex = 0;
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> productList = productProvider.getProduct;
    final themeState = Provider.of<DarkThemeProvider>(context);

    Stream getSnashot =
        FirebaseFirestore.instance.collection('products').snapshots();
    Size size = Utils(context).screensize;
    Color color = Utils(context).colors;
    int count = 0;
    double total = 0.0;

    String name = '';

    //_isChecked = List<bool>.filled(_texts.length, false);

    // _isChecked!.forEach(
    //   (element) {
    //     getTotal() {
    //       return element
    //           ? productList
    //               .fold(
    //                   0.0,
    //                   (double prev, element) =>
    //                       prev + (element.price * element.amount))
    //               .toStringAsFixed(2)
    //           : 0.0;
    //     }
    //   },
    // );

    // getTotal() {
    //   var total;
    //   // ignore: avoid_function_literals_in_foreach_calls
    //   _isChecked!.forEach((element) {
    //     setState(() {
    //       total = productList
    //           .fold(
    //               0.0,
    //               (double prev, element) =>
    //                   prev + (element.price * element.amount))
    //           .toStringAsFixed(2);
    //     });
    //   });

    //   return total;
    // }

    return Scaffold(
        drawer: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: 270,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(TesPage.routename);
                },
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title:
                    Textwidget(text: 'Home', color: Colors.white, textsize: 18),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(
                    ProfileScreen.routename,
                  );
                },
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: Textwidget(
                    text: 'Profile', color: Colors.white, textsize: 18),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  // Get.toNamed(ProfileScreen.routename);
                },
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                title: Textwidget(
                    text: 'Favorite', color: Colors.white, textsize: 18),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
              _listtile(
                  icon: user == null ? IconlyLight.login : IconlyLight.logout,
                  title: user == null ? 'Login' : 'Logout',
                  onpressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    setState(() {
                      pref.setString('email', '');
                      pref.setString('password', '');
                      pref.setString('accessToken', '');
                      pref.setString('idToken', '');
                    });
                    if (user == null) {
                      Get.toNamed(LoginPage.routename);
                      return;
                    }
                    GlobalMethod.warningDialog(
                        ctx: context,
                        title: 'Signout',
                        subtitle: 'Do you wanna signout',
                        onpressed: () async {
                          await authinstance.signOut();

                          Get.offAndToNamed(LoginPage.routename);
                        });
                  }),

              SizedBox(
                height: size.height * 0.01,
              ),
              //  customListile(icon: Icons.favorite, text: 'Favorite', fct: () {}),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: productList.isEmpty
            ? Center(
                child: Text("NO DATA"),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      //color: Colors.red,
                      height: size.height * 0.10,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage(Constss.offerList[index]))),
                          );
                        },

                        autoplay: true,
                        itemCount: Constss.offerList.length,
                        pagination: const SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            builder: DotSwiperPaginationBuilder(
                                color: Colors.white, activeColor: Colors.red)),
                        // control: const SwiperControl(),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.6),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Textwidget(
                        text: 'Category',
                        color: Colors.black,
                        textsize: 18,
                        istitle: true,
                      ),
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.6),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(height: 70, child: Categories()),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Textwidget(
                      text: 'Our Product',
                      color: color,
                      textsize: 20,
                      istitle: true,
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),

                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        ProductModel data = productList[index];
                        count = data.quantity;

                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                          height: size.height * 0.18,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomCheckBox(
                                value: _isChecked![index],
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked![index] = value;

                                    print(_isChecked!);
                                    //  print(index);
                                  });
                                },
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FancyShimmerImage(
                                        imageUrl: productList[index].imageUrl,
                                        height: 90,
                                        width: 110,
                                        boxFit: BoxFit.fill,
                                      ),
                                    ),
                                    Text(
                                      productList[index].title,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
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
                                            '\৳${data.price * count}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          productList[index].isPiece
                                              ? Textwidget(
                                                  text: 'Piece',
                                                  color: color,
                                                  textsize: 18)
                                              : Textwidget(
                                                  text: 'kg',
                                                  color: color,
                                                  textsize: 18)
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Count(
                                      productId: data.id,
                                      quantity: data.quantity,
                                      isSelect: _isChecked![index],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 100,
                    ),

                    // Container(
                    //   height: size.height / 1.28,
                    //   width: size.width,
                    //   child: StreamBuilder<QuerySnapshot>(
                    //     stream: FirebaseFirestore.instance.collection('products'),
                    //     builder: (BuildContext context,
                    //         AsyncSnapshot<QuerySnapshot> snapshot) {
                    //       if (snapshot.data != null) {
                    //         return Container();
                    //       } else {
                    //         return Container();
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          color: Colors.green,
          width: double.infinity,
          height: 80,
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var total = 0.0;

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                total += double.parse(snapshot.data!.docs[i]['price']) *
                    int.parse(snapshot.data!.docs[i]['quantity']);
              }
              return Row(
                children: [
                  Textwidget(
                      text: 'Total $total', color: Colors.white, textsize: 18),
                ],
              );

              // for (int i = 0; i < snapshot.data!.docs.length; i++) {
              //   tut += double.parse(snapshot.data!.docs[i]['price']);
              // }

              // if (snapshot.hasError) {
              //   print('error occured');
              // }

              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return CircularProgressIndicator();
              // }

              // return Container(
              //     color: Colors.red,
              //     width: 150,
              //     height: 100,
              //     padding: EdgeInsets.all(30),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         //Text(tut == null ? 'total' : '$tut')
              //       ],
              //     ));
            },
          ),
        )

        //  Container(
        //   width: double.infinity,
        //   height: 80,
        //   decoration: BoxDecoration(color: Colors.green),
        //   child: Row(
        //     children: [
        //       SizedBox(
        //         width: 10,
        //       ),

        //       // SreatTotal()
        //       // Text(
        //       //   '${productProvider.gettotalPrice()}',
        //       //   style: TextStyle(color: Colors.white),
        //       // ),
        //     ],
        //   ),
        // ),
        );
  }

  ListTile _listtile(
      {required IconData icon,
      required String title,
      required Function onpressed}) {
    return ListTile(
      minVerticalPadding: 0,
      horizontalTitleGap: 0,
      leading: Padding(
        padding: const EdgeInsets.only(top: 7),
        child: Icon(
          icon,
          color: Colors.white,
          size: 26,
        ),
      ),
      title: Textwidget(text: title, color: Colors.white, textsize: 18),
      onTap: () {
        onpressed();
      },
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
