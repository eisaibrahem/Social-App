import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// POST
// UPDATE
// DELETE

// GET

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

// https://newsapi.org/v2/everything?q=tesla&apiKey=65f7f556ec76449fa7dc7c0069f040ca

String? uId='';

String? serverToken ='AAAAAeOWKQU:APA91bEXP99xCArUcZgEq1nK-gogKC6DPYVglsNyGsXH_r3DAMI28o3Minm1nnTqAFt-Qf7WL6ksOwAHMRogdM2Q3b5dMs8FWoUnwVRbzgztVt-jyWm4fHBgf4v-zGgvwmXEvASz5l5R';
String? token;
var now = new DateTime.now();
var formatter = new DateFormat('dd-MM-yyyy');
String formattedTime = DateFormat('hh:mm a').format(now);
String formattedDate = formatter.format(now);

//DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(savedDateString);

// print(formattedTime);
// print(formattedDate);

const kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFF219ebc);
const kSecondaryColor = Color(0xFFfcca46);
const kTextColor = Color(0xFF023047);
const kTextLightColor = Color(0xFF747474);
const kBlueColor = Color(0xFF40BAD5);

const kDefaultPadding = 10.0;
