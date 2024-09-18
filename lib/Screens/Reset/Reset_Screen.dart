import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../size_config.dart';
import 'component/body.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        toolbarHeight: getProportionateScreenHeight(120),
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Image.asset("assets/images/img1.png"),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                ),
                Text(
                  "Reset",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
          ],
        ),
      ),
      body: Body(),
    );
  }
}
