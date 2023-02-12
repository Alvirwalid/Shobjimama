import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shobjimama/const/themedartmode.dart';
import 'package:shobjimama/provider/cartprovider.dart';
import 'package:shobjimama/providers/variables.dart';
import 'package:shobjimama/screen/auth/loginpage.dart';
import 'package:shobjimama/screen/auth/registration.dart';
import 'package:shobjimama/screen/homescreen.dart';
import 'package:shobjimama/screen/user.dart';
import 'package:shobjimama/service/darktheme.dart';

import 'fetch_screen.dart';
import 'innerscreen/categoryscreen.dart';
import 'innerscreen/productdetails.dart';
import 'provider/darkthemeprovider.dart';
import 'providers/productprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBmL1UBh74nWLUfRmdtB0nzd4DOnnL39g4',
          appId: '1:475345764780:android:6a91206bd53963874efa09',
          messagingSenderId: '475345764780',
          projectId: 'shobjimama',
          authDomain: 'shobjimama.firebaseapp.com'));
  // runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  bottomSheetTheme:
  BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return DarkThemeProvider();
        }),
        ChangeNotifierProvider(create: (context) {
          return ProductProvider();
        }),
        ChangeNotifierProvider(create: (context) {
          return StringProvider();
        }),
        ChangeNotifierProvider(create: (context) {
          return CartProvider();
        }),
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return GetMaterialApp(
          getPages: [
            GetPage(
                name: CategoryScreen.routename, page: () => CategoryScreen()),
            GetPage(name: DetailPage.routename, page: () => DetailPage()),
            GetPage(name: FetchScreen.routename, page: () => FetchScreen()),
            GetPage(name: LoginPage.routename, page: () => LoginPage()),
            GetPage(name: Homepage.routename, page: () => Homepage()),
            GetPage(name: ProfileScreen.routename, page: () => ProfileScreen()),
            GetPage(
                name: RegisterScreens.routename, page: () => RegisterScreens())
          ],
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: styles.themeData(
              isdark: themeProvider.getDarkTheme, context: context),
          home: const FetchScreen(),
        );
      }),
    );
  }
}
