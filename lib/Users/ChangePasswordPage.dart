import 'package:e_property/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController changePasswordController = TextEditingController();
  var changePassword = "";

  final currentUser = FirebaseAuth.instance.currentUser;
  userChangePassword() async {
    try {
      await currentUser!.updatePassword(changePassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Your Password has been Changed. Login again!",
            style: TextStyle(fontSize: 18),
          )));
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/images/img1.png",
          fit: BoxFit.fill,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  height: 180,
                  width: 180,
                  child: Image.asset(
                    "assets/images/img2.png",
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Reset Password",
                  style: TextStyle(
                      color: Color(0xff1098c2),
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: changePasswordController,
                    textAlign: TextAlign.justify,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                        const EdgeInsets.only(left: 10, top: 15),
                        filled: true,
                        fillColor: const Color(0xffefefef),
                        hintText: "Enter new Password",
                        prefixIcon: const Icon(Icons.lock_open_rounded)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter new password";
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
                        changePassword = changePasswordController.text;
                      });
                      userChangePassword();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 150,
                    child: const Text(
                      "Change Password",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    decoration: BoxDecoration(
                        color: const Color(0xff1098c2),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Image.asset(
          "assets/images/img3.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
