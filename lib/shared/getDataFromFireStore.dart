// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app_project/shared/constant.dart';
import 'package:flutter/material.dart';

class GetDataFromFireBase extends StatefulWidget {
  final String documentId;

  const GetDataFromFireBase({super.key, required this.documentId});

  @override
  State<GetDataFromFireBase> createState() => _GetDataFromFireBaseState();
}

final newUserNameController = TextEditingController();
final newAgeController = TextEditingController();
final newTitleController = TextEditingController();
final newPasswordController = TextEditingController();

final credential = FirebaseAuth.instance.currentUser;

CollectionReference users = FirebaseFirestore.instance.collection('usersss');

class _GetDataFromFireBaseState extends State<GetDataFromFireBase> {
  @override
  void dispose() {
    // TODO: implement dispose
    newAgeController.dispose();
    newUserNameController.dispose();
    newTitleController.dispose();
    newPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myShowDialog(Map data, key, value,  
        {TextInputType keyboardType = TextInputType.emailAddress}) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                height: 150,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: keyboardType,
                      controller: value,
                      maxLength: 50,
                      decoration: InputDecoration(
                        hintText: "Add new $key  :",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              users.doc(credential!.uid).update({key: value.text});
                            });
                            Navigator.pop(context);
                          },
                          child: Text("Edit", style: TextStyle(fontSize: 22)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancle", style: TextStyle(fontSize: 22)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    }

    // CollectionReference users =
    //     FirebaseFirestore.instance.collection('usersss');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                            "User Name : ${data['username']} ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () {
                                myShowDialog(data, "username",
                                    newUserNameController);
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 26,
                                color: Colors.white,
                              )),
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
                            "Age: ${data['age']} ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          IconButton(
                              // onPressed: () {
                              //   myShowDialog(data, "age", newAgeController,keyboardType: TextInputType.number);
                              // },
                              onPressed: () {
                                myShowDialog(data, 'age', newAgeController,
                                    keyboardType: TextInputType.number);
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 26,
                                color: Colors.white,
                              )),
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
                            "Title: ${data['title']} ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () {
                                myShowDialog(
                                    data, "title", newTitleController);
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 26,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shadowColor: Colors.black,
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: BTNgreen,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email: ${data['email']} ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
                            "Password: ${data['password']} ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () {
                                myShowDialog(
                                    data, "password", newPasswordController);
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 26,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}
