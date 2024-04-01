import 'package:flutter/material.dart';
import 'package:mboacare/global/styles/appStyles.dart';

import 'package:mboacare/widgets/image_stack.dart';

import '../app_modules/user/screens/dashboard/blog_page.dart';
import '../global/styles/colors.dart';

class TopBlogCard extends StatelessWidget {
  final Function()? onCardTap;
  final String imagePath;
  final String topStackCardText;
  final String blogTime;
  final String authorImage;
  final String? stackCardButtonText;
  final Function()? onPressedStackCardButton;
  final String blogTitle;
  final String authorName;

  const TopBlogCard({
    super.key,
    this.onCardTap,
    required this.imagePath,
    required this.topStackCardText,
    this.stackCardButtonText,
    this.onPressedStackCardButton,
    required this.blogTitle,
    required this.authorName,
    required this.blogTime,
    required this.authorImage,
  });

  @override
  Widget build(BuildContext context) {
    final capitalizedTitle = toTitleCase(blogTitle);
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onCardTap,
      child: Card(
        margin: EdgeInsets.only(right: 10.0),
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
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    // color: AppColors.navbar,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                    image: DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                CustomRoundedCardOnImageStack(
                    textColor: AppColors.whiteColor,
                    cardColor: Colors.grey.withOpacity(0.0),
                    text: topStackCardText,
                    topPadding: 5.0),
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
                    //  color: Color(0XFFF5F5F5),
                  ),
                  height: 115.0,
                  width: width * 0.8,
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
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0XFFF5F5F5),
                              backgroundImage: AssetImage(authorImage),
                              radius: 20.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  authorName,
                                  style: AppTextStyles.bodyOne.copyWith(
                                      //   color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  blogTime,
                                  style: AppTextStyles.bodyOne.copyWith(
                                      color: Colors.grey, fontSize: 12.0),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
