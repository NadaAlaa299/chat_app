import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatelessWidget {
  CustomTextFormFeild({super.key, this.hint, this.onChange, this.validator});

  String? hint;
  Function(String)? onChange;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hint == 'Password' ? true : false,
      validator: validator,
      onChanged: onChange,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
          enabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white)),
    );
  }
}
