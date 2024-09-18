import 'package:e_property/Component/buildButten.dart';
import 'package:e_property/Provider/Auth_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../size_config.dart';
import '../../login/loginScreen.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  bool isWaiting = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
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
          ),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.1,
          ),
          BuildButten(
            text: "Send",
            onpressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  isWaiting = true;
                });
                Provider.of<AuthProvider>(context, listen: false)
                    .forgot(context, email: emailController.text);
                setState(() {
                  isWaiting = false;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
