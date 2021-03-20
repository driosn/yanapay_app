import 'package:flutter/material.dart';

class YanapayInput extends StatelessWidget {
  
  String mHint;
  Function(String) mOnChanged;
  bool mPassword = false;

  YanapayInput({
    @required this.mHint,
    @required this.mOnChanged,
  });

  YanapayInput.password({
    @required this.mHint,
    @required this.mOnChanged
  }) {
    mPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        hintText: mHint,
      ),
      obscureText: mPassword,
      onChanged: mOnChanged,
    );
  }
}