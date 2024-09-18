import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_property/Pages/LoginPage.dart';
import 'package:e_property/Users/ChangePasswordPage.dart';
import 'package:e_property/Users/UserHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final storage = const FlutterSecureStorage();

  File? _image;
  final imagePicker = ImagePicker();

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

  Future updateImage() async {
    // Current user id
    User? user = FirebaseAuth.instance.currentUser;

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('${user?.uid}/image')
        .child('image');
    await ref.putFile(_image!);

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Update Successfully")));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserHomePage()));
  }

  String? name;
  String? image;
  getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(user?.uid)
        .get();
    setState(() {
      image = userDoc.get('image');
      name = userDoc.get('name');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('user').snapshots();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 110,
        title: Column(
          children: [
            Image.asset(
              "assets/images/img1.png",
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserHomePage()),
                          (route) => false);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xff1098c2),
                    )),
                const Text(
                  "Profile Update",
                  style: TextStyle(
                      color: Color(0xff1098c2), fontWeight: FontWeight.w900),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: SizedBox(
                      height: 110,
                      width: 110,
                      child: _image == null
                          ? Image.network(
                              image ??
                                  'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Container(
                    child: IconButton(
                        onPressed: () {
                          getImage();
                        },
                        icon: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                              color: Color(0xff1098c2), shape: BoxShape.circle),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Color(0xffffffff),
                            size: 22,
                          ),
                        ))),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name ?? 'no name is show',
              style: const TextStyle(
                  color: Color(0xff1098c2),
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Write Your Biography",
                    fillColor: Colors.grey[120],
                    filled: true,
                    hintStyle: const TextStyle(
                        color: Color(0xff1098c2),
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xff1098c2),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangePassword()));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.lock,
                      color: Color(0xff1098c2),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Change Password",
                      style: TextStyle(
                          color: Color(0xff1098c2),
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xff1098c2),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  await storage.delete(key: "uid");
                  Navigator.pushReplacement(
                      context,
                      (MaterialPageRoute(
                          builder: (context) => const LoginPage())));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.logout,
                      color: Color(0xff1098c2),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                          color: Color(0xff1098c2),
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xff1098c2),
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                updateImage();
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xff1098c2),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
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
