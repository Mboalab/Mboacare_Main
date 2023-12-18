import 'dart:convert';
import 'package:http/http.dart' as http;

class Notify {
  final String content;
  final String title;
  final String pubDate;

 Notify({
    required this.content,
    required this.title,
    required this.pubDate,
  });

  factory Notify.fromJson(Map<String, dynamic> json) {
    return Notify(

      content: json['content'][0],
      title: json['title'],
      pubDate: json['pubDate'],
    );
  }
}
Future<List<Notify>> fetchNotifications() async {
  final response = await http.get(Uri.parse(
      'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/notification/all-notifications'));

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
}