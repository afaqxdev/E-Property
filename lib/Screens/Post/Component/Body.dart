import 'dart:io';

import 'package:e_property/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  List<XFile>? images = [];
  List<String>? downloadUrl = [];
  TextEditingController price;
  TextEditingController phoneNumber;
  TextEditingController size;
  TextEditingController city;
  TextEditingController village;
  TextEditingController title;
  String? profileImage;
  String? name;
  Body(
      {Key? key,
      this.downloadUrl,
      this.images,
      this.name,
      this.profileImage,
      required this.city,
      required this.phoneNumber,
      required this.title,
      required this.price,
      required this.size,
      required this.village})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // select Images from Gallery
  Future<void> selectImage() async {
    if (widget.images != null) {
      widget.images!.clear();
    }
    try {
      final List<XFile>? imgs = await ImagePicker().pickMultiImage();
      if (imgs!.isNotEmpty) {
        widget.images!.addAll(imgs);
      }
    } catch (e) {
      print('something wrong');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                child: ClipOval(
                    child: SizedBox(
                        height: getProportionateScreenHeight(60),
                        width: getProportionateScreenWidth(60),
                        child: widget.profileImage == null
                            ? Image.asset(
                                "assets/images/img5.png",
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                widget.profileImage.toString(),
                                fit: BoxFit.cover,
                              ))),
              ),
              const SizedBox(
                width: 10,
              ),
              widget.name == null
                  ? Text(
                      "no data",
                      style: TextStyle(
                          fontSize: 18.sm,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor),
                    )
                  : Text(
                      widget.name.toString(),
                      style: TextStyle(
                          fontSize: 18.sm,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor),
                    )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          textInputAction: TextInputAction.done,
          controller: widget.title,
          minLines: 3,
          maxLines: 3,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(20),
            hintText: "What do you want to write here",
            filled: true,
            fillColor: Color(0xffD9D9D9).withOpacity(0.5),
          ),
          onSaved: (value) {
            widget.title.text = value.toString();
          },
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Container(
            height: getProportionateScreenHeight(200),
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.images!.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.only(
                          left: getProportionateScreenWidth(10)),
                      height: 200,
                      width: SizeConfig.screenWidth! * 0.9,
                      child: Image.file(
                        File(widget.images![index].path),
                        fit: BoxFit.cover,
                      ));
                })),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Add Price",
                style: TextStyle(color: kPrimaryColor),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
              ),
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: widget.price,
                  decoration: InputDecoration(
                    hintText: "50000",
                    hintStyle: TextStyle(color: Colors.black45),
                    contentPadding: EdgeInsets.only(left: 20),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(10))),
                    filled: true,
                    fillColor: Color(0xffD9D9D9).withOpacity(0.5),
                    // errorText: isValidate ? "Please Enter price" : null,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter price";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.price.text = value.toString();
                  },
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Add Phone",
                style: TextStyle(color: kPrimaryColor),
              ),
              SizedBox(
                width: getProportionateScreenWidth(30),
              ),
              Expanded(
                  child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: widget.phoneNumber,
                decoration: InputDecoration(
                  hintText: "Phone",
                  hintStyle: TextStyle(color: Colors.black45),
                  contentPadding: EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(10))),
                  filled: true,
                  fillColor: Color(0xffD9D9D9).withOpacity(0.5),
                  // errorText:
                  //     isValidate ? "Please Enter Phone number" : null,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter phone";
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.phoneNumber.text = value.toString();
                },
              ))
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Add Size",
                style: TextStyle(color: kPrimaryColor),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
              ),
              Expanded(
                  child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: widget.size,
                decoration: InputDecoration(
                  hintText: "Size",
                  hintStyle: TextStyle(color: Colors.black45),
                  contentPadding: EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(10))),
                  filled: true,
                  fillColor: Color(0xffD9D9D9).withOpacity(0.5),
                  // errorText: isValidate ? "Please Enter size" : null,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Size";
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.size.text = value.toString();
                },
              ))
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Add Location",
                style: TextStyle(color: kPrimaryColor),
              ),
              SizedBox(
                width: getProportionateScreenWidth(10),
              ),
              Expanded(
                  child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: widget.city,
                decoration: InputDecoration(
                  hintText: "Add City",
                  hintStyle: TextStyle(color: Colors.black45),
                  contentPadding: EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(10))),
                  filled: true,
                  fillColor: Color(0xffD9D9D9).withOpacity(0.5),
                  // errorText:
                  //     isValidate ? "Please Enter city name" : null,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter City";
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.city.text = value.toString();
                },
              )),
              SizedBox(
                width: getProportionateScreenWidth(5),
              ),
              Expanded(
                  child: TextFormField(
                textInputAction: TextInputAction.done,
                controller: widget.village,
                decoration: InputDecoration(
                  hintText: "Add Village",
                  hintStyle: TextStyle(color: Colors.black45),
                  contentPadding: EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(10))),
                  filled: true,
                  fillColor: Color(0xffD9D9D9).withOpacity(0.5),
                  // errorText:
                  //     isValidate ? "Please Enter village name" : null,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter village";
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.village.text = value.toString();
                },
              ))
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            children: [
              const Text(
                "Add Photos",
                style: TextStyle(color: kPrimaryColor),
              ),
              SizedBox(
                width: getProportionateScreenHeight(20),
              ),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  selectImage();
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffD9D9D9).withOpacity(0.5),
                    ),
                    child: Image.asset(
                      "assets/images/camera 2.png",
                      height: 40,
                      width: 40,
                    )),
              )),
              SizedBox(
                width: getProportionateScreenWidth(5),
              ),
              Expanded(
                  child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffD9D9D9).withOpacity(0.5),
                        ),
                        child: Image.asset(
                          "assets/images/image 1.png",
                          height: 40,
                          width: 40,
                        ),
                      )))
            ],
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
