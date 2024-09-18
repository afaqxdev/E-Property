import 'package:e_property/Pages/HomePage.dart';
import 'package:e_property/Provider/Auth_Provider.dart';
import 'package:e_property/Provider/Send_Post_Provider.dart';
import 'package:e_property/Screens/Home/Home_Screen.dart';
import 'package:e_property/Screens/Welcome/Welcome_Screen.dart';
import 'package:e_property/Users/UserHomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final storage = const FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");

    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Something Went Wrong");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ScreenUtilInit(
            builder: (context, child) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => SendPostProvider()),
                ChangeNotifierProvider(create: (context) => AuthProvider()),
              ],
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: FutureBuilder(
                    future: checkLoginStatus(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.data == true) {
                        return HomeScreen();
                      }

                      return const WelcomeScreen();
                    },
                  )),
            ),
            designSize: const Size(414, 896),
          );
        });
  }
}
