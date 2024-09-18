import 'package:e_property/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  var email = '';

  TextEditingController emailController = TextEditingController();

  ForgotPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Password Reset Email has been sent !",
              style: TextStyle(
                fontSize: 18,
              ),
            )),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("no user found for that email");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "no user found that email",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var dh = MediaQuery.of(context).size.height / 100;
    var dw = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 49,
        elevation: 0.0,
        backgroundColor: const Color(0xffffffff),
        title: Image.asset(
          "assets/images/img1.png",
          fit: BoxFit.fill,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 250),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                                (route) => false);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Color(0xff1098c2),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: 150,
                  child: Image.asset(
                    "assets/images/img2.png",
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: const [
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                          color: Color(0xff1098c2),
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Enter your email to receive the code",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    controller: emailController,
                    style: const TextStyle(color: Color(0xff333333)),
                    decoration: InputDecoration(
                        errorStyle: const TextStyle(
                            color: Colors.redAccent, fontSize: 14),
                        contentPadding: const EdgeInsets.only(top: 15),
                        filled: true,
                        fillColor: const Color(0xffefefef),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Enter Your Email ',
                        prefixIcon: const Icon(
                          Icons.mail_outline,
                          color: Color(0xff333333),
                        ),
                        hintStyle: const TextStyle(
                          color: Color(0xff333333),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your email';
                      } else if (!value.contains('@')) {
                        return 'please enter valid email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        email = emailController.text;
                      });
                    }
                    ForgotPassword();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: dw * 40,
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff1098c2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xffffffff),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xffffffff),
        child: Image.asset(
          "assets/images/img3.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
