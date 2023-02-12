import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/firebase_auth.dart';
import '../service/globalmethod.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
//  String? user = FirebaseAuth.instance.currentUser!.uid;

  bool _isloaded = false;
  Future<void> googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();

    final googleAccount = await googleSignIn.signIn();

    setState(() {
      _isloaded = true;
    });

    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;

      print('Access token isss${googleAuth.accessToken}');
      print('Access token isss${googleAuth.idToken}');

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();

          sharedPreferences.setString(
              'accessToken', '${googleAuth.accessToken.toString()}');
          sharedPreferences.setString(
              'idToken', '${googleAuth.idToken.toString()}');

          await authinstance.signInWithCredential(GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken));

          print('Login Successfully');
          setState(() {
            _isloaded = false;
          });

          // Get.offAllNamed(BottomBar.routename, arguments: _isloaded);
        } on FirebaseAuthException catch (error) {
          print('An error occures $error');
          GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
          setState(() {
            _isloaded = false;
          });

          print('An error occures $error');
        } catch (error) {
          GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
          setState(() {
            _isloaded = false;
          });
          print('An error occures $error');
        } finally {
          setState(() {
            _isloaded = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SignInButton(
        elevation: 8,
        // padding: EdgeInsets.all(5),
        Buttons.GoogleDark, onPressed: () {
      googleSignIn(context);
    });
    // return Container(
    //   width: double.infinity,
    //   height: size.height * 0.07,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(12),
    //     //color: Colors.blue,
    //     gradient: LinearGradient(
    //         begin: Alignment.topLeft,
    //         end: Alignment.bottomRight,
    //         colors: [
    //           Color(0xff2886A6),
    //           Color(0xff2888A8),
    //           Color(0xff2B92B4),
    //           Color(0xff2C97BB),
    //           Color(0xff2D9BBF),
    //           Color(0xff2FA2C8),
    //           Color(0xff32AAD2),
    //           Color(0xff34B2DD),
    //           Color(0xff36BAE6),
    //           Color(0xff37BBE8),
    //         ]),
    //   ),
    //   child: InkWell(
    //     onTap: () {
    //       googleSignIn(context);
    //     },
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         Container(
    //           margin: EdgeInsets.all(0),
    //           // padding: EdgeInsets.symmetric(horizontal: 15),
    //           height: double.infinity,
    //           width: 45,
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(12),
    //                   bottomLeft: Radius.circular(12)),
    //               color: Colors.white,
    //               image: DecorationImage(
    //                   fit: BoxFit.contain,
    //                   image: AssetImage(
    //                     'asset/image/google.png',

    //                     // height: double.infinity,
    //                   ))),
    //         ),
    //         const SizedBox(
    //           width: 8,
    //         ),
    //         Textwidget(text: 'Sign in with Google', color: Colors.white, fs: 18)
    //       ],
    //     ),
    //   ),
    // );
  }
}
