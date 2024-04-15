// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app_project/shared/constant.dart';
import 'package:flutter/material.dart';

class GetImagFromFireBase extends StatefulWidget {

  const GetImagFromFireBase({super.key,});

  @override
  State<GetImagFromFireBase> createState() => _GetImagFromFireBaseState();
}


final credential = FirebaseAuth.instance.currentUser;

CollectionReference userss = FirebaseFirestore.instance.collection('usersss');

class _GetImagFromFireBaseState extends State<GetImagFromFireBase> {
  

  @override
  Widget build(BuildContext context) {
    

    // CollectionReference users =
    //     FirebaseFirestore.instance.collection('usersss');

    return FutureBuilder<DocumentSnapshot>(
      future: userss.doc(credential!.uid).get(),
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
          return CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            radius: 64,
                            backgroundImage:  NetworkImage(  "${data['imgLink']}"),
                           
                          //  : Image.file(imgPath!)
                            
                          );
        }

        return Text("loading");
      },
    );
  }
}
