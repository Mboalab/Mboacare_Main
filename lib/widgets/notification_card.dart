import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/global/styles/colors.dart';

class NotificationCard extends StatelessWidget {
  String content;
  final String title;
  final String pubDate;
  final Function() tap;

  NotificationCard({
    Key? key,
    required this.content,
    required this.pubDate,
    required this.title,
    required this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Card(
        child: Container(
          width: double.infinity,
          color: AppColors.registerCard,
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 16),
          child: Row(children: [
            Container(
              child: Center(
                child: SvgPicture.asset(
                  ImageAssets.notification,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  maxLines: 2,
                  title.toUpperCase(),
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  content,
                  style: GoogleFonts.quicksand(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                trailing: Text(pubDate,
                    style: AppTextStyles.bodyThree.copyWith(
                      color: AppColors.buttonColor,
                    )),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
