import 'package:e_property/Screens/Login/loginScreen.dart';
import 'package:e_property/Screens/Reset/Reset_Screen.dart';
import 'package:e_property/constant.dart';
import 'package:e_property/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'Component/body.dart';

class ProfileScreen extends StatefulWidget {
  String? name;
  String? image;
  ProfileScreen({Key? key, this.image, this.name}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isWaiting = false;
  final storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextFieldColor,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(50),
              ),
              Padding(
                padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
                child: Text(
                  "Setting",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 22.sp),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(50),
              ),
              const Divider(
                color: Colors.black,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ResetScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Change Password",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              const Divider(
                color: Colors.black,
              ),
              GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  await storage.delete(key: 'uid');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout,
                        color: kPrimaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
          backgroundColor: kPrimaryColor,

          // backgroundColor: Colors.white,
          // toolbarHeight: getProportionateScreenHeight(119),
          // automaticallyImplyLeading: false,
          title: Text("Setting")
          //  Column(
          //   children: [
          //     Image.asset("assets/images/img1.png"),
          //     SizedBox(
          //       height: getProportionateScreenHeight(20),
          //     ),
          //     Row(
          //       children: [
          //         GestureDetector(
          //           onTap: () {
          //             Navigator.pop(context);
          //           },
          //           child: const Icon(
          //             Icons.close,
          //             color: Colors.black,
          //           ),
          //         ),
          //         SizedBox(
          //           width: getProportionateScreenWidth(10),
          //         ),
          //         Text(
          //           "Profile Update",
          //           style: TextStyle(
          //               fontSize: 16.sp,
          //               color: Colors.black,
          //               fontWeight: FontWeight.w600),
          //         )
          //       ],
          //     ),
          //     SizedBox(
          //       height: getProportionateScreenHeight(20),
          //     ),
          //   ],
          // ),

          ),
      body: Body(
        name: widget.name,
        image: widget.image,
      ),
    );
  }
}
