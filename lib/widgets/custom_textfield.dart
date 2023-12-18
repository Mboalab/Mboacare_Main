import 'package:flutter/material.dart';
import 'package:mboacare/global/styles/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validate;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.prefixIcon, this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validate,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.grey200),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.grey300, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.grey300, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.grey300, width: 1.5),
        ),
        errorBorder:  OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
