import 'package:flutter/material.dart';

class Post {
  String? title;
  String? name;
  String? profileImage;
  String? uid;
  int? price;
  int? phoneNumber;
  List<dynamic>? image;
  int? size;
  String? city;
  String? village;

  Post(
      {this.village,
      this.uid,
      this.phoneNumber,
      this.size,
      this.city,
      this.price,
      this.image,
      this.title,
      this.name,
      this.profileImage});

  //Receive data from firebase
  factory Post.fromMap(map) {
    return Post(
      city: map['city'],
      village: map['village'],
      uid: map['uid'],
      title: map['title'],
      image: map['image'],
      size: map['size'],
      phoneNumber: map['phoneNumber'],
      name: map['name'],
      price: map['price'],
      profileImage: map['profileImage'],
    );
  }

  // send data to firebase

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'city': city,
      'village': village,
      'title': title,
      'image': image,
      'size': size,
      'name': name,
      '5000': price,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
    };
  }
}
