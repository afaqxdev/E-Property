import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_property/Screens/Detail/Detail_Screen.dart';
import 'package:e_property/Screens/Home/Home_Screen.dart';
import 'package:e_property/constant.dart';
import 'package:e_property/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Home/component/smallDetail.dart';

class UserPostData extends StatefulWidget {
  const UserPostData({Key? key}) : super(key: key);

  @override
  State<UserPostData> createState() => _UserPostDataState();
}

class _UserPostDataState extends State<UserPostData> {
  int currentIndex = 0;
  String? documentId;

  Future<void> deleteUser(id) {
    return FirebaseFirestore.instance
        .collection("Post")
        .doc(id)
        .delete()
        .then((value) => Fluttertoast.showToast(msg: " Your Post has Deleted "))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Post')
        .where('uid', isEqualTo: user?.uid)
        .snapshots();

    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
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
            documentId = document.id;
          }).toList();
          return Column(
            children: [
              for (int i = 0; i < postDetail.length; i++) ...[
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(10),
                            top: getProportionateScreenHeight(10),
                            bottom: getProportionateScreenHeight(10),
                            right: getProportionateScreenWidth(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25.r,
                                  child: ClipOval(
                                      child: SizedBox(
                                    height: getProportionateScreenHeight(50),
                                    width: getProportionateScreenWidth(50),
                                    child: Image.network(
                                      postDetail[i]['profileImage'],
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                                ),
                                SizedBox(
                                  width: getProportionateScreenHeight(10),
                                ),
                                Text(
                                  postDetail[i]['name'],
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                          "Are you sure to Delete ?"),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        kPrimaryColor),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Cancel")),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        kPrimaryColor),
                                                onPressed: () {
                                                  deleteUser(documentId);
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Yes")),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
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
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(10)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child:
                                      Image.network(postDetail[i]['image'][0])),
                            ),
                            Positioned(
                                right: getProportionateScreenWidth(15),
                                bottom: getProportionateScreenHeight(15),
                                child: Text(
                                    "${currentIndex + 1} / ${postDetail[i]['image'].length}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      SmallDetail(
                        city: postDetail[i]['city'].toString(),
                        price: postDetail[i]['price'].toString(),
                        size: postDetail[i]['size'].toString(),
                      ),
                      Text(
                        postDetail[i]['phoneNumber'].toString(),
                      ),
                    ],
                  ),
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
