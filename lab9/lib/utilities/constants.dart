// lib/utilities/constants.dart
import 'package:flutter/material.dart';

// Thay bằng API Key thực tế của bạn
const kApiKey = '697b44cf8f32813c1d90cac40cfcfae1';
const kOpenWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 80.0,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 28.0,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

const kButtonTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'Spartan MB',
  color: Colors.white,
);

const kConditionTextStyle = TextStyle(
  fontSize: 80.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(Icons.location_city, color: Colors.white, size: 30.0),
  hintText: 'Nhập tên thành phố (vd: Hanoi)',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
    borderSide: BorderSide.none,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
);
