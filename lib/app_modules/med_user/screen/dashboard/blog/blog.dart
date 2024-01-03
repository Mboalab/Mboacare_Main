import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/app_modules/user/screens/inner_screen/blog_details.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/services/appService.dart';
import 'package:mboacare/widgets/blog_card.dart';
import 'dart:developer' as devtools show log;
import '../../../../../model/blog_data.dart';
import 'add_blog_page.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          const SizedBox(height: 18.0),
          _buildSearchBar(context),
          const SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: _buildBlogList(),
          ),
          const SizedBox(
            height: 10.0,
          ),
          _buildCategories(context),
          Expanded(
            child: Scaffold(
              body: FutureBuilder<List<BlogItem>>(
                  future: ApiServices().fetchBlogData(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: SpinKitWaveSpinner(
                          size: 45.0,
                          color: AppColors.buttonColor,
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
                      return Center(
                        child: Text(
                          'No Internet Connection!',
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                          ),
                        ),
                      );
                    }
                    final data = snapshot.data;
                    return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        itemCount: data?.length,
                        itemBuilder: (context, index) {
                          final blog = data![index];
                          if (blog.isApproved == false) {
                          } else if (blog.isApproved == true) {
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
                              title: toTitleCase(blog.title),
                              author: blog.author,
                              date: blog.date,
                            );
                          }
                        });
                  })),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildSearchBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
          flex: 85,
          child: _buildSearchTextField(),
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

Widget _buildSearchTextField() {
  return TextField(
    onTap: () {},
    onChanged: (value) {},
    decoration: InputDecoration(
      labelText: 'Search blogs',
      labelStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Color(0XFFecfded),
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: 2.0,
        ),
      ),
      suffixIcon: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.search,
          color: AppColors.primaryColor,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 12.0,
      ),
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

Widget _buildBlogList() {
  return Scaffold(
    body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ListView(
          children: [
            TopBlogCard(
              imagePath: ImageAssets.topBlog,
              topStackCardText: 'Wellbeing tips',
              blogTitle: 'dirt morning desk ate scene fed harbor',
              authorName: 'Lula Steele',
              blogTime: '10/15/2047',
              authorImage: ImageAssets.logo,
            ),
          ],
        )),
  );
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: 130.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
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
                BottomCard(
                  blogTitle: capitalizedTitle,
                  authorName: authorName,
                  blogTime: blogTime,
                  authorImage: authorImage,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BottomCard extends StatelessWidget {
  final String blogTitle;
  final String authorName;
  final String blogTime;
  final String authorImage;

  const BottomCard({
    super.key,
    required this.blogTitle,
    required this.authorName,
    required this.blogTime,
    required this.authorImage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
          color: Color(0XFFF5F5F5),
        ),
        height: 115.0,
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
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        blogTime,
                        style: AppTextStyles.bodyOne
                            .copyWith(color: AppColors.dividerColor),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRoundedCardOnImageStack extends StatelessWidget {
  final String text;
  final double? topPadding;
  final Color? cardColor;
  final Color? textColor;
  final double? elevation;

  const CustomRoundedCardOnImageStack({
    super.key,
    required this.text,
    this.topPadding,
    this.cardColor,
    this.textColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 0.0),
      child: Card(
        elevation: elevation ?? 1.0,
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, bottom: 7.0, top: 7.0),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
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
