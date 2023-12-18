import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/utils/constants.dart';
import 'package:mboacare/utils/validator.dart';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

import '../model/user_model.dart';
import 'user_data.dart';

class UserDataProvider with ChangeNotifier {
  UserDataProvider() {
    fetchAndUpdateUserData();
  }

  UserModel _currentUser = UserModel(
    uid: '',
    displayName: '',
    email: '',
    phoneNumber: '',
    emailVerified: false,
    photoURL: '',
  );

  String baseURL =
      'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/auth';
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  //Visibility flags for each password form field
  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool get isCurrentPasswordVisible => _isCurrentPasswordVisible;
  bool get isNewPasswordVisible => _isNewPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  void toggleCurrentPasswordVisibility() {
    _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _isNewPasswordVisible = !_isNewPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  UserModel get currentUser => _currentUser;

  set currentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  Uint8List? memoryImage;
  bool _savingImage = false;
  bool sendingResetEmail = false;

  Uint8List? get image => memoryImage;
  bool get savingImage => _savingImage;
  bool savingData = false;

  Future<void> updateProfilePic(BuildContext context) async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    final imageFile = File(img!.path);

    _savingImage = true;
    notifyListeners();
    memoryImage = imageFile.readAsBytesSync();
    notifyListeners();

    String? profilePicURL =
        await uploadUserProfilePicToFirestorage(currentUserID, imageFile);
    if (!context.mounted) return;
    await updateUserProfilePic(context, currentUser.uid, profilePicURL!);
    _savingImage = false;
    notifyListeners();
  }

  void saveNewPassword(BuildContext context, String currentPassword,
      String newPassword, String confirmNewPassword) async {
    if (UserInfoValidator.validatePassword(newPassword)) {
      if (newPassword != confirmNewPassword) {
        showSnackbar(context, 'Passwords don\'t match');
      } else {
        savingData = true;
        notifyListeners();
        bool result = await checkIfUserPasswordIsCorrect();
        if (result) {
          if (!context.mounted) return;
          await updateUserPassword(context, newPassword);
          savingData = false;
          notifyListeners();
          if (!context.mounted) return;
          Navigator.of(context).pop();
        } else {
          savingData = false;
          notifyListeners();
          if (!context.mounted) return;
          showSnackbar(context, 'Wrong current password');
        }
      }
    } else {
      savingData = false;
      notifyListeners();
      showSnackbar(context, 'Weak password');
    }
  }

  Future<void> updateUserDisplayName(
      BuildContext context, String newDisplayName) async {
    savingData = true;
    notifyListeners();
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('PUT', Uri.parse('$baseURL/update-profile'));
    request.body = json.encode({
      "uid": currentUser.uid,
      "displayName": newDisplayName,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      currentUser = currentUser.copyWith(displayName: newDisplayName);
      if (!context.mounted) return;
      savingData = false;
      notifyListeners();
      showSnackbar(context, 'Name updated successfully');
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      savingData = false;
      notifyListeners();
    }
  }

  Future<void> updateUserPassword(
      BuildContext context, String newPassword) async {
    savingData = true;
    notifyListeners();
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('PUT', Uri.parse('$baseURL/change-password'));
    request.body = json.encode({
      "uid": currentUser.uid,
      "email": currentUser.email,
      "new_password": newPassword
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      if (!context.mounted) return;
      savingData = false;
      notifyListeners();
      showSnackbar(context, 'Password updated successfully');
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      savingData = false;
      notifyListeners();
      if (!context.mounted) return;
      showSnackbar(context, 'Password update failed');
    }
  }

  Future<void> updateUserPhoneNumber(
      BuildContext context, String newPhoneNumber) async {
    savingData = true;
    notifyListeners();
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('PUT', Uri.parse('$baseURL/update-profile'));
    request.body = json.encode({
      "uid": currentUser.uid,
      "phoneNumber": newPhoneNumber,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      currentUser = currentUser.copyWith(phoneNumber: newPhoneNumber);
      if (!context.mounted) return;
      savingData = false;
      notifyListeners();
      showSnackbar(context, 'Phone number updated successfully');
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      savingData = false;
      notifyListeners();
    }
  }

// !This needs more security safeguards
  Future<void> updateUserEmail(BuildContext context, String newEmail) async {
    savingData = true;
    notifyListeners();
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('PUT', Uri.parse('$baseURL/update-profile'));
    request.body = json.encode({
      "uid": currentUser.uid,
      "email": newEmail,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      currentUser = currentUser.copyWith(email: newEmail);
      if (!context.mounted) return;
      savingData = false;
      notifyListeners();
      showSnackbar(context, 'Email updated successfully');
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
        savingData = false;
        notifyListeners();
      }
    }
  }

  Future<void> updateUserProfilePic(
      BuildContext context, String userID, String picURL) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('PUT', Uri.parse('$baseURL/update-profile'));
    request.body = json.encode({
      "uid": userID,
      "photoURL": picURL,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      if (!context.mounted) return;
      showSnackbar(context, 'Profile picture updated successfully');
    } else {
      if (!context.mounted) return;
      showSnackbar(context, 'Failed to update profile picture');
    }
  }

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    sendingResetEmail = true;
    notifyListeners();
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('$baseURL/reset-password'));
    request.body = json.encode({"email": currentUser.email});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      if (!context.mounted) return;
      sendingResetEmail = false;
      notifyListeners();
      showSnackbar(context, 'Check your email for a password reset link');
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      if (!context.mounted) return;
      sendingResetEmail = false;
      notifyListeners();
      showSnackbar(context, 'Password reset failed, try again later');
    }
  }

  Future<String?> uploadUserProfilePicToFirestorage(
      String cUserID, File photoFile) async {
    String? downloadURL;

    // Create a reference to the photo in Firebase Storage
    Reference photoRef =
        FirebaseStorage.instance.ref().child('profilePictures').child(cUserID);

    // Upload the photo to Firebase Storage
    UploadTask uploadTask = photoRef.putFile(photoFile);

    // Wait for the upload to complete
    TaskSnapshot taskSnapshot = await uploadTask;

    // Get the download URL for the photo
    downloadURL = await taskSnapshot.ref.getDownloadURL();

    return downloadURL;
  }

  Future<void> fetchAndUpdateUserData() async {
    try {
      await getUserInfo();
      UserModel? user = await getUserInfo();
      if (user != null) {
        currentUser = user;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching and updating user data: $e');
      }
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 15, color: AppColors.whiteColor),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: AppColors.primaryColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
