import 'package:flutter/material.dart';
import 'package:home_health_monitoring_app/screen_dimensions.dart';

class UIComponents{
  UIComponents._();
  static Widget createTextField(String hintText, IconData fieldIcon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: SizeConfig.safeBlockVertical * 1.5),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 3),
              boxShadow:  [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: SizeConfig.safeBlockHorizontal * 5,
                  offset: const Offset(0, 2),
                ),
              ]),
          height: SizeConfig.blockSizeVertical * 7,
          child:  TextField(
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 1.8),
              prefixIcon:  Icon(
                fieldIcon,
                color: const Color(0xFF5AC18E),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.black38,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget createTextButton(Text displayText, VoidCallback onPressedAction) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
          onPressed: onPressedAction,
          child: displayText
      ),
    );
  }

  static Widget createElevatedButton(ButtonStyle styleOfButton, VoidCallback onPressedAction, Text displayText){
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 2),
      width: double.infinity,
      child: ElevatedButton(
          style: styleOfButton,
          onPressed: onPressedAction,
          child: displayText
      ),
    );
  }

}
