import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_property/Models/FirebaseUserModel.dart';
import 'package:e_property/Users/UserHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;

  Future getImage() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      }
      if (pick == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No FIle  selected")));
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  signUp() async {
    try {
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please Pick an image")));
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        final postID = DateTime.now().microsecondsSinceEpoch.toString();
        // Current user id
        User? user = FirebaseAuth.instance.currentUser;
        // add image in specific file in storage
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('${user?.uid}/image')
            .child("image");

        await ref.putFile(_image!);
        // download image url and store in variable
        downloadURL = await ref.getDownloadURL();

        //create firebase
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

        //Calling our User Model
        UserModel userModel = UserModel();

        // writing all the value that we add to firestore
        userModel.name = nameController.text;
        userModel.email = user?.email;
        userModel.uid = user?.uid;
        userModel.city = cityController.text;
        userModel.number = int.tryParse(phoneNumberController.text);
        userModel.image = downloadURL;

        await firebaseFirestore
            .collection('user')
            .doc(user?.uid)
            .set(userModel.toMap());

        // navigate to login page
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserHomePage(),
            ));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "User Register Successfully ",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              )),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("please enter Strong Password");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "please enter strong password ",
                style: TextStyle(fontSize: 18, color: Colors.black),
              )),
        );
      } else if (e.code == 'email-already-in-use') {
        print('This Email already have taken');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "This email already have taken",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              )),
        );
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cityController.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dh = MediaQuery.of(context).size.height / 100;
    var dw = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: const Color(0xffffffff),
        toolbarHeight: 49,
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
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    getImage();
                  },
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Color(0xfff1f1f1),
                            child: ClipOval(
                              child: SizedBox(
                                height: 110,
                                width: 110,
                                child: _image == null
                                    ? Image.asset(
                                        "assets/images/img5.png",
                                        fit: BoxFit.fill,
                                      )
                                    : Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: const [
                    Text(
                      "Register",
                      style: TextStyle(
                          color: Color(0xff1098c2),
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                    ),
                    Text("Create an account")
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    controller: nameController,
                    style: const TextStyle(color: Color(0xff333333)),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 20),
                        filled: true,
                        fillColor: const Color(0xffefefef),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Full Name',
                        hintStyle: const TextStyle(
                          color: Color(0xffafafaf),
                        ),
                        errorStyle: const TextStyle(
                            color: Colors.redAccent, fontSize: 14)),
                    onSaved: (value) {
                      nameController.text = value.toString();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    controller: emailController,
                    style: const TextStyle(color: Color(0xff333333)),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      filled: true,
                      fillColor: const Color(0xffefefef),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                          color: Color(0xffafafaf), fontSize: 15),
                      errorStyle: const TextStyle(
                          color: Colors.redAccent, fontSize: 14),
                    ),
                    onSaved: (value) {
                      emailController.text = value.toString();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your Email";
                      } else if (!value.contains('@')) {
                        return 'please enter valid email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Color(0xff333333)),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      filled: true,
                      fillColor: const Color(0xffefefef),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        color: Color(0xffafafaf),
                      ),
                      errorStyle: const TextStyle(
                          color: Colors.redAccent, fontSize: 14),
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
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    textAlign: TextAlign.justify,
                    controller: phoneNumberController,
                    style: const TextStyle(color: Color(0xff333333)),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Color(0xffafafaf),
                      ),
                      filled: true,
                      fillColor: const Color(0xffefefef),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: 'Phone Number',
                      hintStyle: const TextStyle(
                          color: Color(0xffafafaf), fontSize: 15),
                      errorStyle: const TextStyle(
                          color: Colors.redAccent, fontSize: 14),
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
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    textAlign: TextAlign.justify,
                    controller: cityController,
                    style: const TextStyle(color: Color(0xff333333)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffefefef),
                      contentPadding: const EdgeInsets.only(left: 20),
                      prefixIcon: const Icon(
                        Icons.location_city,
                        color: Color(0xffafafaf),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: 'City',
                      hintStyle: const TextStyle(
                        color: Color(0xffafafaf),
                      ),
                      errorStyle: const TextStyle(
                          color: Colors.redAccent, fontSize: 14),
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
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      signUp();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: dw * 40,
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    decoration: BoxDecoration(
                        color: const Color(0xff1098c2),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "i Already have an account ?.. ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              (MaterialPageRoute(
                                builder: (context) => UserHomePage(),
                              )));
                        },
                        child: const Text(
                          "Login",
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
          "assets/images/img3.png",
          fit: BoxFit.fill,
        ),
      ),
      backgroundColor: const Color(0xffffffff),
    );
  }
}
