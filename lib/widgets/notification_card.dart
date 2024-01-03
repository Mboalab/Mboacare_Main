import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
          child: Row(
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    ImageAssets.notification,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    maxLines: 2,
                    title.toUpperCase(),
                    style: GoogleFonts.quicksand(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    pubDate,
                    style: GoogleFonts.quicksand(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.buttonColor,
                  ),
                ),
              ),
              // Expanded(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         maxLines: 2,
              //         title.toUpperCase(),
              //         style:  GoogleFonts.quicksand(fontWeight: FontWeight.w600),
              //         overflow: TextOverflow.ellipsis,
              //       ),
              //       Text(content),
              //       const SizedBox(
              //         height: 8,
              //       ),
              //       Text(
              //         pubDate,
              //         style: GoogleFonts.quicksand(
              //             fontSize: 12, fontWeight: FontWeight.w400),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
