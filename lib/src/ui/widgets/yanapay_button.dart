import 'package:flutter/material.dart';

class YanapayButton extends StatelessWidget {
  
  String mText;
  Function mOnPressed;

  YanapayButton({
    @required this.mText,
    @required this.mOnPressed
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.deepPurple,
      onPressed: mOnPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        mText,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}