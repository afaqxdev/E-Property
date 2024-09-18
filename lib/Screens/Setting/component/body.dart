import 'package:e_property/Component/buildButten.dart';
import 'package:e_property/Screens/Reset/Reset_Screen.dart';
import 'package:e_property/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.screenHeight! * 0.1,
        ),
        const Divider(
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ResetScreen()));
          },
          child: Padding(
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
                top: getProportionateScreenHeight(10),
                bottom: getProportionateScreenHeight(10)),
            child: Row(
              children: [
                const Icon(
                  Icons.lock_open_outlined,
                  color: kPrimaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Reset",
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}
