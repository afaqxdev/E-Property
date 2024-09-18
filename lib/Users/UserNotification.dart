import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Image.asset("assets/images/img1.png"),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Notification",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Color(0xff1098c2),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          color: Color(0xffeff1f4), shape: BoxShape.circle),
                      child: IconButton(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 1),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < 20; i++) ...[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            iconSize: 60,
                            onPressed: () {},
                            icon: const CircleAvatar(
                              radius: 60,
                              backgroundImage:
                              AssetImage('assets/images/img5.png'),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: const TextSpan(
                                      text: "Maaz Afridi  ",
                                      style: TextStyle(
                                          color: Color(0xff1098c2),
                                          fontWeight: FontWeight.w900),
                                      children: [
                                        TextSpan(
                                            text: "added a new Photo",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ))
                                      ])),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Just Now",
                                style: TextStyle(color: Colors.blueGrey),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ],
          ),
        ));
  }
}
