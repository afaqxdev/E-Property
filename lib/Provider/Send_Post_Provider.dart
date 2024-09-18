import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_property/Screens/Home/Home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/FirebasePostModel.dart';

class SendPostProvider extends ChangeNotifier {
// current user
  User? user = FirebaseAuth.instance.currentUser;

// set image to Claud firebase
  Future<String> uploadFile(XFile _img) async {
    final postID = DateTime.now().microsecondsSinceEpoch.toString();

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('${user?.uid}')
        .child('Post Images/$postID');
    await ref.putFile(File(_img.path));
    return await ref.getDownloadURL();
  }

// Upload complete data to firebase
  bool isLoading = false;
  bool get loading => isLoading;
  Future uploadFunction(
    List<XFile>? _image,
    List<String> downloadUrl,
    BuildContext context,
    String? title,
    String? name,
    String? profileImage,
    String? uid,
    int? price,
    int? phoneNumber,
    List<String>? image,
    int? size,
    String? city,
    String? village,
  ) async {
    isLoading = true;
    for (int i = 0; i < _image!.length; i++) {
      var imgUrl = await uploadFile(_image[i]);
      downloadUrl.add(imgUrl.toString());
    }

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // calling userModel
    Post post = Post();

    post.uid = uid;
    post.city = city;
    post.image = image;
    post.phoneNumber = phoneNumber;
    post.size = size;
    post.village = village;
    post.price = price;
    post.profileImage = profileImage;
    post.name = name;
    post.title = title;

    await firebaseFirestore.collection('Post').doc().set(post.toMap());
    final List postDetail = [];

    isLoading = false;
    Fluttertoast.showToast(msg: "Data Upload Successfully");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => HomeScreen(),
      ),
      (route) => false,
    );

    notifyListeners();
  }

  // get Post Data

  List<Post> _postData = [];

  List<Post> get postData => _postData;

  Future<void> getPostData() async {
    List<Post> getPostData = [];
    // calling firebase
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection("Post").get();

    if (data.docs.isEmpty) {
      return;
    }
    data.docs.forEach((element) {
      Post post = Post(
          name: element.get('name'),
          city: element.get('city'),
          profileImage: element.get('profileImage'),
          village: element.get("village"),
          size: element.get("size"),
          phoneNumber: element.get('phoneNumber'),
          title: element.get('title'),
          price: element.get('price'),
          image: element.get('image'));

      getPostData.add(post);
    });

    _postData = getPostData;
    notifyListeners();
  }
}

// if (snapshot.hasError) {
//               return const Center(child: Text('Something went wrong'));
//             }

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             final List postDetail = [];
//             snapshot.data!.docs.map((DocumentSnapshot document) {
//               Map data = document.data() as Map<String, dynamic>;
//               postDetail.add(data);
//             }).toList();