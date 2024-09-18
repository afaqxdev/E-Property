import 'package:e_property/Pages/LoginPage.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dh = MediaQuery.of(context).size.height / 100;
    var dw = MediaQuery.of(context).size.width / 100;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 49,
          backgroundColor: const Color(0xffffffff),
          title: Image.asset(
            "assets/images/img1.png",
            fit: BoxFit.fill,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 150),
                    height: 180,
                    width: 180,
                    child: Image.asset('assets/images/img2.png')),
                const SizedBox(
                  height: 150,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: dw * 50,
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    decoration: const BoxDecoration(
                        color: Color(0xff1098c2),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          color: const Color(0xffffffff),
          child: Image.asset(
            'assets/images/img3.png',
            fit: BoxFit.fill,
          ),
        ),
        backgroundColor: const Color(0xffffffff),
      ),
    );
  }
}
