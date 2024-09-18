import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../size_config.dart';

class Detail extends StatefulWidget {
  int? size;
  String? city;
  String? village;
  int? price;
  int? phoneNumber;
  String? title;
  Detail({
    Key? key,
    this.city,
    this.phoneNumber,
    this.price,
    this.size,
    this.title,
    this.village,
  }) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Detail",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(10),
                  ),
                  const Expanded(
                    child: Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.price.toString(),
                    style: TextStyle(fontSize: 16.sp),
                  )
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              const Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Location",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ('${widget.city} // ${widget.village}'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16.sp),
                  )
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              const Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Size",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ("${widget.size} Marla"),
                    style: TextStyle(fontSize: 16.sp),
                  )
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              const Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phone",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ("${widget.phoneNumber}"),
                    style: TextStyle(fontSize: 16.sp),
                  )
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              const Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        openWhatsApp();
                      },
                      child: Image.asset(
                        "assets/images/whatsApp.png",
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Description",
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(("${widget.title}"))
            ],
          ),
        ),
      ],
    );
  }

  void openWhatsApp() async {
    var phoneNumber = widget.phoneNumber;
    final Uri _url =
        Uri.parse('whatsapp://send?phone=' + phoneNumber.toString());
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }
}
