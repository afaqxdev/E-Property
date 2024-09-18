import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_property/Provider/Auth_Provider.dart';
import 'package:e_property/Provider/Send_Post_Provider.dart';
import 'package:e_property/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';
import 'Component/Body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostScreen extends StatefulWidget {
  String? name;
  String? image;
  PostScreen({Key? key, this.name, this.image}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController priceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  List<XFile>? images = [];
  List<String> downloadUrl = [];
  String? id = "Mudassir khan";

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        toolbarHeight: getProportionateScreenHeight(115),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Image.asset("assets/images/img1.png"),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.close,
                          color: kPrimaryColor,
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                        Text(
                          "Create Post",
                          style: TextStyle(
                              fontSize: 18.sm,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          Provider.of<SendPostProvider>(context, listen: false)
                              .uploadFunction(
                            images,
                            downloadUrl,
                            context,
                            titleController.text,
                            widget.name,
                            widget.image,
                            user?.uid,
                            int.tryParse(priceController.text),
                            int.tryParse(phoneController.text),
                            downloadUrl,
                            int.tryParse(sizeController.text),
                            cityController.text,
                            villageController.text,
                          );
                          setState(() {
                            isLoading = false;
                          });
                        }

                        // post data to firebase
                      },
                      child: Text(
                        "Post",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20.sm,
                            fontWeight: FontWeight.w900),
                      )),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
            ],
          ),
        ),
      ),
      body: Consumer<SendPostProvider>(
        builder: (context, value, child) {
          final user = value.isLoading;
          return user
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                        key: formKey,
                        child: Body(
                          name: widget.name,
                          profileImage: widget.image,
                          images: images,
                          phoneNumber: phoneController,
                          city: cityController,
                          village: villageController,
                          price: priceController,
                          size: sizeController,
                          title: titleController,
                        )),
                  ),
                );
        },
      ),
    );
  }
}
