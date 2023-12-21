// import 'dart:developer';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:mboacare/global/styles/colors.dart';
// import 'package:mboacare/model/placemodel/facilities_model.dart';
// import 'package:mboacare/model/placemodel/geometry_model.dart';
// import 'package:mboacare/model/placemodel/place_model.dart';
// import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/facilities_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

// class FacilitiesProvider with ChangeNotifier {
//   // List<FacilitiesModel> _facilities = [];

//   // List<FacilitiesModel> get facilities => _facilities;
//   // List<PlaceModel> _place = [];

//   // List<PlaceModel> get place => _place;
//   // List<GeometryModel> _geometry = [];

//   // List<GeometryModel> get geometry => _geometry;
//   // final Dio _dio = Dio();

//   // Future<void> getFacilities() async {
//   //   final response = await _dio.get(
//   //       'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/hospital/all-hospital');
//   //   if (response.statusCode == 200) {
//   //     final List<dynamic> data = response.data;
//   //     _facilities = data.map((json) => FacilitiesModel.fromJson(json)).toList();

//   //     notifyListeners();
//   //   } else {
//   //     throw Exception('Failed to load data');
//   //   }
//   // }

//   Future<void> addFacilities(
//       {required String name,
//       required String email,
//       required String website,
//       required String phoneno,
//       required String latitude,
//       required String longitude,
//       required List<String> serviceType,
//       required List<String> facilitiesType,
//       required String hospitalType,
//       required String hospitalOwner,
//       required String hospitalSize,
//       required File hospitalImage,
//       required BuildContext context,
//       required String hospitalAddress}) async {
//     final body = {
//       'userEmail': 'mercyjae20@gmail.com',
//       'name': name,
//       'phoneNumber': phoneno,
//       'email': email,
//       'website': website,
//       'latitude': latitude,
//       'longitude': longitude,
//       'serviceType': serviceType,
//       'facilitiesType': facilitiesType,
//       'hospitalType': hospitalType,
//       'hospitalOwner': hospitalOwner,
//       'hospitalSize': hospitalSize,
//       'placeAddress': hospitalAddress,
//       'hospitalImage': hospitalImage == null
//           ? null
//           : await MultipartFile.fromFile(
//               hospitalImage.path,
//               filename: hospitalImage.path.split('/').last,
//               contentType: MediaType(
//                 'hospitalImage',
//                 hospitalImage.path.split('/').last.split('.').last,
//               ),
//             ),
//     };
//     try {
//       final response = await _dio.post(
//         'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/hospital/add-hospital',
//         data: FormData.fromMap(body),
//         options: Options(contentType: 'multipart/form-data'),
//       );
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text('Hospital added successfully'),
//               backgroundColor: AppColors.buttonColor),
//         );
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => const FacilitiesPage()));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text('Error occured'), backgroundColor: Colors.red),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Error occured'), backgroundColor: Colors.red),
//       );
//     }
//   }

//   Future<void> editFacilities(
//       {required String name,
//       required String hospitalAddress,
//       required String email,
//       required String website,
//       required String phoneno,
//       required String latitude,
//       required String longitude,
//       required List<String> serviceType,
//       required List<String> facilitiesType,
//       required String hospitalType,
//       required String hospitalOwner,
//       required String hospitalSize,
//       required File hospitalImage,
//       required BuildContext context}) async {
//     final body = {
//       'userEmail': 'mercyjae20@gmail.com',
//       'name': name,
//       'phoneNumber': phoneno,
//       'email': email,
//       'website': website,
//       'latitude': latitude,
//       'longitude': longitude,
//       'serviceType': serviceType,
//       'facilitiesType': facilitiesType,
//       'hospitalType': hospitalType,
//       'hospitalOwner': hospitalOwner,
//       'placeAddress': hospitalAddress,
//       'hospitalSize': hospitalSize,
//       'hospitalImage': hospitalImage == null
//           ? null
//           : await MultipartFile.fromFile(
//               hospitalImage.path,
//               filename: hospitalImage.path.split('/').last,
//               contentType: MediaType(
//                 'hospitalImage',
//                 hospitalImage.path.split('/').last.split('.').last,
//               ),
//             ),
//     };
//     try {
//       final response = await _dio.patch(
//           'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/hospital/update-hospital',
//           data: FormData.fromMap(body),
//           options: Options(headers: {
//             'Authorization': 'Bearer ${''}',
//           }, contentType: 'multipart/form-data'));
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Hospital updated successfully'),
//             backgroundColor: AppColors.buttonColor,
//           ),
//         );
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => const FacilitiesPage()));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text('Error occured'), backgroundColor: Colors.red),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Error occured'), backgroundColor: Colors.red),
//       );
//     }
//   }

//   Future<void> deleteFacilities({required String website,
//   required BuildContext context}) async {
//     try {
//       final response = await _dio.delete(
//         'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/hospital/delete-hospital/$website',
//       );

//       if (response.statusCode == 200) {
//         log(response.data);
//            ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Hospital updated successfully'),
//             backgroundColor: AppColors.buttonColor,
//           ),
//         );
//       } else {
//          ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Error occured'), backgroundColor: Colors.red),
//       );
//       }
//     } catch (e) {
//        ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Error occured'), backgroundColor: Colors.red),
//       );
//     }
//   }

//   Future<void> getPlace({required String query}) async {
//     const Uuid uuid = Uuid();
//     final sessionToken = uuid.v4();
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('sessiontoken', sessionToken);
//     try {
//       final response = await _dio.get(
//           'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=AIzaSyBbi0oN09TuCD9-YAGL9SfP1KPv4BUZFbg&sessiontoken=$sessionToken');

//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data['predictions'];
//         _place = data.map((location) => PlaceModel.fromJson(location)).toList();
//         print(_place);

//         notifyListeners();
//       } else {
//         throw Exception('Failed to post data');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }

//   Future<void> getGeometry({required String placeId}) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     final sessionToken = prefs.getString(
//       'sessiontoken',
//     );
//     try {
//       final response = await _dio.get(
//           'https://maps.googleapis.com/maps/api/place/autocomplete/json?place_id=$placeId&key=AIzaSyBbi0oN09TuCD9-YAGL9SfP1KPv4BUZFbg&sessiontoken=$sessionToken');

//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data['result'];
//         _geometry =
//             data.map((location) => GeometryModel.fromJson(location)).toList();
//         print(_geometry);
//         notifyListeners();
//       } else {
//         throw Exception('Failed to post data');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// //   Future<void> addBlog(
// //   String title,
// //   String category,
// //   String webLink,
// //   File? image,
// // ) async {
// //   final url = Uri.parse(
// //       'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/hospital/add-hospital');

// //   final request = http.MultipartRequest('POST', url);

// //   request.fields['name'] = title;
// //   request.fields['phoneNumber'] = category;
// //   request.fields['email'] = webLink;
// //   request.fields['userEmail'] =
// //   request.fields['website'] = title;
// //   request.fields['latitude'] = category;
// //   request.fields['blogWebLink'] = webLink;
// //   request.fields['idToken'] =
// //   request.fields['blogTitle'] = title;
// //   request.fields['blogCat'] = category;
// //   request.fields['blogWebLink'] = webLink;
// //   request.fields['idToken'] =

// //   'idToken': userEmail,
// //       'name': name,
// //       'phoneNumber': phoneno,
// //       'email': email,
// //       'website': website,
// //       'latitude': latitude,
// //       'serviceType': serviceType,
// //       'facilitiesType': facilitiesType,
// //       'hospitalType': hospitalType,
// //       'hospitalOwner': hospitalOwner,
// //       'hospitalSize': hospitalSize,
// //       'hospitalImage': hospitalImage

// //   if (image != null) {
// //     request.files
// //         .add(await http.MultipartFile.fromPath('blogImage', image.path));
// //   }

// //   try {
// //     final response = await request.send();

// //     if (response.statusCode == 200) {
// //       devtools.log('Blog added successfully');
// //     } else {
// //       final errorMessage =
// //           'Failed to add blog. Status Code: ${response.statusCode}';
// //       devtools.log(errorMessage);
// //     }
// //   } catch (e) {
// //     final errorMessage = 'Error adding blog: $e';
// //     devtools.log(errorMessage);
// //   }
// }
