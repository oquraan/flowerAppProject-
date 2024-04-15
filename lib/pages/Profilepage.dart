// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_app_project/pages/login.dart';
import 'package:path/path.dart' show basename;

import 'package:flower_app_project/shared/constant.dart';
import 'package:flower_app_project/shared/getDataFromFireStore.dart';
import 'package:flower_app_project/shared/getImagFromFireStore.dart';
import 'package:flower_app_project/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential = FirebaseAuth.instance.currentUser;
  File? imgPath;
  String? imgName;

  uploadImage() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(10000);
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pop(context);
            },
            label: Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: appbarGreen,
        title: Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(125, 78, 91, 110)),
                child: Stack(
                  children: [
                    imgPath == null
                        ? GetImagFromFireBase()
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
                            onPressed: () async {
                              await uploadImage();
                        
                              if (imgPath !=null) {
                                    final storageRef = FirebaseStorage.instance.ref(imgName);
                                    await storageRef.putFile(imgPath!);   
                               String url = await storageRef.getDownloadURL();

                            CollectionReference users = FirebaseFirestore.instance.collection('usersss');

                            users.doc(credential!.uid).update({"imgLink": url,});
                            
                      
                              }
                            },
                            icon: Icon(Icons.add_a_photo)))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 131, 177, 255),
                    borderRadius: BorderRadius.circular(11)),
                child: Text(
                  "Info from firebase Auth: ",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 11,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: BTNgreen,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email:   ${credential!.email}    ",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shadowColor: Colors.black,
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: BTNgreen,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Created date:  ${DateFormat('yMMMMd').format(credential!.metadata.creationTime!)}    ",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: BTNgreen,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Last Signed In: ${DateFormat("yMMMMd").format(credential!.metadata.lastSignInTime!)} ",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: TextButton(
                          onPressed: () {
                            credential!.delete();
                            users.doc(credential!.uid).delete();
                            Navigator.pop(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => Login(),
                            //     ));
                          },
                          child: Text(
                            "Delete User ",
                            style: TextStyle(color: Colors.blue, fontSize: 22),
                          )))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(11),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 131, 177, 255),
                          borderRadius: BorderRadius.circular(11)),
                      child: Text(
                        "Info from firebase firestore :",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ))),
              GetDataFromFireBase(
                documentId: credential!.uid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
