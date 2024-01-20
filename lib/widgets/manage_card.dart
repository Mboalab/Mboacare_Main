import 'package:flutter/material.dart';

import '../app_modules/user/screens/dashboard/blog_page.dart';
import '../global/styles/appStyles.dart';
import '../global/styles/colors.dart';

class ManageCard extends StatelessWidget {
  final Function()? onCardTap;
  final String imagePath;

  final String blogTime;

  final String? stackCardButtonText;
  final Function()? onPressedStackCardButton;
  final String blogTitle;

  const ManageCard({
    super.key,
    this.onCardTap,
    required this.imagePath,
    this.stackCardButtonText,
    this.onPressedStackCardButton,
    required this.blogTitle,
    required this.blogTime,
  });

  @override
  Widget build(BuildContext context) {
    final capitalizedTitle = toTitleCase(blogTitle);
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onCardTap,
      child: Card(
        elevation: 0.5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 150.0,
                  width: width * 0.92,
                  decoration: BoxDecoration(
                    color: AppColors.navbar,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                    image: DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    ),
                    color: Color(0XFFF5F5F5),
                  ),
                  height: 100.0,
                  width: width * 0.92,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blogTitle,
                          style: AppTextStyles.bodyOne.copyWith(
                              color: AppColors.primaryColor,
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              blogTime,
                              style: AppTextStyles.bodyOne.copyWith(
                                  color: AppColors.grey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: onPressedStackCardButton,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 8),
                                decoration: const BoxDecoration(
                                  color: AppColors.cardbg,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  'Edit',
                                  style: AppTextStyles.bodyOne.copyWith(
                                      color: AppColors.whiteColor,
                                      fontSize: 14.0),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
