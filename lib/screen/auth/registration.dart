import 'dart:io' as io;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shobjimama/loadingmanger.dart';
import '../../const/const.dart';
import '../../const/firebase_auth.dart';

import '../../fetch_screen.dart';
import '../../service/globalmethod.dart';
import '../../widgets/authbutton.dart';

import '../../widgets/textwidhet.dart';

import 'loginpage.dart';

class RegisterScreens extends StatefulWidget {
  const RegisterScreens({super.key});

  static const routename = '/RegisterScreens';

  @override
  State<RegisterScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<RegisterScreens> {
  final _fullnametextCController = TextEditingController();
  final _messnametextCController = TextEditingController();
  final _phonenumbertextCController = TextEditingController();
  final _emailCController = TextEditingController();
  final _passwordCController = TextEditingController();
  final _addressTextCController = TextEditingController();
  final _passfocus = FocusNode();
  final _emailfocus = FocusNode();
  final _addressfocus = FocusNode();
  var _obscureText = true;

  final _formkey = GlobalKey<FormState>();

  bool _isLoaded = false;

  // File? image, shopImage;
  // final _picker = ImagePicker();

  void submitFormOnregistration() async {
    final isVallid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isVallid) {
      _formkey.currentState!.save();

      setState(() {
        _isLoaded = true;
      });

      try {
        await authinstance
            .createUserWithEmailAndPassword(
                email: _emailCController.text.toLowerCase().trim(),
                password: _passwordCController.text.trim())
            .then((value) async {
          final User? user = authinstance.currentUser;
          final _uid = user!.uid;

          await FirebaseFirestore.instance.collection('users').doc(_uid).set({
            'id': _uid,
            'name': _fullnametextCController.text,
            'phone': _phonenumbertextCController.text,
            'email': _emailCController.text.toLowerCase(),
            'address': _addressTextCController.text,
            'createdAt': Timestamp.now()
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) {
              return LoginPage();
            },
          ));
        }).onError((error, stackTrace) {
          GlobalMethod.errorDialog(
              ctx: context, subtitle: '${error.toString()}');
        });

        Get.snackbar(
          "",
          "Registration Succesfully",
          snackPosition: SnackPosition.BOTTOM,
        );

        print('Registration Succesfully');
        setState(() {
          _isLoaded = false;
        });
      } on FirebaseAuthException catch (error) {
        print('An error ccured $error');
        GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
        setState(() {
          _isLoaded = false;
        });
      } catch (error) {
        print('An error ccured $error');
        GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
        setState(() {
          _isLoaded = false;
        });
      }
    }
  }

  // Future getShopImage() async {
  //   final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedImage != null) {
  //       print('Image found');
  //       shopImage = File(pickedImage.path);
  //       setState(() {});

  //       print('$image');
  //     } else {
  //       print('image not found');
  //     }
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullnametextCController.dispose();
    _emailCController.dispose();
    _passwordCController.dispose();
    _addressTextCController.dispose();
    _emailfocus.dispose();
    _passfocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Loadingmanager(
        isLoading: _isLoaded,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: size.height * 0.2,
                ),
                Textwidget(
                    text: 'Welcome Back', color: Colors.black, textsize: 24),
                const SizedBox(
                  height: 8,
                ),
                Textwidget(
                    text: 'Sign in to continue',
                    color: Colors.black,
                    textsize: 16),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        // shopImage != null
                        //     ? Container(
                        //         width: 250,
                        //         height: 140,
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(5),
                        //             color: Colors.transparent,
                        //             image: DecorationImage(
                        //                 fit: BoxFit.cover,
                        //                 image: FileImage(shopImage!))),
                        //       )
                        //     : InkWell(
                        //         onTap: () {
                        //           getShopImage();
                        //         },
                        //         child: Container(
                        //           padding: EdgeInsets.all(20),
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(12),
                        //             color: Colors.transparent,
                        //           ),
                        //           child: const Icon(
                        //             Icons.image,
                        //             size: 60,
                        //             color: Colors.white,
                        //           ),
                        //         ),
                        //       ),

                        SizedBox(
                          height: 10,
                        ),

                        TextFormField(
                          controller: _fullnametextCController,
                          textInputAction: TextInputAction.next,
                          //onEditingComplete: () => submitFormOnregistration(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Full Name';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            label: Text('Name'),
                            hintText: 'name',
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _messnametextCController,
                          textInputAction: TextInputAction.next,
                          //onEditingComplete: () => submitFormOnregistration(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Full Name';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            label: Text('Mess name'),
                            hintText: 'mess',
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _phonenumbertextCController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          //onEditingComplete: () => submitFormOnregistration(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Phone number';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            label: Text('Phone'),
                            hintText: '+880 xxxxxxxxxx',
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _emailCController,
                          textInputAction: TextInputAction.next,
                          // onEditingComplete: () => submitFormOnregistration(),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Enter a valid email address';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            label: Text('Email'),
                            hintText: '@gmail.com',
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        ///pass
                        TextFormField(
                          controller: _passwordCController,
                          textInputAction: TextInputAction.next,
                          // onEditingComplete: () => submitFormOnregistration(),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'enter more than 7';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
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
                                      )
                                    : const Icon(Icons.visibility_off,
                                        color: Colors.black)),
                            label: Text('Password'),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                          obscureText: _obscureText,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _addressTextCController,
                          textInputAction: TextInputAction.done,
                          // onEditingComplete: () => submitFormOnregistration(),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return 'Enter a valid  address';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            label: Text('address'),
                            hintText: 'house no,street,city,state',
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // TextFormField(
                        //   controller: _addressTextCController,
                        //   textInputAction: TextInputAction.done,
                        //   // onEditingComplete: () => submitFormOnregistration(),
                        //   validator: (value) {
                        //     if (value!.isEmpty || value.length < 10) {
                        //       return 'Enter a valid  address';
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        //   style: const TextStyle(color: Colors.white),
                        //   decoration: const InputDecoration(
                        //     hintText: 'Shop address',
                        //     hintStyle: TextStyle(color: Colors.white),
                        //     enabledBorder: UnderlineInputBorder(
                        //         borderSide: BorderSide(color: Colors.white)),
                        //     focusedBorder: UnderlineInputBorder(
                        //         borderSide: BorderSide(color: Colors.white)),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Align(
                        //   alignment: Alignment.topRight,
                        //   child: TextButton(
                        //       onPressed: () {},
                        //       child: const Text(
                        //         'Forget password',
                        //         style: TextStyle(
                        //             fontStyle: FontStyle.italic,
                        //             color: Colors.lightBlue,
                        //             fontSize: 15,
                        //             decoration: TextDecoration.underline),
                        //       )),
                        // )
                      ],
                    )),
                SizedBox(
                  height: size.height * 0.025,
                ),
                SizedBox(
                  width: double.infinity,
                  child: AuthButton(
                    btntext: 'Sign Up',
                    fct: () {
                      submitFormOnregistration();
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                    text: TextSpan(
                        text: 'Already a user?',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        children: [
                      TextSpan(
                          text: '   Sign in',
                          style: const TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()
                            ..onTap = (() {
                              Get.toNamed(LoginPage.routename);
                            }))
                    ])),
                SizedBox(
                  height: size.height * 0.015,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
