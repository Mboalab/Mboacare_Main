import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/blog_data.dart';
import '../model/notification_data.dart';
import 'apis.dart';

class ApiServices {
  Future<List<BlogItem>> fetchBlogData() async {
    String url = Apis.allBlog;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    try {
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
    } catch (e) {}
    return [];
  }

  Future<List<Notify>> fetchNotifications() async {
 String url = Apis.allNotification;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
    };


  final response = await http.get(Uri.parse(
      url), headers: headers);

try {
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = json.decode(response.body);

    if (responseBody.containsKey('data')) {
      final List<dynamic> data = responseBody['data'];
      return data.map((item) => Notify.fromJson(item)).toList();
    } else {
      throw Exception('API response does not contain a "data" field.');
    }
  } else {
    throw Exception('Failed to load blog data');
  }
} catch (e) {
  
}
  return [];
}
}
