import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../global/styles/colors.dart';
import '../utils/constants.dart';

class EditTextForm extends StatelessWidget {
  final String? Function(String?)? validator;
  final String hintText;
  final bool readonly;
  final bool? disAbleEdit;
  final String? suffixIcon;
  final String? prefixIcon;
  final VoidCallback? onTap;
  final Iterable<String>? autofillHints;
  final VoidCallback? onEditingComplete;
  final Function(String)? onSubmitted;
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
    this.onSubmitted,
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppFontSizes.fontSize1),
        child: TextField(
          controller: controller,
          onEditingComplete: onEditingComplete,
          onSubmitted: onSubmitted,
          maxLines: 1,
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readonly,
          keyboardType: keyboardType,
          inputFormatters: inputFormatter,
          style: GoogleFonts.inter(
              color: AppColors.primaryColor,
              fontSize: AppFontSizes.fontSize16,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: AppFontSizes.fontSize8,
              horizontal: AppFontSizes.fontSize10,
            ),
            suffixIcon: suffixIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Image.asset(
                      suffixIcon.toString(),
                    ),
                  ),
            prefixIcon: prefixIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Image.asset(
                      prefixIcon.toString(),
                    ),
                  ),
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 38, maxWidth: 38),
            suffixIconConstraints:
                const BoxConstraints(maxHeight: 38, maxWidth: 38),
            hintText: hintText,
            hintStyle: GoogleFonts.inter(
                color: AppColors.hintTextColor,
                fontSize: AppFontSizes.fontSize16,
                fontWeight: FontWeight.w400),
            labelStyle: GoogleFonts.inter(
                color: AppColors.primaryColor,
                fontSize: AppFontSizes.fontSize16,
                fontWeight: FontWeight.w400),
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
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: widget.controller,
        maxLines: 1,
        onChanged: widget.onChanged,
        obscureText: obscureText,
        style: GoogleFonts.inter(
            color: AppColors.primaryColor,
            fontSize: AppFontSizes.fontSize16,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(
            top: AppFontSizes.fontSize10,
            left: AppFontSizes.fontSize8,
            right: AppFontSizes.fontSize8,
          ),
          hintStyle: GoogleFonts.inter(
              color: AppColors.hintTextColor,
              fontSize: AppFontSizes.fontSize16,
              fontWeight: FontWeight.w400),
          labelStyle: GoogleFonts.inter(
              color: AppColors.primaryColor,
              fontSize: AppFontSizes.fontSize16,
              fontWeight: FontWeight.w400),
          hintText: widget.hintText,
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

class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({
    super.key,
    required this.number,
    this.hintText,
    this.onInputChanged,
    required this.controller,
    this.node,
    this.validator,
    this.onInputValidated,
    this.onSaved,
    this.onSubmit,
  });

  final PhoneNumber number;
  final String? hintText;
  final Function(PhoneNumber number)? onInputChanged;
  final TextEditingController controller;
  final FocusNode? node;
  final VoidCallback? onSubmit;
  final String? Function(String?)? validator;
  final ValueChanged<bool>? onInputValidated;
  final ValueChanged<PhoneNumber>? onSaved;

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: AppColors.borderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: widget.onInputChanged,
        onInputValidated: widget.onInputValidated,
        validator: widget.validator,
        onSubmit: widget.onSubmit,
        selectorConfig: const SelectorConfig(
          showFlags: false,
          trailingSpace: false,
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        spaceBetweenSelectorAndTextField: 1,
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: GoogleFonts.inter(
            color: AppColors.primaryColor,
            fontSize: AppFontSizes.fontSize16,
            fontWeight: FontWeight.w500),
        textStyle: GoogleFonts.inter(
            color: AppColors.primaryColor,
            fontSize: AppFontSizes.fontSize16,
            fontWeight: FontWeight.w500),
        inputDecoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: widget.hintText,
          hintStyle: GoogleFonts.inter(
              color: AppColors.primaryColor,
              fontSize: AppFontSizes.fontSize14,
              fontWeight: FontWeight.w400),
        ),
        initialValue: widget.number,
        textFieldController: widget.controller,
        formatInput: true,
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        inputBorder: InputBorder.none,
        onSaved: widget.onSaved,
      ),
    );
  }
}
