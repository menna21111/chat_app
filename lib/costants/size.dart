import 'package:flutter/material.dart';

class screan_size {
  static late double width;
  static late double hieght;
  static void init(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    hieght = MediaQuery.of(context).size.height;

  }
}