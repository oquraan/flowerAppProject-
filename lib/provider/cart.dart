import 'package:flower_app_project/model/Prodact.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  int count = 0;
  double sum = 0;
  List<Prodact> selectedProdact = [];

  void add(value) {
    selectedProdact.add(value);
    notifyListeners();
  }

  void removeAtIndex(index) {
    selectedProdact.removeAt(index);
    notifyListeners();
  }
}
