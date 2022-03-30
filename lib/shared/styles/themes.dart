import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/shared/constants.dart';


ThemeData lightMode(){
  return ThemeData(

scaffoldBackgroundColor: kBackgroundColor,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: kPrimaryColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: kPrimaryColor,
          statusBarIconBrightness:Brightness.dark,


        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
            color: Colors.black
        )

    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kBackgroundColor,
      elevation: 25,
      backgroundColor: kPrimaryColor,


    ),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
          fontFamily: "Bahij Janna",
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      subtitle1: TextStyle(
        fontFamily: "Bahij Janna",
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        height: 1.3
      )
    ),
  );
}
ThemeData darkMode(){
  return ThemeData(

    scaffoldBackgroundColor:HexColor("333739") ,
    appBarTheme:  AppBarTheme(
        titleSpacing: 20.0,
        titleTextStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: HexColor("333739"),
        systemOverlayStyle:  SystemUiOverlayStyle(
          statusBarColor: HexColor("333739"),
          statusBarIconBrightness:Brightness.light,


        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
            color: Colors.white
        )

    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.black12,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kPrimaryColor,
      elevation: 25,

    ),
    textTheme:  TextTheme(
        bodyText1: TextStyle(
          fontFamily: "Bahij Janna",
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        subtitle1: TextStyle(
          fontFamily: "Bahij Janna",
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
            height: 1.3
        )
    ),
  );

}