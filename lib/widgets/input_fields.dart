import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';
import '../utils/constants.dart';

class EditTextForm extends StatelessWidget {
  final String? Function(String?)? validator;
  final String hintText;
  final bool readonly;
  final bool? disAbleEdit;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final Iterable<String>? autofillHints;
  final VoidCallback? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;

  const EditTextForm({
    Key? key,
    this.readonly = false,
    required this.hintText,
    this.onChanged,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatter,
    this.validator,
    this.autofillHints,
    this.suffixIcon,
    this.prefixIcon,
    this.disAbleEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     width: AppFontSizes.fontSize1,
      //   ),
      //   borderRadius: BorderRadius.circular(AppFontSizes.fontSize8),
      // ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppFontSizes.fontSize1),
        child: TextField(
          controller: controller,
          onEditingComplete: onEditingComplete,
          onSubmitted: onFieldSubmitted,
          maxLines: 1,
          onChanged: onChanged,
          onTap: onTap,
          keyboardType: keyboardType,
          inputFormatters: inputFormatter,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: AppFontSizes.fontSize8,
              horizontal: AppFontSizes.fontSize10,
            ),
            hintText: hintText,
            hintStyle: GoogleFonts.inter(
                color: AppColors.hintTextColor,
                fontSize: AppFontSizes.fontSize16,
                fontWeight: FontWeight.w400),
            labelStyle: GoogleFonts.inter(
                color: AppColors.primaryColor,
                fontSize: AppFontSizes.fontSize16,
                fontWeight: FontWeight.w500),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppFontSizes.fontSize8)),
                borderSide: const BorderSide(color: AppColors.primaryColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppFontSizes.fontSize8)),
                borderSide: const BorderSide(
                  color: AppColors.borderColor,
                )),
            disabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppFontSizes.fontSize8)),
                borderSide: const BorderSide(
                  color: AppColors.borderColor,
                )),
          ),
        ),
      ),
    );
  }
}

class PasswordForm extends StatefulWidget {
  final String hintText;
  final bool readonly;
  final Function(String)? onChanged;
  final Iterable<String>? autofillHints;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final FocusNode? node;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const PasswordForm(
      {Key? key,
      this.readonly = false,
      required this.hintText,
      this.onChanged,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.inputFormatters,
      this.node,
      this.autofillHints})
      : super(key: key);

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: AppColors.password,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(
            top: AppFontSizes.fontSize10,
            left: AppFontSizes.fontSize8,
            right: AppFontSizes.fontSize8,
            // horizontal: AppFontSizes.fontSize8,
          ),
          hintText: widget.hintText,
          labelStyle: const TextStyle(color: AppColors.primaryColor),
          border: InputBorder.none,
          suffixIcon: SizedBox(
            child: IconButton(
              onPressed: _togglePasswordView,
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppFontSizes.fontSize8)),
              borderSide: const BorderSide(color: AppColors.primaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppFontSizes.fontSize8)),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
              )),
          disabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppFontSizes.fontSize8)),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
              )),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
