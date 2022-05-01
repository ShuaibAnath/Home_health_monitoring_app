import 'package:flutter/material.dart';
class Styles{

  Styles._();
  static TextStyle dropDownTextStyle(Color textColour){
    return TextStyle(color: textColour, fontWeight: FontWeight.bold);
  }
  static Icon dropDownIconArrow(){
    return const  Icon(
        Icons.arrow_drop_down_circle_outlined,
        color: Colors.black);
  }
  static Widget dropDownUnderline(){
    return  Container(
      height: 2,
      color: Colors.black,
    );
  }
}
