// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flower_app_project/model/Prodact.dart';
import 'package:flower_app_project/pages/checkOut.dart';
import 'package:flower_app_project/pages/details_screen.dart';
import 'package:flower_app_project/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarRebited extends StatelessWidget {
  const AppBarRebited({super.key});

  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);

    return Row(
      children: [
        Stack(
          children: [
            Container(
                child: Text(
                  "${classInstancee.selectedProdact.length}",
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Color.fromARGB(211, 164, 255, 193),
                    shape: BoxShape.circle)),
            IconButton(onPressed: () 
            {
                        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckOut(),
                      ));

            }
            , icon: Icon(Icons.add_shopping_cart)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text("\$ ${classInstancee.sum}"),
        )
      ],
    );
  }
}
