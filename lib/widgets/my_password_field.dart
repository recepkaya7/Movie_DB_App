import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db_api/constants/auth_style.dart';

class MyPasswordField extends StatefulWidget {
  const MyPasswordField(
      {Key? key,
      required this.isPasswordVisible,
      required this.onTap,
      required this.autovalidateMode,
      required this.controller})
      : super(key: key);

  final bool isPasswordVisible;
  final Function onTap;
  final TextEditingController controller;
  final AutovalidateMode autovalidateMode;

  @override
  State<MyPasswordField> createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: (value) {
          return value != null && value.length < 6
              ? 'Enter min. 6 characters'.tr
              : null;
        },
        controller: widget.controller,
        style: kBodyText.copyWith(
          color: Colors.white,
        ),
        obscureText: widget.isPasswordVisible,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                widget.onTap();
              },
              icon: Icon(
                widget.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(20),
          hintText: 'Password'.tr,
          hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
