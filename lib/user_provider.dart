import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboacare/utils/constants.dart';
import 'package:mboacare/utils/validator.dart';

import 'user_model.dart';

class UserDataProvider with ChangeNotifier {
  UserModel _currentUser = UserModel(
      userID: '', firstName: '', lastName: '', email: '', profilePicURL: '');

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

  UserDataProvider(this._currentUser);

  UserModel get currentUser => _currentUser;

  set currentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  Uint8List? memoryImage;
  bool _savingImage = false;

  Uint8List? get image => memoryImage;
  bool get savingImage => _savingImage;
  bool savingData = false;

  void updateUserProfile(UserModel userModel) {
    currentUser = userModel;
  }

  void updateUsername(String newFirstName) {
    _currentUser = _currentUser.copyWith(
        firstName: newFirstName, lastName: '', userID: '', email: '');
    notifyListeners();
  }

  Future<void> updateProfilePic() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    final imageFile = File(img!.path);

    _savingImage = true;
    notifyListeners();
    memoryImage = imageFile.readAsBytesSync();
    notifyListeners();

    // String? profilePicURL =
    //     await uploadUserProfilePicToFirestorage(currentUserID, imageFile);

    _savingImage = false;
    notifyListeners();
  }

  void showEditDialog(BuildContext context, String hint, String item) {
    String textFieldValue = '';
    String errorText = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      textFieldValue = value;
                    },
                    decoration: InputDecoration(hintText: hint),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    errorText,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: !savingData
                    ? Text(
                        'SAVE',
                        style: dialogActionButtonTextStyle(),
                      )
                    : Text('SAVING...', style: dialogActionButtonTextStyle()),
                onPressed: () async {
                  if (item == 'email') {
                    if (UserInfoValidator.isEmailValid(textFieldValue)) {
                      savingData = true;
                      notifyListeners();
                      //await updateUserEmail(currentUserID, textFieldValue);
                      updateUserProfile(currentUser);
                      savingData = false;
                      setState(() {
                        errorText = ''; // Clear error message.
                      });
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        errorText = 'Invalid email format'; // Set error message
                      });
                    }
                  } else if (item == 'firstname' && textFieldValue != '') {
                    savingData = true;
                    //await updateUserFirstName(currentUserID, textFieldValue);
                    updateUserProfile(currentUser);
                    savingData = false;
                    Navigator.of(context).pop();
                  } else if (item == 'lastname' && textFieldValue != '') {
                    savingData = true;
                    //await updateUserLastName(currentUserID, textFieldValue);
                    updateUserProfile(currentUser);
                    savingData = false;
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
      },
    );
  }

  void saveNewPassword(BuildContext context, String currentPassword,
      String newPassword, String confirmNewPassword) {
    if (UserInfoValidator.validatePassword(newPassword)) {
      if (newPassword != confirmNewPassword) {
      } else {
        savingData = true;
        notifyListeners();
        // await changeUserPassword(currentUserID, currentPassword, newPassword);
        savingData = false;
        notifyListeners();
        Navigator.of(context).pop();
      }
    } else {}
  }
}
