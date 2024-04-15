// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flower_app_project/firebase_options.dart';
import 'package:flower_app_project/pages/home.dart';
import 'package:flower_app_project/pages/login.dart';
import 'package:flower_app_project/provider/cart.dart';
import 'package:flower_app_project/provider/google_sign_in.dart';
import 'package:flower_app_project/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
 import 'package:path/path.dart' show basename;
 import 'package:firebase_storage/firebase_storage.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
 File? imgPath;

class _MyAppState extends State<MyApp> {
 uploadImage() async {
    final pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {imgPath = File(pickedImg.path);});
    } else {print("NO img selected");}
    } catch (e) {print("Error => $e");}
      }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Cart();
        }),
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
      ],
      child: MaterialApp(
          title: "myApp",
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              } else if (snapshot.hasError) {
                return showSnackBar(context, "Something went wrong");
              } else if (snapshot.hasData) {
                return HomePage(); // home() OR verify email
              } else {
                return Login();
              }
            },
          )),
    );
  }
}

// ChangeNotifierProvider(
//       create: (context) {
//         return Cart();
//       },
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData.light(useMaterial3: true),
//         home: StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {return Center(child: CircularProgressIndicator(color: Colors.white,));} 
//       else if (snapshot.hasError) {return showSnackBar(context, "Something went wrong");}
//       else if (snapshot.hasData) {return HomePage();}
//       else { return Login();}
//     },
//         ),
//       ),
//     );

