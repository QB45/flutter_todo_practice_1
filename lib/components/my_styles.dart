import 'package:flutter/material.dart';

ButtonStyle myButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 255, 255, 200)),
  fixedSize: WidgetStateProperty.all(Size(100, 45)),
  textStyle: WidgetStateProperty.all(
    TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
  ),
);
