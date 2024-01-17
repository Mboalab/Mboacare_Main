import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/app_modules/user/screens/inner_screen/blog_details.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/services/appService.dart';
import 'package:mboacare/widgets/blog_card.dart';
import 'package:mboacare/widgets/search_widget.dart';
import 'package:mboacare/widgets/shimmer_top.dart';
import 'package:mboacare/widgets/top_card.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../global/styles/colors.dart';
import 'dart:developer' as devtools show log;
import '../../../../model/blog_data.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/shimmer_effect.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     ApiServices().fetchBlogData();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        // physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18.0),
            SearchWidget(),
            const SizedBox(
              height: 8.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              textAlign: TextAlign.left,
              'Top Blog',
              style: GoogleFonts.montserrat(
                color: AppColors.buttonColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: height * 0.33,
              // width: width * 0.2,
              child: FutureBuilder<List<BlogItem>>(
                  future: ApiServices().fetchBlogData(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return ShimmerTop();
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ShimmerTop();
                    }
                    final data = snapshot.data;
                    return ListView.builder(
                        //physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        //shrinkWrap: true,
                        itemCount: data?.length,
                        itemBuilder: (context, index) {
                          final blog = data![index];

                          return TopBlogCard(
                            onCardTap: () {
                              Get.to(
                                  () => BlogDetails(
                                      url: blog.blogWebLink,
                                      title: blog.blogTitle.toString()),
                                  duration: const Duration(
                                    milliseconds: 800,
                                  ),
                                  curve: Curves.easeInCirc,
                                  transition: Transition.fadeIn);
                            },
                            imagePath: blog.imageUrl,
                            topStackCardText: blog.category,
                            blogTitle: blog.blogTitle,
                            authorName: blog.author,
                            blogTime: blog.date,
                            authorImage: ImageAssets.logo,
                          );
                        });
                  })),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              textAlign: TextAlign.left,
              'All Blog',
              style: GoogleFonts.montserrat(
                color: AppColors.buttonColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            SizedBox(
              child: FutureBuilder<List<BlogItem>>(
                  future: ApiServices().fetchBlogData(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      const SizedBox(
                        height: 10.0,
                      );
                      return Column(
                        children: [
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) =>
                                const ShimmerCard(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: defaultPadding),
                          ),
                        ],
                      );
                    }

                    if (snapshot.data!.isEmpty) {
                      return Text(
                        'No Blog Available!',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) =>
                                const ShimmerCard(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: defaultPadding),
                          ),
                        ],
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
                    return SizedBox(
                      height: height * 0.5,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: false,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: data?.length,
                          itemBuilder: (context, index) {
                            final blog = data![index];

                            return BottomBlogCard(
                              tap: () {
                                Get.to(
                                    () => BlogDetails(
                                        url: blog.blogWebLink,
                                        title: blog.blogTitle.toString()),
                                    duration: const Duration(
                                      milliseconds: 800,
                                    ),
                                    curve: Curves.easeInCirc,
                                    transition: Transition.fadeIn);
                              },
                              imageUrl: blog.imageUrl,
                              category: blog.category,
                              title: toTitleCase(blog.blogTitle.toString()),
                              author: blog.author.toString(),
                              date: blog.date.toString(),
                            );
                          }),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildSearchBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        const Expanded(
          flex: 85,
          child: SearchWidget(),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          flex: 15,
          child: _buildFilterButton(context),
        )
      ],
    ),
  );
}

GlobalKey<PopupMenuButtonState<String>> filterPopupMenuButtonKey =
    GlobalKey<PopupMenuButtonState<String>>();

Widget _buildFilterButton(BuildContext context) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      _buildFilterButtonIcon(),
      _buildFilterPopupMenuButton(context),
    ],
  );
}

Widget _buildFilterButtonIcon() {
  return Container(
    height: 40.0,
    width: 40.0,
    decoration: BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: const IconButton(
      onPressed: _showFilterMenu,
      icon: Icon(
        Icons.filter_list_alt,
        color: Colors.white,
        size: 25.0,
      ),
    ),
  );
}

void _showFilterMenu() {
  filterPopupMenuButtonKey.currentState!.showButtonMenu();
}

Widget _buildFilterPopupMenuButton(BuildContext context) {
  return PopupMenuButton<String>(
    key: filterPopupMenuButtonKey,
    icon: Container(), // Hide the triple-dot icon
    onSelected: _onFilterMenuItemSelected,
    itemBuilder: (BuildContext context) {
      return <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'custom',
          child: _buildFilterMenuContent(context),
        ),
      ];
    },
  );
}

void _onFilterMenuItemSelected(String value) {
  devtools.log('Selected: $value');
}

Widget _buildFilterMenuContent(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ListTile(
        title: const Text(
          'Sort by',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      const Divider(),
      _buildFilterMenuItem('newest', 'Newest', Icons.access_time),
      _buildFilterMenuItem('author', 'Author', Icons.person),
      _buildFilterMenuItem('category', 'Category', Icons.category),
    ],
  );
}

Widget _buildFilterMenuItem(String value, String label, IconData icon) {
  return Container(
      padding: const EdgeInsets.all(0),
      child: PopupMenuItem<String>(
        value: value,
        child: ListTile(
          leading: Icon(icon),
          title: Text(label),
        ),
      ));
}

Widget _buildCategories(BuildContext context) {
  return Container(
    color: const Color(0XFFfbf9f9),
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          Categories(
            categoryTitle: "All",
            isSelected: true,
          ),
          Categories(
            categoryTitle: "Wellness",
            isSelected: false,
          ),
          Categories(
            categoryTitle: "Mental Health",
            isSelected: false,
          ),
          Categories(
            categoryTitle: "Lifestyle",
            isSelected: false,
          ),
        ],
      ),
    ),
  );
}

class Categories extends StatelessWidget {
  final String categoryTitle;
  final bool isSelected;

  const Categories({
    super.key,
    required this.categoryTitle,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          categoryTitle,
          style: AppTextStyles.bodyOne.copyWith(
              fontSize: 16.0,
              color: isSelected ? AppColors.primaryColor : Colors.black,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

String toTitleCase(String text) {
  final words = text.split(' ');
  final capitalizedWords = words.map((word) {
    if (word.isNotEmpty) {
      return word[0].toUpperCase() + word.substring(1);
    } else {
      return word;
    }
  });
  return capitalizedWords.join(' ');
}
