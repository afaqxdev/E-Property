import 'package:flutter/material.dart';

class PostModel {
  final VoidCallback avatarOnPressed;
  final String avatarImage;
  final String name;
  final String time;
  final VoidCallback moreOnPressed;
  final String postTitle;
  final String postImage;

  PostModel({
    required this.avatarOnPressed,
    required this.avatarImage,
    required this.name,
    required this.time,
    required this.moreOnPressed,
    required this.postTitle,
    required this.postImage,
  });
}

final List<PostModel> postData = [
  PostModel(
    avatarOnPressed: () => print("Avatar Click"),
    avatarImage: 'assets/images/img4.png',
    name: 'Haleema',
    time: 'Just Now',
    moreOnPressed: () => print("More Click"),
    postTitle: "This is my new profile picture ",
    postImage: 'assets/images/img11.png',
  ),
  PostModel(
    avatarOnPressed: () => print("Avatar Click"),
    avatarImage: 'assets/images/img4.png',
    name: 'Haleema Shah',
    time: 'Just Now',
    moreOnPressed: () => print("More Click"),
    postTitle: "This is my new profile picture ",
    postImage: 'assets/images/img9.png',
  ),
  PostModel(
    avatarOnPressed: () => print("Avatar Click"),
    avatarImage: 'assets/images/img4.png',
    name: 'Haleema Shah',
    time: 'Just Now',
    moreOnPressed: () => print("More Click"),
    postTitle: "This is my new profile picture ",
    postImage: 'assets/images/img10.png',
  ),
  PostModel(
    avatarOnPressed: () => print("Avatar Click"),
    avatarImage: 'assets/images/img4.png',
    name: 'Haleema Shah',
    time: 'Just Now',
    moreOnPressed: () => print("More Click"),
    postTitle: "This is my new profile picture ",
    postImage: 'assets/images/img8.png',
  ),
  PostModel(
    avatarOnPressed: () => print("Avatar Click"),
    avatarImage: 'assets/images/img4.png',
    name: 'Haleema Shah',
    time: 'Just Now',
    moreOnPressed: () => print("More Click"),
    postTitle: "This is my new profile picture ",
    postImage: 'assets/images/img7.png',
  ),
];
