import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_property/Users/Comments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Models/UserHomeModel.dart';

class UserHomeBody extends StatefulWidget {
  UserHomeBody({
    Key? key,
  }) : super(key: key);

  @override
  _UserHomeBodyState createState() => _UserHomeBodyState();
}

class _UserHomeBodyState extends State<UserHomeBody> {
  // String? image;
  // String? name;
  // getData() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   final DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(user?.uid)
  //       .get();
  //   setState(() {
  //     image = userDoc.get('image');
  //     name = userDoc.get('name');
  //   });
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getData();
  // }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('Post').snapshots();

    return Scaffold(
      backgroundColor: const Color(0xffcbccd1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        toolbarHeight: 100,
        title: Column(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset("assets/images/img1.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
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
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        color: Color(0xffeff1f4), shape: BoxShape.circle),
                    child: IconButton(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 1),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            final List postDetail = [];
            snapshot.data!.docs.map((DocumentSnapshot document) {
              Map data = document.data() as Map<String, dynamic>;
              postDetail.add(data);
            }).toList();
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  for (var i = 0; i < postDetail.length; i++) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            child: ClipOval(
                              child: SizedBox(
                                height: 55,
                                width: 55,
                                child: Image.network(
                                  postDetail[i]['profileImage'].toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  postDetail[i]['name'].toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  spacing: 10.0,
                                  children: const [
                                    Text(
                                      "Just Now",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(Icons.public),
                                  ],
                                )
                              ],
                            ),
                          ),
                          IconButton(
                              iconSize: 30,
                              onPressed: () {},
                              icon: const Icon(Icons.more_horiz_outlined))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              postDetail[i]['title'],
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                          ),
                          postDetail[i]['image'] == 0
                              ? Container(
                                  child: Image.network(
                                    postDetail[i]['image'].toString(),
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                )
                              : GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: postDetail[i]['image'].length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                          crossAxisCount: 3),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Image.network(
                                      postDetail[i]['image'][index].toString(),
                                      fit: BoxFit.cover,
                                    );
                                  }),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.thumb_up_alt_outlined),
                            ),
                            const Text(
                              "12",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                scrollBottomAgain();
                              },
                              icon: const Icon(Icons.message_outlined),
                            ),
                            const Text(
                              "20",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const FaIcon(
                                FontAwesomeIcons.facebookMessenger,
                                size: 25,
                                color: Colors.black45,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: double.infinity,
                      color: const Color(0xffcbccd1),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void scrollBottomAgain() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return CommentSection();
        });
  }
}
