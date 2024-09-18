import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_property/Models/FirebasePostModel.dart';
import 'package:e_property/Users/UserHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  const AddPost({
    Key? key,
  }) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  var title = '';
  final formKey = GlobalKey<FormState>();
  List<XFile> _image = [];
  List<String> downloadUrl = [];
  final ImagePicker _imagePicker = ImagePicker();

  // Select Images From Gallery
  Future<void> selectImage() async {
    if (_image != null) {
      _image.clear();
    }
    try {
      final List<XFile>? imgs = await _imagePicker.pickMultiImage();
      if (imgs!.isNotEmpty) {
        _image.addAll(imgs);
      }
    } catch (e) {
      print('something wrong');
    }
    setState(() {});
  }

  // Uploading images to cloud Storage
  Future<String> uploadFile(XFile _img) async {
    final postID = DateTime.now().microsecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('${user?.uid}')
        .child('Post Images/$postID');
    await ref.putFile(File(_img.path));
    return await ref.getDownloadURL();
  }

  // current user
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController titleController = TextEditingController();
  // Upload complete data to firebase
  Future uploadFunction(List<XFile>? _images) async {
    for (int i = 0; i < _image.length; i++) {
      var imgUrl = await uploadFile(_images![i]);
      downloadUrl.add(imgUrl.toString());
    }

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // calling userModel
    Post post = Post();

    post.title = titleController.text;
    post.uid = user?.uid;
    post.image = downloadUrl;
    post.profileImage = image;
    post.name = name;
    await firebaseFirestore.collection('Post').doc().set(post.toMap());

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Images Upload Successfully")));

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserHomePage()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
  }

  String? image;
  String? name;

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Image.asset(
              "assets/images/img1.png",
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.black26,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Color(0xff1098c2),
                          )),
                      const Text(
                        "Create Post",
                        style: TextStyle(
                            color: Color(0xff1098c2),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              uploadFunction(_image);
                            }
                          },
                          child: const Text(
                            "Post",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      child: ClipOval(
                        child: SizedBox(
                          height: 55,
                          width: 55,
                          child: Image.network(
                            image ??
                                'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          name ?? " ",
                          style: const TextStyle(
                              color: Color(0xff1098c2),
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Container(
                          height: 30,
                          width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                Icons.vpn_lock_rounded,
                                color: Color(0xff1098c2),
                              ),
                              Text(
                                "People",
                                style: TextStyle(
                                  color: Color(0xff1098c2),
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Color(0xff1098c2),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              border:
                                  Border.all(color: const Color(0xff1098c2))),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
                child: TextFormField(
                  controller: titleController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  maxLines: null,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 20),
                      border: InputBorder.none,
                      hintText: "What do you want to write here?",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 17)),
                  onSaved: (value) {
                    titleController.text = value.toString();
                  },
                ),
              ),
              Container(
                height: 250,
                child: _image.length == 0
                    ? Text(" ")
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _image.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.file(
                            File(_image[index].path),
                            fit: BoxFit.cover,
                          );
                        }),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                  height: 1, width: double.infinity, color: Colors.grey[300]),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () {
                    selectImage();
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.photo,
                        color: Color(0xff1098c2),
                        size: 30,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        " From Gallery",
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
                  height: 1, width: double.infinity, color: Colors.grey[300]),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.video_collection,
                        color: Color(0xff1098c2),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "From Galery",
                        style: TextStyle(
                            color: Color(0xff1098c2),
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  height: 1, width: double.infinity, color: Colors.grey[300]),
            ],
          ),
        ),
      ),
    );
  }
}
