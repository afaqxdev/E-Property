import 'package:e_property/Component/buildButten.dart';
import 'package:e_property/Provider/Auth_Provider.dart';
import 'package:e_property/Screens/Home/Home_Screen.dart';
import 'package:e_property/Screens/forgot/forgot_Screen.dart';
import 'package:e_property/Users/UserHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../size_config.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final storage = const FlutterSecureStorage();

  // Login Screen
  login() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );

      await storage.write(key: 'uid', value: credential.user?.uid);

      Fluttertoast.showToast(msg: "Login Successfully");

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.pop(context);
        print("no user Found for that email");
        Fluttertoast.showToast(msg: 'No user found for that email');
      } else if (e.code == 'wrong-password') {
        Navigator.pop(context);
        print("wrong password");
        Fluttertoast.showToast(msg: "your password is wrong");
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(left: getProportionateScreenWidth(20)),
              filled: true,
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: Color(0xffc4c4c4),
              ),
              hintText: "Enter your email",
              hintStyle: const TextStyle(color: kTextFieldTextColor),
              fillColor: kTextFieldColor,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              errorStyle:
                  const TextStyle(color: Colors.redAccent, fontSize: 14),
            ),
            onSaved: (value) {
              emailController.text = value.toString();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email';
              } else if (!value.contains('@')) {
                return 'please enter valid email';
              }
              return null;
            },
            controller: emailController,
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(left: getProportionateScreenWidth(20)),
              filled: true,
              prefixIcon: const Icon(
                Icons.lock_open_outlined,
                color: Color(0xffc4c4c4),
              ),
              hintText: "Enter your password",
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
                return 'please enter password';
              }
              return null;
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotScreen()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "forgot password ?",
                  style: TextStyle(color: kPrimaryColor),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          BuildButten(
            text: "Login",
            onpressed: () async {
              if (formkey.currentState!.validate()) {
                login();
              }
              //  Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
