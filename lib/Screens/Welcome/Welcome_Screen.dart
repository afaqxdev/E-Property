import 'package:e_property/Screens/Welcome/component/body.dart';
import 'package:e_property/size_config.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        title: Image.asset(
          "assets/images/img1.png",
          fit: BoxFit.fill,
        ),
      ),
      body: Body(),
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          child: Image.asset("assets/images/img3.png")),
    );
  }
}
