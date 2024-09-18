import 'package:e_property/Component/buildButten.dart';
import 'package:e_property/Provider/Auth_Provider.dart';
import 'package:e_property/Screens/Home/Home_Screen.dart';
import 'package:e_property/Screens/Login/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../size_config.dart';

class ResetFormField extends StatefulWidget {
  const ResetFormField({Key? key}) : super(key: key);

  @override
  State<ResetFormField> createState() => _ResetFormFieldState();
}

class _ResetFormFieldState extends State<ResetFormField> {
  final formKey = GlobalKey<FormState>();
  // Reset/Change Password

  final currentUser = FirebaseAuth.instance.currentUser;
  reset() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await currentUser!.updatePassword(passwordController.text.toString());

      Fluttertoast.showToast(msg: "Password Change Successfully Login Again");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    } catch (e) {}
  }

  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: getProportionateScreenWidth(20)),
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.lock_open_rounded,
                    color: Color(0xffc4c4c4),
                  ),
                  hintText: "Enter your new password",
                  hintStyle: const TextStyle(color: kTextFieldTextColor),
                  fillColor: kTextFieldColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  errorStyle:
                      const TextStyle(color: Colors.redAccent, fontSize: 14),
                ),
                onSaved: (value) {
                  passwordController.text = value.toString();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.1,
              ),
              BuildButten(
                text: "Send",
                onpressed: () {
                  if (formKey.currentState!.validate()) {
                    reset();
                  }
                },
              ),
            ],
          ),
        ));
  }
}
