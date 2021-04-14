import 'package:DentalHome/components/colors.dart';
import 'package:flutter/material.dart';

// Text field creation
  Widget textField(TextEditingController controller, String validator,
      String hintText, Icon icon, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        style: TextStyle(color: Colors.grey[800]),
        keyboardType: TextInputType.text,
        controller: controller,
        validator: (input) => input.length < 3 ? "$validator" : null,
        decoration: new InputDecoration(
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 11.0),
          hintText: "$hintText",
          hintStyle: TextStyle(color: Colors.grey[800]),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: primaryColor,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black87,
          )),
          prefixIcon: icon,
        ),
      ),
    );
  }
  