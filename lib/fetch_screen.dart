import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shobjimama/providers/productprovider.dart';
import 'package:shobjimama/screen/auth/loginpage.dart';
import 'package:shobjimama/screen/btm_bar.dart';
import 'package:shobjimama/screen/homescreen.dart';
import 'package:shobjimama/screen/testpage.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});
  static const routename = '/FetchScreen';

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  //List<String> imagelist = Constss.imglist[0]['imagepath'];

  String? accessToken;
  String? idToken;
  String? email, password;
  isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
    accessToken = sharedPreferences.getString('accessToken').toString();
    idToken = sharedPreferences.getString('idToken').toString();
    email = sharedPreferences.getString('email').toString();
    password = sharedPreferences.getString('password').toString();

    print('email iss $email');
    print('password iss $password');
    print('accessToken iss $accessToken');
    print('idToken iss $idToken');

    if (accessToken!.isNotEmpty && idToken!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    //  imagelist.shuffle();
    // TODO: implement initState

    isLogin().whenComplete(() {
      Future.delayed(Duration(seconds: 3), (() {
        final provider = Provider.of<ProductProvider>(context, listen: false);
        provider.fetchData();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return email!.isEmpty && password!.isEmpty ? LoginPage() : TesPage();
        }));
      }));
    });

    // Future.delayed(
    //   Duration(microseconds: 4),
    //   () {
    //     final productprovider =
    //         Provider.of<ProductProvider>(context, listen: false);
    //     productprovider.fetchData();
    //     Navigator.of(context).pushReplacement(MaterialPageRoute(
    //       builder: (context) {
    //         return Homepage();
    //       },
    //     ));
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            './asset/image/landing/shop.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
