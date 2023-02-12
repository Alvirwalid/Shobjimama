import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shobjimama/loadingmanger.dart';
import '../const/firebase_auth.dart';
import '../service/globalmethod.dart';
import '../widgets/textwidhet.dart';
import 'auth/loginpage.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});
  static const routename = '/ProfileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? email, name, location;
  String? id;
  bool _isLoading = false;
  final User? user = authinstance.currentUser;

  Future<void> getUserdata() async {
    var uid = user!.uid;

    setState(() {
      _isLoading = true;
    });

    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    } else {
      try {
        setState(() {
          _isLoading = true;
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get()
            .then((DocumentSnapshot doc) {
          setState(() {
            name = doc['name'];
            email = doc['email'];
            id = doc['id'];
            location = doc['address'];
          });
        });

        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print(e.toString());
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  _clearData() async {}

  @override
  void initState() {
    // TODO: implement initState
    getUserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Loadingmanager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                CircleAvatar(
                  backgroundColor: Color(0xffDCEDFF),
                  radius: 80,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Textwidget(
                    text: "${name == null ? 'Name' : '$name'}".toUpperCase(),
                    color: Colors.black,
                    textsize: 20),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      _listtile(
                          icon: Icons.email,
                          title: email == null ? 'Email' : '$email',
                          onpressed: () {}),
                      _listtile(
                          icon: IconlyBold.location,
                          title: location == null ? 'address' : '$location',
                          onpressed: () {}),
                      _listtile(
                          icon: user == null
                              ? IconlyLight.login
                              : IconlyLight.logout,
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
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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
          color: Colors.black,
          size: 26,
        ),
      ),
      title: Textwidget(text: title, color: Colors.black, textsize: 16),
      onTap: () {
        onpressed();
      },
    );
  }
}
