import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:developer' as devtools show log;

class BlogItem {
  final String imageUrl;
  final String category;
  final String title;
  final String author;
  final String date;
  final bool isApproved;
  final String blogTitle;
  final String blogWebLink;
  final String blogId;

  BlogItem({
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.author,
    required this.date,
    required this.isApproved,
    required this.blogTitle,
    required this.blogWebLink,
    required this.blogId,
  });

  factory BlogItem.fromJson(Map<String, dynamic> json) {
    return BlogItem(
      imageUrl: json['blogImage'],
      category: json['blogCat'][0],
      title: json['blogTitle'],
      author: json['blogAuthor'],
      date: json['blogPubDate'],
      isApproved: json['isApprove'],
      blogTitle: json['blogTitle'],
      blogWebLink: json['blogWebLink'],
      blogId: json['id'],
    );
  }
}

class BlogModel {
  String? blogWebLink;
  String? blogImage;
  String? userEmail;
  String? blogPubDate;
  String? id;
  List<String>? blogCat;
  String? blogTitle;
  String? blogAuthor;
  bool? isApprove;

  BlogModel(
      {this.blogWebLink,
      this.blogImage,
      this.userEmail,
      this.id,
      this.blogCat,
      this.blogTitle,
      this.blogAuthor,
      this.blogPubDate,
      this.isApprove});

  BlogModel.fromJson(Map<String, dynamic> json) {
    blogWebLink = json['blogWebLink'];
    blogImage = json['blogImage'];
    userEmail = json['userEmail'];
    id = json['id'];
    blogCat = json['blogCat'][0];
    blogTitle = json['blogTitle'];
    blogAuthor = json['blogAuthor'];
    blogPubDate = json['blogPubDate'].toString();
    isApprove = json['isApprove'];
  }
}
//  TODO: Fix the design of the add_blog_page so it can accomodate the API.  blogContent is a required field.

Future<void> addBlog(
  String title,
  String category,
  String webLink,
  File? image,
) async {
  final url = Uri.parse(
      'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/blog/add-blog');

  final request = http.MultipartRequest('POST', url);

  request.fields['blogTitle'] = title;
  request.fields['blogCat'] = category;
  request.fields['blogWebLink'] = webLink;

  if (image != null) {
    request.files
        .add(await http.MultipartFile.fromPath('blogImage', image.path));
  }

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      devtools.log('Blog added successfully');
    } else {
      final errorMessage =
          'Failed to add blog. Status Code: ${response.statusCode}';
      devtools.log(errorMessage);
    }
  } catch (e) {
    final errorMessage = 'Error adding blog: $e';
    devtools.log(errorMessage);
  }
}
