import 'package:flutter/material.dart';

import '../constant.dart';
import '../size_config.dart';

class BuildButten extends StatelessWidget {
  String? text;
  VoidCallback? onpressed;

  BuildButten({
    Key? key,
    this.onpressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          text.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        height: getProportionateScreenHeight(40),
        width: getProportionateScreenWidth(120),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius:
                BorderRadius.circular(getProportionateScreenWidth(10))),
      ),
    );
  }
}
