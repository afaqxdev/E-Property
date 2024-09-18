import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_property/Models/UserHomeModel.dart';
import 'package:e_property/Pages/HomePage.dart';
import 'package:e_property/Provider/Send_Post_Provider.dart';
import 'package:e_property/Screens/Post/PostScreen.dart';
import 'package:e_property/Screens/Profile/ProfileScreen.dart';
import 'package:e_property/constant.dart';
import 'package:e_property/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'component/SearchBar.dart';
import 'component/body.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? image;
  String? name;

  getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(user?.uid)
        .get();
    setState(() {
      image = userDoc.get('image');
      name = userDoc.get('name');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffC4C4C4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Image.asset(
              "assets/images/img1.png",
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 120,
                    child: Image.asset(
                      'assets/images/img6.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: getProportionateScreenHeight(40),
                    width: getProportionateScreenWidth(40),
                    decoration: const BoxDecoration(
                        color: Color(0xffeff1f4), shape: BoxShape.circle),
                    child: IconButton(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(bottom: 0),
                      onPressed: () {
                        showSearch(context: context, delegate: CitySearch());
                      },
                      icon: Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                        size: getProportionateScreenHeight(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostScreen(
                          name: name,
                          image: image,
                        )));
          },
          child: Icon(
            Icons.add,
            size: 35.sm,
          ),
        ),
      ),
      body: Body(),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        color: Color(0xff1082A6).withOpacity(0.4),
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(40),
            vertical: getProportionateScreenHeight(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.home,
              size: 45.sm,
              color: kPrimaryColor,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                              name: name,
                              image: image,
                            )));
              },
              child: CircleAvatar(
                radius: 20,
                child: ClipOval(
                    child: SizedBox(
                  height: 45,
                  width: 45,
                  child: Image.network(
                    image ??
                        'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                    fit: BoxFit.cover,
                  ),
                )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
