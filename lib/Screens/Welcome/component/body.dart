import 'package:e_property/Screens/login/loginScreen.dart';
import 'package:e_property/size_config.dart';
import 'package:flutter/material.dart';

import '../../../Component/buildButten.dart';
import '../../../Pages/LoginPage.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 3,
          ),
          Image.asset(
            "assets/images/img2.png",
            height: getProportionateScreenHeight(220),
            width: getProportionateScreenWidth(220),
          ),
          const Spacer(
            flex: 2,
          ),
          BuildButten(
            text: "Get Started",
            onpressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
