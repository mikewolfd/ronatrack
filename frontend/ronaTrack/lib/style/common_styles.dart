import 'package:flutter/material.dart';

class CommonStyles {
  static textFormFieldStyle(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.symmetric(vertical: 5),
      labelStyle: TextStyle(color: Colors.black),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
      ),
    );
  }
}
