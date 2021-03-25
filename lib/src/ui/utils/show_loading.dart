import 'package:flutter/material.dart';

showLoading(context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  );
}