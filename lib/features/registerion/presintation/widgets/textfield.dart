import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Customtextfield extends StatelessWidget {
   const Customtextfield(
      {super.key,
      required this.hinttext,
      required this.controller,
      required this.icon,this.func});
  final String hinttext;
  final TextEditingController controller;
  final IconData icon;
   final FormFieldValidator<String>?  func;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              size: 24,
              color: Colors.green,
            ),
            filled: true,
            fillColor: const Color.fromRGBO(232, 245, 233, 1),
            hintText: hinttext,
            hintStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color.fromRGBO(232, 245, 233, 1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color.fromRGBO(232, 245, 233, 1),
              ),
            ),
          ),
          validator: func),
    );
  }
}
