import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.black),
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kTextColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kTextColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kScaffoldBackgroundColor = Color(0xFF262449);

const kLoginButtonColor = Color(0xFFBD95FF);
const kRegisterButtonColor = Color(0xFFB5E3FF);

const kTextColor = Color(0xFF7D6EA0);
const kBannerTextStyle = TextStyle(
  fontSize: 45.0,
  color: Colors.white,
  fontWeight: FontWeight.w900,
);

const kCircularBorderRadius = Radius.circular(20);

const kMessageBubbleBorder = BorderRadius.only(
  bottomLeft: kCircularBorderRadius,
  bottomRight: kCircularBorderRadius,
);
