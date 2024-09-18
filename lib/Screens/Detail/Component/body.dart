import 'package:e_property/Models/UserHomeModel.dart';
import 'package:e_property/Provider/Send_Post_Provider.dart';
import 'package:e_property/Screens/Detail/Component/Detail.dart';
import 'package:e_property/Screens/Detail/Component/Gallery_Image.dart';

import 'package:e_property/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../Models/FirebasePostModel.dart';

class Body extends StatefulWidget {
  String? title;
  String? name;
  String? profileImage;
  int? price;
  int? phoneNumber;
  List<dynamic>? image;
  int? size;
  String? city;
  String? village;
  Body({
    Key? key,
    this.title,
    this.city,
    this.image,
    this.name,
    this.phoneNumber,
    this.price,
    this.profileImage,
    this.size,
    this.village,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                      child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.network(
                      widget.profileImage.toString(),
                      fit: BoxFit.cover,
                    ),
                  )),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                ),
                Text(
                  widget.name.toString(),
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
                height: getProportionateScreenHeight(200),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryImage(
                            image: widget.image,
                          ),
                        ));
                  },
                  child: ListView.builder(
                    itemCount: widget.image!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.image![index].toString(),
                            height: getProportionateScreenHeight(200),
                            width: SizeConfig.screenWidth! * 0.93,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      );
                    },
                  ),
                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.circular(8),
                  //   child: Image.network(
                  //     widget.image![0].toString(),
                  //     height: getProportionateScreenHeight(200),
                  //     width: SizeConfig.screenWidth! * 1,
                  //     fit: BoxFit.fill,
                  //   ),
                  // ),
                ),
              ),
              Positioned(
                bottom: getProportionateScreenHeight(10),
                right: getProportionateScreenWidth(25),
                child: Text(
                  currentIndex.toString() +
                      "/" +
                      widget.image!.length.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Positioned(
                  left: 25,
                  right: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      Icon(Icons.arrow_forward_ios_rounded,
                          color: Colors.white),
                    ],
                  )),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Detail(
            phoneNumber: widget.phoneNumber,
            city: widget.city,
            village: widget.village,
            size: widget.size,
            price: widget.price,
            title: widget.title,
          ),
        ],
      )),
    );
  }
}
