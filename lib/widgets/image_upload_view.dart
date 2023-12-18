import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../global/styles/colors.dart';
import '../utils/constants.dart';

class ImageUploadView extends StatelessWidget {
  const ImageUploadView({super.key, this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 126,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFF949494)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Image.asset(
                AppImages.uploadIcon,
                width: 30,
                height: 30,
              ),
            ),
            Text(
              AppStrings.uploadImage,
              style: GoogleFonts.inter(
                color: AppColors.greyColor,
                fontSize: AppFontSizes.fontSize14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              AppStrings.photoType,
              style: GoogleFonts.inter(
                color: AppColors.greyColor,
                fontSize: AppFontSizes.fontSize12,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}


class SelectedImageView extends StatelessWidget {
  const SelectedImageView({super.key, this.selectedImage, this.onTap});

  final File? selectedImage;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 126,
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: FileImage(selectedImage!),
            fit: BoxFit.fill,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  height: 32,
                  margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: ShapeDecoration(
                    color: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Change photo',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w500,
                          height: 0.10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}