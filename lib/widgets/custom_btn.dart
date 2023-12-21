import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/widgets/extensions.dart';
import '../../utils/constants.dart';
import '../global/styles/colors.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final bool enabled;
  final Color? color;
bool? status;
   AppButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.enabled,
    this.color,
    this.status
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: enabled ? onPressed : null,
        child: status == false? Container(
            height: AppFontSizes.fontSize40,
            // margin: const EdgeInsets.only(left: 20,right: 20),
            padding: EdgeInsets.symmetric(
                vertical: 2.5, horizontal: AppFontSizes.fontSize16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppFontSizes.fontSize10),
              color: enabled
                  ? color ?? AppColors.primaryColor
                  : AppColors.disAbleButtonColor,
            ),
            child: Center(
                child: Text(title,
                    style: GoogleFonts.inter(
                        color: AppColors.whiteColor,
                        fontSize: AppFontSizes.fontSize16,
                        fontWeight: FontWeight.w600)
                )
            )
        ):const Center(child: SpinKitThreeBounce(color: AppColors.primaryColor))
    );
  }
}

class AppBorderButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final Color borderColor;
  final Color textColor;
  final String? image;
  final bool showImage;

  const AppBorderButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.image,
    this.showImage = false,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: context.getWidth(),
        height: AppFontSizes.fontSize40,
        padding: EdgeInsets.symmetric(
            horizontal: AppFontSizes.fontSize20,
            vertical: AppFontSizes.fontSize8),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: borderColor),
            borderRadius: BorderRadius.circular(AppFontSizes.fontSize10),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            showImage
                ? Image.asset(
                    image.toString(),
                    height: AppFontSizes.fontSize32,
                    width: AppFontSizes.fontSize32,
                  )
                : const SizedBox.shrink(),
            SizedBox(width: AppFontSizes.fontSize8),
            Text(title,
                style: GoogleFonts.inter(
                    color: textColor,
                    fontSize: AppFontSizes.fontSize16,
                    fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}
