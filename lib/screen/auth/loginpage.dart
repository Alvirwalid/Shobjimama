import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shobjimama/fetch_screen.dart';
import 'package:shobjimama/loadingmanger.dart';
import '../../const/firebase_auth.dart';
import '../../service/globalmethod.dart';
import '../../widgets/authbutton.dart';
import '../../widgets/googlebutton.dart';
import '../../widgets/textwidhet.dart';

import 'registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routename = '/LoginScreens';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCController = TextEditingController();
  final _passwordCController = TextEditingController();
  final _passfocus = FocusNode();
  var _obscureText = true;
  Color color = Colors.grey.withOpacity(0.7);

  final _formkey = GlobalKey<FormState>();

  bool _isloaded = false;

  void submitFormOnLogin() async {
    final isVallid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isVallid) {
      _formkey.currentState!.save();

      setState(() {
        _isloaded = true;
      });

      try {
        authinstance
            .signInWithEmailAndPassword(
                email: _emailCController.text.toLowerCase().trim(),
                password: _passwordCController.text)
            .then((value) async {
          SharedPreferences shrpre = await SharedPreferences.getInstance();

          setState(() {
            shrpre.setString('email', _emailCController.text.toString());
            shrpre.setString('password', _passwordCController.text.toString());
          });
          Get.offAllNamed(FetchScreen.routename);
        }).onError((error, stackTrace) {
          GlobalMethod.errorDialog(
              ctx: context, subtitle: '${error.toString()}');
        });

        setState(() {
          _isloaded = false;
        });

        print('Login Succesfully');
      } on FirebaseAuthException catch (error) {
        print('An error occured $error');
        GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
        setState(() {
          _isloaded = false;
        });
      } catch (error) {
        print('An error occured $error');
        GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
        setState(() {
          _isloaded = false;
        });
      }

      print('The form is valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Loadingmanager(
          isLoading: _isloaded,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Textwidget(
                      text: 'Welcome', color: Colors.black, textsize: 24),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Image.asset(
                    './asset/image/computer-security-with-login-password-padlock.jpg',
                    width: double.infinity,
                    height: size.height * 0.3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailCController,
                            textInputAction: TextInputAction.next,
                            // onEditingComplete: () =>
                            //     FocusScope.of(context).requestFocus(_passfocus),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Enter a valid email address';
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  IconlyBold.message,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                contentPadding: EdgeInsets.all(20),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.1),
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.black),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordCController,
                            textInputAction: TextInputAction.done,
                            // onEditingComplete: () => submitFormOnLogin(),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Enter a valid  password';
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                IconlyBold.lock,
                                color: Colors.black,
                                size: 30,
                              ),
                              contentPadding: EdgeInsets.all(17),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              suffix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: _obscureText
                                      ? const Icon(
                                          Icons.visibility,
                                          color: Colors.black,
                                          // size: 22,
                                        )
                                      : const Icon(Icons.visibility_off,
                                          color: Colors.black)),
                              hintText: 'Password',
                              hintStyle: const TextStyle(color: Colors.black),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                            obscureText: _obscureText,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: AuthButton(
                          btntext: 'Login',
                          fct: () {
                            submitFormOnLogin();
                          })),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const GoogleButton(),
                  SizedBox(
                    height: size.height * 0.027,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            children: [
                          TextSpan(
                              text: '   Sign up',
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = (() {
                                  Get.toNamed(RegisterScreens.routename);
                                }))
                        ])),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
