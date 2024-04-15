// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flower_app_project/provider/cart.dart';
import 'package:flower_app_project/shared/appBar.dart';
import 'package:flower_app_project/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 76, 141, 95),
          title: Text("Check Screen "),
          actions: [AppBarRebited()],
        ),
        body: Column(
          children: [

            
            Container(
               height: 600,
              margin: EdgeInsets.only(bottom:20),
                child: ListView.builder(
                    itemCount: classInstancee.selectedProdact.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          subtitle: Text(
                              "\$${classInstancee.selectedProdact[index].price}  -  ${classInstancee.selectedProdact[index].location}"),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(classInstancee
                                .selectedProdact[index].pathImage),
                          ),
                          title: Text(
                              classInstancee.selectedProdact[index].flowerName),
                          trailing: IconButton(
                              onPressed: () {
                                classInstancee.sum -=
                                    classInstancee.selectedProdact[index].price;
            
                                classInstancee.removeAtIndex(index);
                              },
                              icon: Icon(Icons.remove)),
                        ),
                      );
                    })),
                    ElevatedButton(
   onPressed: (){},
   style: ButtonStyle(
     backgroundColor: MaterialStateProperty.all(BTNgreen),
     padding: MaterialStateProperty.all(EdgeInsets.all(12)),
     shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  ),
   child: Text("click here", style: TextStyle(fontSize: 19,color: Colors.white),),
),
          ],
        ));
  }
}
