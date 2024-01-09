import 'package:http/http.dart' as http;
import 'package:mboacare/model/hospital_model/hospital_model.dart';
import 'package:mboacare/model/search_hospital_model.dart';
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

    final response = await http.get(Uri.parse(url), headers: headers);

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
    } catch (e) {}
    return [];
  }

  Future<List<HospitalModel>> fetchAllHospitals() async {
    final apiUrl = Uri.parse(Apis.allHospitals);

    final response = await http.get(apiUrl, headers: {
      'Content-Type': 'application/json; charset=utf-8',
    });

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('data')) {
          final List<dynamic> data = responseData['data'];
          // ignore: avoid_print
          print(data);

          return data.map((item) => HospitalModel.fromJson(item)).toList();
        } else {
          throw Exception('API response does not contain a "data" field.');
        }
      } else {
        throw Exception('Failed to load blog data');
      }
    } catch (e) {}
    return [];
  }

  Future<List<SearchHospitalModel>> searchHospital() async {
    final apiUrl = Uri.parse(Apis.searchHospitals);

    final response = await http.get(apiUrl, headers: {
      'Content-Type': 'application/json; charset=utf-8',
    });

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('data')) {
          final List<dynamic> data = responseData['data'];
          // print(responseData);
          return data
              .map((item) => SearchHospitalModel.fromJson(item))
              .toList();
        } else {
          throw Exception('Api response does not contain a "data" field');
        }
      } else {
        throw Exception('Failed to load SearchHospital data');
      }
    } catch (e) {}
    return [];
  }
}
