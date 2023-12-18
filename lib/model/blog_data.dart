import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as devtools show log;

class BlogItem {
  final String imageUrl;
  final String category;
  final String title;
  final String author;
  final String date;

  BlogItem({
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.author,
    required this.date,
  });

  factory BlogItem.fromJson(Map<String, dynamic> json) {
    return BlogItem(
      imageUrl: json['blogImage'],
      category: json['blogCat'][0],
      title: json['blogTitle'],
      author: json['blogAuthor'],
      date: json['blogPubDate'],
    );
  }
}

Future<List<BlogItem>> fetchBlogData() async {
  final response = await http.get(Uri.parse(
      'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/blog/all-blogs'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = json.decode(response.body);

    if (responseBody.containsKey('data')) {
      final List<dynamic> data = responseBody['data'];
      return data.map((item) => BlogItem.fromJson(item)).toList();
    } else {
      throw Exception('API response does not contain a "data" field.');
    }
  } else {
    throw Exception('Failed to load blog data');
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
