import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_property/Models/FirebaseUserModel.dart';
import 'package:e_property/Models/UserHomeModel.dart';
import 'package:e_property/Provider/Send_Post_Provider.dart';
import 'package:e_property/Screens/Detail/Detail_Screen.dart';
import 'package:e_property/Screens/Home/component/smallDetail.dart';
import 'package:e_property/constant.dart';
import 'package:e_property/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../Models/FirebasePostModel.dart';

class Body extends StatefulWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Post')
        .orderBy('price', descending: false)
        .snapshots();

    return SingleChildScrollView(
        child: Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final List postDetail = [];
            snapshot.data!.docs.map((DocumentSnapshot document) {
              Map data = document.data() as Map<String, dynamic>;
              postDetail.add(data);
            }).toList();
            return ListView.builder(
                itemCount: postDetail.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        name: postDetail[i]['name'],
                                        image: postDetail[i]['image'],
                                        phoneNumber: postDetail[i]
                                            ['phoneNumber'],
                                        price: postDetail[i]['price'],
                                        profileImage: postDetail[i]
                                            ['profileImage'],
                                        city: postDetail[i]['city'],
                                        village: postDetail[i]['village'],
                                        size: postDetail[i]['size'],
                                        title: postDetail[i]['title'],
                                      )));
                        },
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: getProportionateScreenWidth(10),
                                    top: getProportionateScreenHeight(10),
                                    bottom: getProportionateScreenHeight(10)),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25.r,
                                      child: ClipOval(
                                          child: SizedBox(
                                        height: 50.h,
                                        width: 50.h,
                                        child: Image.network(
                                          postDetail[i]['profileImage']
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(10),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          postDetail[i]['name'].toString(),
                                          style: TextStyle(
                                              fontSize: 18.sm,
                                              fontWeight: FontWeight.w700,
                                              color: kPrimaryColor),
                                        ),
                                        Text(
                                          "Just Now",
                                          style: TextStyle(
                                              fontSize: 14.sm,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            getProportionateScreenWidth(10)),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Image.network(postDetail[i]
                                                ['image'][0]
                                            .toString())),
                                  ),
                                  Positioned(
                                      right: getProportionateScreenWidth(15),
                                      bottom: getProportionateScreenHeight(15),
                                      child: Text(
                                          '${currentIndex + 1} /${postDetail[i]['image'].length}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)))
                                ],
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                              SmallDetail(
                                price: postDetail[i]['price'].toString(),
                                size: postDetail[i]['size'].toString(),
                                city: postDetail[i]['city'].toString(),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                });
          },
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
      ],
    ));
  }
}
