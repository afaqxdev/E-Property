import 'package:flutter/material.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  int? number;
  String? city;
  String? image;

  UserModel(
      {this.email, this.name, this.uid, this.city, this.number, this.image});

// receive data from server

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      city: map['city'],
      number: map['number'],
      image: map['image'],
    );
  }

  // send data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'city': city,
      'number': number,
      'image': image,
    };
  }
}
