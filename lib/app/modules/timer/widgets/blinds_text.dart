import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlindsText extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    TextStyle blindsTextStyle = TextStyle(
      color:Colors.grey[400]!,
    );

    TextStyle blindsValueStyle = TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.w700,
    );

    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF2C2C2C),
          style: BorderStyle.solid,
          width: 3
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // small blinds Text
          Text( "Small Blind", style: blindsTextStyle, ),
          // TODO small blinds logic
          Text( "100", style: blindsValueStyle, ),
          // bag blinds Text
          Text( "Big Blind", style: blindsTextStyle, ),
          // Todo Big Blinds Logic
          Text( "200", style: blindsValueStyle, ),
        ],
      ),
    );
  }
  
}