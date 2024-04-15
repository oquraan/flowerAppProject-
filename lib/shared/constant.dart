import 'package:flutter/material.dart';

const decorationTextField = InputDecoration(
  hintText: "Enter Your Password : ",
  // To delete borders
  enabledBorder: OutlineInputBorder(
    borderSide:BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  ),
  // fillColor: Colors.red,
  filled: true,
  contentPadding: const EdgeInsets.all(8),
);
const BTNpink = Color.fromARGB(255, 241, 39, 100);
 const BTNgreen = Color.fromARGB(255, 73, 179, 105);
 const appbarGreen = Color.fromARGB(255, 76, 141, 95);
 
 