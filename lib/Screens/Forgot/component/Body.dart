import 'package:e_property/Component/buildButten.dart';
import 'package:e_property/Screens/login/loginScreen.dart';
import 'package:e_property/constant.dart';
import 'package:e_property/size_config.dart';
import 'package:flutter/material.dart';

import 'ForgotPassword_form.dart';
import 'ForgotPassword_form.dart';
import 'ForgotPassword_form.dart';
import 'ForgotPassword_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Image.asset(
                "assets/images/img2.png",
                height: getProportionateScreenHeight(150),
                width: getProportionateScreenWidth(150),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.06,
              ),
              const Text(
                "Forgot password",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              const Text("Enter your email to receive  the mail"),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              ForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
