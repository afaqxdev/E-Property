import 'dart:io';

import 'package:e_property/Component/buildButten.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Provider/Auth_Provider.dart';
import '../../../constant.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  File? image;

  SignUpForm({
    Key? key,
    this.image,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String? downloadUrl;

  @override
  void dispose() {
    // TODO: implement dispose

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    cityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Name TextField
          TextFormField(
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(left: getProportionateScreenWidth(20)),
              filled: true,
              prefixIcon: const Icon(
                Icons.person,
                color: Color(0xffc4c4c4),
              ),
              hintText: "Full Name",
              hintStyle: const TextStyle(color: kTextFieldTextColor),
              fillColor: kTextFieldColor,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              errorStyle:
                  const TextStyle(color: Colors.redAccent, fontSize: 14),
            ),
            onSaved: (value) {
              nameController.text = value.toString();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter your name';
              }
              return null;
            },
            controller: nameController,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),

          // Email TextField
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(left: getProportionateScreenWidth(20)),
              filled: true,
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: Color(0xffc4c4c4),
              ),
              hintText: "Email",
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
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          // Password TextField
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(left: getProportionateScreenWidth(20)),
              filled: true,
              prefixIcon: const Icon(
                Icons.lock_open,
                color: Color(0xffc4c4c4),
              ),
              hintText: "Password",
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
                return 'please enter your password';
              }
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          // Phone TextField
          TextFormField(
            controller: phoneNumberController,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(left: getProportionateScreenWidth(20)),
              filled: true,
              prefixIcon: const Icon(
                Icons.phone,
                color: Color(0xffc4c4c4),
              ),
              hintText: "Phone Number",
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
                return "please enter phone number";
              }
              return null;
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          // city TextField
          TextFormField(
            controller: cityController,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(left: getProportionateScreenWidth(20)),
              filled: true,
              prefixIcon: const Icon(
                Icons.house,
                color: Color(0xffc4c4c4),
              ),
              hintText: "City",
              hintStyle: const TextStyle(color: kTextFieldTextColor),
              fillColor: kTextFieldColor,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              errorStyle:
                  const TextStyle(color: Colors.redAccent, fontSize: 14),
            ),
            onSaved: (value) {
              cityController.text = value.toString();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter your city name';
              }
              return null;
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(40),
          ),
          BuildButten(
            text: "Register",
            onpressed: () async {
              if (formKey.currentState!.validate()) {
                await Provider.of<AuthProvider>(context, listen: false).signUp(
                    context,
                    email: emailController.text,
                    password: passwordController.text,
                    image: widget.image,
                    downloadUrl: downloadUrl,
                    name: nameController.text,
                    phone: int.tryParse(phoneNumberController.text),
                    city: cityController.text);
              }
            },
          )
        ],
      ),
    );
  }
}
