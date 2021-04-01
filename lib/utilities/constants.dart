import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 80.0,
  color: Colors.lightBlueAccent,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Helvetica Neue',
  fontWeight: FontWeight.bold,
  fontSize: 40.0,
);

const kDateTextStyle = TextStyle(
  letterSpacing: 4,
  fontFamily: 'Helvetica Neue',
  fontWeight: FontWeight.w900,
  fontSize: 28.0,
  color: Colors.white70,
  backgroundColor: Colors.white10,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 60.0,
);

const inputDecoration = InputDecoration(
    filled: true,
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        borderSide: BorderSide(color: Colors.green, style: BorderStyle.solid)),
    hintText: "Enter a city...");
