// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app_project/model/Prodact.dart';
import 'package:flower_app_project/pages/Profilepage.dart';
import 'package:flower_app_project/pages/checkOut.dart';
import 'package:flower_app_project/pages/details_screen.dart';
import 'package:flower_app_project/pages/login.dart';
import 'package:flower_app_project/provider/cart.dart';
import 'package:flower_app_project/shared/appBar.dart';
import 'package:flower_app_project/shared/constant.dart';
import 'package:flower_app_project/shared/getImagFromFireStore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flower_app_project/shared/getImagFromFireStore.dart';




















class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {










    
    final classInstancee = Provider.of<Cart>(context); //to use provider 
    final userInfo = FirebaseAuth.instance.currentUser!;// to get information user
    CollectionReference users = FirebaseFirestore.instance.collection('usersss');







    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 76, 141, 95),
        title: Text("Home"),
        actions: [AppBarRebited()],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: GetImagFromFireBase(),
                  accountName: Text(userInfo.displayName!=null?userInfo.displayName!:"Omar Quraan"),
                  accountEmail: Text(userInfo.email! ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 53, 137, 78),
                      image: DecorationImage(
                          fit: BoxFit.scaleDown,
                          image:
                              AssetImage("assets/smiley-4832492_960_720.png"))),
                ),
                ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                    }),
                ListTile(
                    title: Text("My products"),
                    leading: Icon(Icons.add_shopping_cart),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckOut(),
                          ));
                    }),
                                    ListTile(
                    title: Text("Profile Page "),
                    leading: Icon(Icons.person),
                    onTap: () {


  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ));

                    }),
                
                ListTile(
                    title: Text("About"),
                    leading: Icon(Icons.help_center),
                    onTap: () {}),
                ListTile(
                    title: Text("Logout"),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => Login(),
                            //     ));

                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Developed by Omar Essam Quraan ",
                  style: TextStyle(fontSize: 10),
                ),
                Icon(
                  Icons.copyright,
                  size: 15,
                ),
                Text(
                  "2024",
                  style: TextStyle(fontSize: 10),
                )
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 22),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 33,
            ),
            itemCount: l1.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(
                          prodacts: l1[index],
                        ),
                      ));
                },
                child: GridTile(
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          left: 0,
                          top: -3,
                          bottom: -9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(l1[index].pathImage),
                          ),
                        )
                      ],
                    ),
                    footer: Container(
                      height: 50,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 25,
                            bottom: 0,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(138, 166, 190, 156),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      classInstancee.count++;
                                      classInstancee.sum += l1[index].price;
                                      classInstancee.add(l1[index]);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Color.fromARGB(255, 62, 94, 70),
                                    ))),
                          ),
                          Positioned(
                              left: 25,
                              bottom: 0,
                              child: Text("\$${l1[index].price}"))
                        ],
                      ),
                    )
                    //  GridTileBar(

                    //     backgroundColor: Colors.amberAccent,
                    //   trailing: Container(
                    //     decoration: BoxDecoration(
                    //       color: Color.fromARGB(138, 166, 190, 156),
                    //       borderRadius: BorderRadius.circular(10),

                    //     ),

                    //     child: IconButton(
                    //         onPressed: () {},
                    //         icon: Icon(
                    //           Icons.add,
                    //           color: Color.fromARGB(255, 62, 94, 70),
                    //         )),
                    //   ),
                    //   leading: Text("\$${l1[index].price}"),
                    //   title: Text(""),
                    // ),
                    ),
              );
            }),
      ),
    );
  }
}
