import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mboacare/appStyles.dart';
import 'package:mboacare/blog/add_blog_page.dart';
import '../colors.dart';
import 'dart:developer' as devtools show log;
import '../notifications/notifications.dart';
import 'blog_data.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List<BlogItem> blogItems = [];

  void _navigateToAddBlogPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddBlogPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchBlogData();
  }

  Future<void> _fetchBlogData() async {
    List<BlogItem> data = await fetchBlogData();
    setState(() {
      blogItems = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          _navigateToAddBlogPage();
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
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    itemCount: blogItems.length,
                    itemBuilder: (context, index) {
                      return BottomBlogCard(
                        imageUrl: blogItems[index].imageUrl,
                        category: blogItems[index].category,
                        title: toTitleCase(blogItems[index].title),
                        author: blogItems[index].author,
                        date: blogItems[index].date,
                      );
                    },
                  )),
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
          children: const [
            TopBlogCard(
              imagePath: 'lib/assests/images/apollo.jpg',
              topStackCardText: 'Wellbeing tips',
              blogTitle: 'dirt morning desk ate scene fed harbor',
              authorName: 'Lula Steele',
              blogTime: '10/15/2047',
              authorImage: 'lib/assests/images/logo.png',
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

class BottomBlogCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String title;
  final String author;
  final String date;
  const BottomBlogCard({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.author,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0XFFF5F5F5),
      elevation: 0.5,
      child: SizedBox(
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              flex: 30,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Image.network(
                  imageUrl,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 70,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      maxLines: 2,
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(author,
                            style: const TextStyle(color: Colors.grey)),
                        Text(date, style: const TextStyle(color: Colors.grey))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
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
