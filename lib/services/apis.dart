import 'package:flutter/material.dart';

class Apis {
  /*----------------------------------Map Key--------------------------------------------------- */

  /*----------------------------------Base URL--------------------------------------------------- */
  static const String baseUrl =
      "https://us-central1-mboacare-api-v1.cloudfunctions.net/api";
  static const String logoUrl =
      'https://drive.google.com/drive/u/3/folders/159jj3T0pfMzCQsfMf-WtX9oMiefDf-gp';
  static const String linkIn = 'https://www.linkedin.com/company/mboalab/';

  /*----------------------------------Auth endpoints--------------------------------------------------- */

  static const String register = "$baseUrl/auth/register";
  static const String login = "$baseUrl/auth/sign-in";
  static const String updateProfile = "$baseUrl/auth/update-profile";
  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String changePassword = "$baseUrl/auth/change-password";
  static const String verificationLink = "$baseUrl/auth/send-link";

/*----------------------------------blog endpoints--------------------------------------------------- */
  static const String allBlog = "$baseUrl/blog/all-blogs";
  static const String addBlog = "$baseUrl/blog/add-blog";
  static const String myBlog = "$baseUrl/blog/my-blogs?q=";
  static const String updateBlog = "$baseUrl/blog/update-blog";
  static const String deleteBlog = "$baseUrl/blog/delete-blog/";

/*----------------------------------notification endpoints--------------------------------------------------- */
  static const String allNotification =
      "$baseUrl/notification/all-notifications";

  static const String deleteNotification =
      "$baseUrl/notification/delete-notification/";

  // --------------------------Hospital endpoints--------------------------ng
  static const allHospitals = '$baseUrl/hospital/all-hospital';
  static const addHospital = '$baseUrl/hospital/add-hospital';
  static const updateHospital = '$baseUrl/hospital/update-hospital';
  static const searchHospitals = '$baseUrl/hospital/search';
  static const deleteHospital = '$baseUrl/hospital/delete-hospital/';
  static const myHospitals = '$baseUrl/hospital/my-hospitals?q=';
}

String mapKey = 'AIzaSyBkuwcKikuNtM-07vxwHHHl9M-icIBst5w';
