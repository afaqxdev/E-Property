import 'package:e_property/constant.dart';
import 'package:e_property/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Component/body.dart';

class DetailScreen extends StatefulWidget {
  String? title;
  String? name;
  String? profileImage;
  int? price;
  int? phoneNumber;
  List<dynamic>? image;
  int? size;
  String? city;
  String? village;
  DetailScreen(
      {Key? key,
      this.city,
      this.image,
      this.name,
      this.phoneNumber,
      this.price,
      this.profileImage,
      this.size,
      this.title,
      this.village})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        toolbarHeight: getProportionateScreenHeight(90),
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/img1.png",
              fit: BoxFit.fill,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                ),
                Text(
                  "Go Back",
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
          ],
        ),
      ),
      body: Body(
        name: widget.name,
        city: widget.city,
        title: widget.title,
        image: widget.image,
        price: widget.price,
        phoneNumber: widget.phoneNumber,
        profileImage: widget.profileImage,
        size: widget.size,
        village: widget.village,
      ),
    );
  }
}
