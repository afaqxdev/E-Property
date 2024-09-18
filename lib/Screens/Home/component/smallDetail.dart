import 'package:e_property/constant.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../size_config.dart';

class SmallDetail extends StatefulWidget {
  String? price;
  String? size;
  String? city;
  SmallDetail({Key? key, this.city, this.price, this.size}) : super(key: key);

  @override
  State<SmallDetail> createState() => _SmallDetailState();
}

class _SmallDetailState extends State<SmallDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(
                10,
              ),
              vertical: getProportionateScreenHeight(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: getProportionateScreenHeight(40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: kTextFieldColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(5)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: kPrimaryColor,
                                size: 20.sp,
                              ),
                              const VerticalDivider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          Expanded(
                              child: Text(
                            widget.price.toString(),
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w700),
                          ))
                        ]),
                  ),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(10),
              ),
              Expanded(
                child: Container(
                  height: getProportionateScreenHeight(40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: kTextFieldColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(5)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.home_outlined,
                                color: kPrimaryColor,
                              ),
                              VerticalDivider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          Expanded(
                              child: Text(
                            "${widget.size} Marla",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w700),
                          ))
                        ]),
                  ),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(10),
              ),
              Expanded(
                child: Container(
                  height: getProportionateScreenHeight(40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: kTextFieldColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(5)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.location_on_outlined,
                                color: kPrimaryColor,
                              ),
                              VerticalDivider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          Expanded(
                              child: Text(
                            widget.city.toString(),
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w700),
                          ))
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
      ],
    );
  }
}
