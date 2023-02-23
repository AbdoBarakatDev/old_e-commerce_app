import 'package:flutter/material.dart';
import 'package:my_first_ecommerce_app/constants.dart';
import 'package:my_first_ecommerce_app/providers/password_icon_visibility_provider.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  final String hint, label;
  final IconData prefixIcon;
  IconData suffixIcon;
  final Function onClick;

  validateForm(String formData) {
    switch (formData) {
      case "Type Your Full Name":
        return "Full Name is Empty!";

      case "Type Your Email":
        return "Email is Empty!";

      case "Type Your Password":
        return "Password is Empty!";
    }
  }

  CustomTextField({this.label, this.prefixIcon, this.hint, this.suffixIcon,this.onClick});

  @override
  Widget build(BuildContext context) {
    final blocProvider = Provider.of<IconVisibilityProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        validator: (value) {
          // ignore: missing_return
          if (value.isEmpty) {
            return validateForm(hint);
          }
        },
        onSaved:onClick ,
        cursorColor: mainAppColor,
        obscureText: (suffixIcon != null
            ? (blocProvider.iconData == Icons.visibility)
                ? false
                : true
            : false),

        // (suffixIcon!=null && blocProvider.iconData == Icons.visibility) ? false : true,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          // labelStyle: TextStyle(fontFamily: "Pacifico"),
          prefixIcon: Icon(
            prefixIcon,
            color: mainAppColor,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(blocProvider.iconData),
                  onPressed: blocProvider.onIconVisibilityClicked,
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
          fillColor: secondAppColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(
              50,
            ),
            // gapPadding: 2,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(
              50,
            ),
            // gapPadding: 2,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(
              50,
            ),
            // gapPadding: 2,
          ),
        ),
      ),
    );
  }
}
