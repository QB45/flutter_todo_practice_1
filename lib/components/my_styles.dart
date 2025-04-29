import 'package:flutter/material.dart';

ButtonStyle myButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 255, 255, 200)),
  fixedSize: WidgetStateProperty.all(Size(100, 42)),
  textStyle: WidgetStateProperty.all(
    TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
  ),
);

TextStyle txs11 = TextStyle(fontSize: 11);
TextStyle txs12 = TextStyle(fontSize: 12);
TextStyle txs13 = TextStyle(fontSize: 13);
TextStyle txs14 = TextStyle(fontSize: 14);
TextStyle txs16 = TextStyle(fontSize: 16);
TextStyle txs18 = TextStyle(fontSize: 18);
TextStyle txs20 = TextStyle(fontSize: 20);
