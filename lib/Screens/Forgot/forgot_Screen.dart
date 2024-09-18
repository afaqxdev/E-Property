import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'component/Body.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        title: Image.asset(
          "assets/images/img1.png",
          width: double.infinity,
          fit: BoxFit.cover,
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
