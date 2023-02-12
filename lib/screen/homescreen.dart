import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shobjimama/model/productmodel.dart';
import 'package:shobjimama/providers/productprovider.dart';
import 'package:shobjimama/screen/user.dart';

import '../const/const.dart';
import '../const/firebase_auth.dart';
import '../model/cartmodel.dart';
import '../provider/cartprovider.dart';
import '../provider/darkthemeprovider.dart';
import '../providers/variables.dart';
import '../service/globalmethod.dart';
import '../service/utils.dart';
import '../widgets/categories.dart';
import '../widgets/feed_widget.dart';
import '../widgets/textwidhet.dart';
import 'auth/loginpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  static const routename = '/Homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<bool>? _isChecked;
  List<ProductModel>? prod;
  String? name, email;
  final User? user = authinstance.currentUser;
  // List<ProductModel> productList;

  // double tptalprice = 1.0;

  // Future<void> getUserData() async {
  //   try {
  //     //final _uid = user!.uid;

  //     FirebaseFirestore.instance
  //         .collection('products')
  //         .get()
  //         .then((QuerySnapshot querySnapshot) {
  //       querySnapshot.docs.forEach((doc) {
  //         print(doc["title"]);

  //         setState(() {
  //           name = doc["productcategoryname"];
  //           //loaction = doc["location"];
  //           //shopimageUrl = doc["imageurl"];
  //           // shoprating = doc["rating"];
  //         });
  //       });
  //     });
  //   } on FirebaseFirestore catch (error) {
  //     // GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
  //   } catch (error) {
  //     //GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
  //   }
  // }
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

  @override
  void initState() {
    // TODO: implement initState
    // final pppp = Provider.of<ProductProvider>(context, listen: false);
    // pppp.fetchData();
    // getUserData();
    getUserdata();
    super.initState();
  }

  int addcount = 0;
  @override
  Widget build(BuildContext context) {
    Provider.of<CartProvider>(context, listen: false).getallCarts();
    Provider.of<ProductProvider>(context, listen: false);
    var productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> productList = productProvider.getProduct;
    var cartprovider = Provider.of<CartProvider>(context);
    cartprovider.getallCarts();
    double total = cartprovider.getsubtotal().toDouble();
    List<AddCartModel> productListcart = cartprovider.cartlist;
    int i = 0;
    void addtocart(String name, double price, String img) async {
      bool isdupli = false;
      final cart = AddCartModel(
        product_name: name,
        select: 0,
        price: price.round(),
        size: '',
        image: img,
        quantity: 0,
        totalprice: price.round(),
      );
      print(cart.toString());
      final status =
          await Provider.of<CartProvider>(context, listen: false).addcart(cart);
      if (status) {
        addcount++;
        print('Succesfuly Added Question No: ');
      }
    }

    if (productListcart.length <= 0) {
      for (int i = 0; i < productList.length; i++) {
        addtocart(productList[i].title, productList[i].price,
            productList[i].imageUrl);
        if (i == productList.length) break;
      }
    }

    // fin
    var strrrr = Provider.of<StringProvider>(context);

    //double price = double.parse(strrrr.str);
    bool ischeck = false;

    final themeState = Provider.of<DarkThemeProvider>(context);
    Size size = Utils(context).screensize;
    Color color = Utils(context).colors;

    // getTotal() {
    //   return productList
    //       .fold(0.0,
    //           (double prev, element) => prev + (element.price * element.amount))
    //       .toStringAsFixed(2);
    // }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: Colors.black),
        ),
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
                  Get.toNamed(Homepage.routename);
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
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              // color: Colors.red
              ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                // Expanded(child: Text('data')),
                // Expanded(child: Text('data')),
                // Expanded(child: Text('data'))
                Container(
                  //color: Colors.red,
                  height: size.height * 0.20,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(Constss.offerList[index]))),
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8),
                //   child: Textwidget(
                //     text: 'Category',
                //     color: Colors.black,
                //     textsize: 18,
                //     istitle: true,
                //   ),
                // ),
                // Divider(
                //   color: Colors.grey.withOpacity(0.6),
                // ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                // SizedBox(height: 70, child: Categories()),
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
                Consumer<CartProvider>(
                    builder: (context, provider, _) => ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: provider.cartlist.length,
                          itemBuilder: (context, index) {
                            final currentProduct = provider.cartlist[index];
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 14),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CustomCheckBox(
                                      value:
                                          provider.cartlist[index].select == 0
                                              ? false
                                              : true,
                                      checkBoxSize: 30,
                                      checkedIconColor: Colors.green,
                                      uncheckedIconColor: Colors.red,
                                      checkedFillColor:
                                          Colors.green.withOpacity(0.2),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          provider.update(
                                              index + 1, value! ? 1 : 0);
                                          total =
                                              provider.getsubtotal().toDouble();
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
                                            imageUrl:
                                                provider.cartlist[index].image,
                                            height: 90,
                                            width: 110,
                                            boxFit: BoxFit.fill,
                                          ),
                                        ),
                                        Text(
                                          provider.cartlist[index].product_name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
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
                                      flex: 4,
                                      child: Column(
                                        children: [
                                          Text(
                                              "${provider.cartlist[index].totalprice.toStringAsFixed(2)} €"),
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      int q = provider
                                                          .cartlist[index]
                                                          .quantity;
                                                      q++;
                                                      provider
                                                          .updatecartquantity(
                                                              index + 1, q);
                                                      provider.updatecartprice(
                                                          index + 1,
                                                          q *
                                                              provider
                                                                  .cartlist[
                                                                      index]
                                                                  .price);
                                                    });
                                                  },
                                                  icon: const Icon(Icons.add)),
                                              Text(
                                                '${provider.cartlist[index].quantity}',
                                                textAlign: TextAlign.center,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    int q = provider
                                                        .cartlist[index]
                                                        .quantity;
                                                    if (provider.cartlist[index]
                                                            .quantity >
                                                        0) {
                                                      q--;
                                                      provider
                                                          .updatecartquantity(
                                                              index + 1, q);
                                                      int price = (provider
                                                                  .cartlist[
                                                                      index]
                                                                  .totalprice -
                                                              provider
                                                                  .cartlist[
                                                                      index]
                                                                  .price)
                                                          .round();
                                                      provider.updatecartprice(
                                                          index + 1, price);
                                                    }
                                                  });
                                                },
                                                icon: const Icon(Icons.remove),
                                              )
                                            ],
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            );
                          },
                        ))

                // ListView(
                //   //  padding: EdgeInsets.symmetric(vertical: 10),
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   children: List.generate(productList.length, (index) {
                //     final currentProduct = productList[index];

                //     return ChangeNotifierProvider.value(
                //       value: productList[index],
                //       child: FeedWidget(
                //           id: productList[index].id,
                //           currentProduct: currentProduct),
                //     );
                //   }),
                // )
              ],
            ),
          ),
        ),
        resizeToAvoidBottomInset: true,
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          // margin: EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              )),

          height: 70,
          width: double.infinity,

          child: Row(
            children: [Text('total :$total ')],
          ),
        ),
      ),
    );
  }
// getTotal()=>produc

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
}
