import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../global/styles/colors.dart';
import '../utils/constants.dart';

class PasswordValidationView extends StatelessWidget {
  const PasswordValidationView(
      {super.key,
        required this.text,
        required this.controller,
        required this.condition,
      });


  final String text;
  final TextEditingController controller;
  final bool Function(String password) condition;

  @override
  Widget build(BuildContext context) {
    final bool isCheck = condition(controller.text);
    return Row(
      children: [
        SizedBox(
          width: AppFontSizes.fontSize20,
          height: AppFontSizes.fontSize20,
          child: Padding(
            padding: EdgeInsets.only(bottom: AppFontSizes.fontSize3),
            child: Icon(
              Icons.check_circle,
              color: isCheck ? AppColors.primaryColor : AppColors.borderColor,
            ),
          ),
        ),
        SizedBox(width: AppFontSizes.fontSize8,),
        Text(text,
            style: GoogleFonts.inter(
                color: AppColors.primaryColor,
              fontSize: AppFontSizes.fontSize14,
              fontWeight: FontWeight.w400
            )
        )
      ],
    );
  }
}