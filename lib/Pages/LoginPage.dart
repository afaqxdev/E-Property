import 'package:e_property/Models/FirebaseUserModel.dart';
import 'package:e_property/Pages/ForgotPasswordPage.dart';
import 'package:e_property/Pages/RegistrationPage.dart';
import 'package:e_property/Users/UserHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserModel userModel = UserModel();

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();

  Login() async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      await storage.write(key: 'uid', value: credential.user?.uid);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "User Successfully login",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserHomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("no user Found for that email");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'No user found for that email',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print("wrong password");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'your password is wrong',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        );
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
    var dh = MediaQuery.of(context).size.height / 100;
    var dw = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        toolbarHeight: 49,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  height: 150,
                  width: 150,
                  child: Image.asset(
                    'assets/images/img2.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Color(0xff1098c2),
                        fontSize: 25,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                //for Email textfieldd
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: emailController,
                    style: const TextStyle(color: Color(0xff333333)),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: 'Enter Your Email',
                      hintStyle: const TextStyle(
                        color: Color(0xffafafaf),
                      ),
                      errorStyle: const TextStyle(
                          color: Colors.redAccent, fontSize: 14),
                      filled: true,
                      fillColor: const Color(0xffefefef),
                      prefixIcon: const Icon(
                        Icons.mail_outline,
                        color: Color(0xffafafaf),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      } else if (!value.contains('@')) {
                        return 'please enter valid email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      emailController.text = value.toString();
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                //for password field
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    controller: passwordController,
                    style: const TextStyle(color: Color(0xff333333)),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xffefefef),
                      hintText: 'Enter Your Password',
                      hintStyle: const TextStyle(
                        color: Color(0xffafafaf),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_open_rounded,
                        color: Color(0xffafafaf),
                      ),
                      errorStyle: const TextStyle(
                          color: Colors.redAccent, fontSize: 14),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      passwordController.text = value.toString();
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //for forgetting password
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 30),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordPage()));
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xff1098c2),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),
                // For Login Button
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Login();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: dw * 40,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff1098c2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.twitter,
                          color: Colors.black,
                          size: 30,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.chrome,
                          color: Colors.black,
                          size: 30,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.black,
                          size: 30,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),

                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "i don't have an account?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => RegisterPage())));
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Color(0xff1098c2),
                              fontWeight: FontWeight.w900,
                              fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
    );
  }
}
