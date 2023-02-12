import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shobjimama/screen/profile.dart';
import 'package:shobjimama/screen/service.dart';

import '../provider/darkthemeprovider.dart';
import 'homescreen.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({Key? key}) : super(key: key);
  static const routename = '/BottomScreen';

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int selectesindex = 0;
  final List<Map<String, dynamic>> _pages = [
    {'page': const Homepage(), 'title': 'HomeScreen'},
    {'page': const Servicepage(), 'title': 'CategoriesScreen'},
    {'page': const UserScreen(), 'title': 'UserScreen'},
  ];
  void selectedpage(int index) {
    setState(() {
      selectesindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final cartProvider = Provider.of<Cartprovider>(context);

    // final _cartItems = cartProvider.getCartItems.values.toList();
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool isdark = themeState.getDarkTheme;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('${_pages[selectesindex]['title']}'),
      // ),
      body: _pages[selectesindex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: isdark ? Colors.white : Colors.lightBlue,
        unselectedItemColor: isdark ? Colors.lightBlue : Colors.black,
        backgroundColor: themeState.getDarkTheme
            ? Theme.of(context).cardColor
            : Colors.white,
        currentIndex: selectesindex,
        onTap: selectedpage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon:
                  Icon(selectesindex == 0 ? IconlyBold.home : IconlyLight.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                selectesindex == 1 ? Icons.room_service : Icons.room_service,
              ),
              label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(
                  selectesindex == 3 ? IconlyBold.user2 : IconlyLight.user2),
              label: 'User'),
        ],
      ),
    );
  }
}
