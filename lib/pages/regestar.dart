// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unused_local_variable

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_app_project/pages/login.dart';
import 'package:flower_app_project/shared/constant.dart';
import 'package:flower_app_project/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool iconPasswordVisibilty = true;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final userNameController = TextEditingController();
  final titleController = TextEditingController();
  File? imgPath;
  String? imgName;

  register() async {
    setState(() {
      isLoading = true;
    });

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final storageRef = FirebaseStorage.instance.ref(imgName);
      await storageRef.putFile(imgPath!);
      String imgUrl=await storageRef.getDownloadURL();
  
      CollectionReference users =
          FirebaseFirestore.instance.collection('usersss');
      ////////////////
      final userInfo =
          FirebaseAuth.instance.currentUser!; // to get information user

//////////////////
      users
          .doc(userInfo.uid) // .doc(credential.user!.uid)
          .set({
            'username': userNameController.text,
            'age': ageController.text,
            'title': titleController.text,
            'email': emailController.text,
            'password': passwordController.text,
            'imgLink':imgUrl,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists for that email.");
      } else {
        showSnackBar(context, "ERROR - Please try again late");
      }
    } catch (err) {
      showSnackBar(context, err.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    ageController.dispose();
    titleController.dispose();

    super.dispose();
  }

  bool isPassword8Char = false;
  bool hasUppercase = false;
  bool hasDigits = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  onPasswordChangeed(String text) {
    setState(() {
      if (text.contains(RegExp(r'.{8,}'))) {
        isPassword8Char = true;
      } else {
        isPassword8Char = false;
      }
      if (text.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      } else {
        hasUppercase = false;
      }

      if (text.contains(RegExp(r'[0-9]'))) {
        hasDigits = true;
      } else {
        hasDigits = false;
      }
      if (text.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      } else {
        hasLowercase = false;
      }
      if (text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacters = true;
      } else {
        hasSpecialCharacters = false;
      }
      //else
      //     {
      //  isPassword8Char = false;
      //  hasUppercase = false;
      //  hasDigits = false;
      //  hasLowercase = false;
      //  hasSpecialCharacters = false;

      //     }
    });
  }

  uploadImage() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(100000);
          imgName = "$random$imgName";
        });
      } else {
        showSnackBar(context, "NO img selected");
      }
    } catch (e) {
      showSnackBar(context, "Error => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appbarGreen,
          title: Text(
            "Register ",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(125, 78, 91, 110)),
                      child: Stack(
                        children: [
                          imgPath == null
                              ? CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  radius: 64,
                                  backgroundImage:
                                      AssetImage("assets/avatarImage.jpg"),

                                  //  : Image.file(imgPath!)
                                )
                              : ClipOval(
                                  child: Image.file(
                                    imgPath!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          Positioned(
                              right: -8,
                              bottom: -15,
                              child: IconButton(
                                  onPressed: () {
                                    uploadImage();
                                  },
                                  icon: Icon(Icons.add_a_photo)))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextField(
                        controller: userNameController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: decorationTextField.copyWith(
                            hintText: "Enter Your username : ",
                            suffixIcon: Icon(Icons.person))),
                    const SizedBox(
                      height: 33,
                    ),
                    TextField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: decorationTextField.copyWith(
                            hintText: "Enter Your age : ",
                            suffixIcon: Icon(Icons.emoji_nature))),
                    const SizedBox(
                      height: 33,
                    ),
                    TextField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: decorationTextField.copyWith(
                            hintText: "Enter Your title : ",
                            suffixIcon: Icon(Icons.person_2_outlined))),
                    const SizedBox(
                      height: 33,
                    ),
                    TextFormField(
                        // we return "null" when something is valid
                        validator: (value) {
                          return value != null &&
                                  !EmailValidator.validate(value)
                              ? "Enter a valid email"
                              : null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration: decorationTextField.copyWith(
                            hintText: "Enter Your Email : ",
                            suffixIcon: Icon(Icons.email))),
                    const SizedBox(
                      height: 33,
                    ),
                    TextFormField(
                        // we return "null" when something is valid
                        validator: (value) {
                          return value!.length < 8
                              ? "Enter at least 8 characters"
                              : null;
                        },
                        onChanged: (value) {
                          onPasswordChangeed(value);
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: iconPasswordVisibilty ? true : false,
                        decoration: decorationTextField.copyWith(
                            hintText: "Enter Your Password : ",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    iconPasswordVisibilty =
                                        !iconPasswordVisibilty;
                                  });
                                },
                                icon: Icon(iconPasswordVisibilty
                                    ? Icons.visibility
                                    : Icons.visibility_off)))),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  isPassword8Char ? Colors.green : Colors.white,
                              border: Border.all(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("At least 8 charachters ")
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasDigits ? Colors.green : Colors.white,
                              border: Border.all(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("At least 1 number")
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasUppercase ? Colors.green : Colors.white,
                              border: Border.all(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Has Uppercase")
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasLowercase ? Colors.green : Colors.white,
                              border: Border.all(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Has Lowercase ")
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasSpecialCharacters
                                  ? Colors.green
                                  : Colors.white,
                              border: Border.all(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Has Special Charactets ")
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            imgName != null &&
                            imgPath != null) {
                          await register();
                          if (!mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        } else {
                          showSnackBar(context, "ERROR valiedate Email  or Password or Image profile ");
                        }
                      },
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Register",
                              style: TextStyle(fontSize: 19),
                            ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(BTNgreen),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do not have an account?",
                            style: TextStyle(fontSize: 18)),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: Text('sign in',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 17))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
