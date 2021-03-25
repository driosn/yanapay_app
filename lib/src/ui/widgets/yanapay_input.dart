import 'package:flutter/material.dart';

class YanapayInput extends StatelessWidget {
  
  String mHint;
  Function(String) mOnChanged;
  bool mPassword = false;
  TextEditingController mController;

  YanapayInput({
    @required this.mHint,
    @required this.mOnChanged,
    this.mController
  });

  YanapayInput.password({
    @required this.mHint,
    @required this.mOnChanged,
    this.mController
  }) {
    mPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: mController,
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