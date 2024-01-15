import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/blog/edit_blog.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/settings.dart';

import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/model/blog_data.dart';
import 'package:mboacare/services/appService.dart';
import 'package:mboacare/widgets/manage_card.dart';

import 'add_blog_page.dart';

class MyBlog extends StatefulWidget {
  const MyBlog({super.key});

  @override
  State<MyBlog> createState() => _MyBlogState();
}

class _MyBlogState extends State<MyBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        titleSpacing: 0.0,
        title: Text(
          'Manage Blogs',
          style: GoogleFonts.inter(
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const Settings(),
                duration: const Duration(
                  milliseconds: 800,
                ),
                curve: Curves.easeInCirc,
                transition: Transition.fadeIn);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 25.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Get.to(() => const AddBlogPage());
        },
        tooltip: 'Add blog article',
        child: const Icon(
          Icons.add,
          size: 40.0,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<List<BlogItem>>(
          future: ApiServices().myBlogData(context: context),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitCircle(
                      color: AppColors.cardbg,
                    ),
                    Text(
                      'Loading My Blog....',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No Blog Available!',
                  style: GoogleFonts.quicksand(
                    fontSize: 14,
                  ),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.none) {
              return Text(
                'No Internet Connection!',
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                ),
              );
            }
            final data = snapshot.data;
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: false,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  final blog = data![index];

                  return ManageCard(
                    onCardTap: () {},
                    imagePath: blog.imageUrl,
                    blogTitle: blog.blogTitle,
                    blogTime: blog.date,
                    onPressedStackCardButton: () {
                      Get.to(
                          () => EditBlog(
                                id: blog.blogId,
                                author: blog.author,
                                catergory: blog.category,
                                title: blog.blogTitle,
                                weblink: blog.blogWebLink,
                                image: blog.imageUrl,
                              ),
                          duration: const Duration(
                            milliseconds: 800,
                          ),
                          curve: Curves.easeIn,
                          transition: Transition.fade);
                    },
                  );
                });
          })),

      // ListView(
      //   padding: EdgeInsets.symmetric(horizontal: 10.0),
      //   children: [
      //     ManageCard(
      //       onCardTap: () {},
      //       imagePath: ImageAssets.topBlog,
      //       blogTitle: 'Design',
      //       blogTime: '2:00PM',
      //     )
      //   ],
      // ),
    );
  }
}
