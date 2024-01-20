// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'dart:developer' as devtools show log;
import 'package:http/http.dart' as http;
import 'package:mboacare/app_modules/auth/hospital_message/awaitApprovalScreen.dart';
import 'package:mboacare/utils/snack_error.dart';
import 'package:mboacare/utils/snack_succ.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mboacare/services/apis.dart';
import '../../widgets/snackbar.dart';
import '../../app_modules/med_user/screen/dashboard/hospital/add_hopital.dart';

class AddHospitalProvider extends ChangeNotifier {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final hospitalAddressController = TextEditingController();
  final hospitalPhoneNumberController = TextEditingController();
  final hospitalEmailController = TextEditingController();
  final hospitalWebsiteController = TextEditingController();
  final hospitalMedicalController = TextEditingController();
  final hospitalFacilityController = TextEditingController();
  final hospitalTypeController = TextEditingController();
  final hospitalSizeController = TextEditingController();
  final hospitalOwnerShipController = TextEditingController();
  final hospitalNameController = TextEditingController();
  final hospitalServicesController = TextEditingController();
  final hospitalBedCapacityController = TextEditingController();
  final hospitalEmergencyServicesController = TextEditingController();
  String initialCountry = 'CM';
  final number = PhoneNumber(isoCode: 'CM');
  final ImagePicker _imagePicker = ImagePicker();
  File? selectedImage;
  String _reqMessage = "";
  bool _isLoading = false;

  String get reqMessage => _reqMessage;
  bool get isLoading => _isLoading;

  String? hospitalName;
  String? hospitalAddress;
  String? hospitalPhone;
  String? hospitalEmail;
  String? hospitalWebsite;
  String? hospitalType;
  String? hospitalSize;
  String? hospitalOwnership;
  String? hospitalServices;
  String? hospitalFacilities;
  String? hospitalBedCapacity;
  String? hospitalEmergencyServices;
  List<String> medicalServicesChipItems = [];
  List<String> facilitiesAvailableChipItems = [];

  setHospitalName(String value) {
    hospitalName = value;
    notifyListeners();
  }

  setHospitalEmail(String value) {
    hospitalEmail = value;
    notifyListeners();
  }

  void setHospitalPhoneNumber(String value) {
    hospitalPhone = value;
    notifyListeners();
  }

  List<ChecklistItem> checklistMedicalServices = [
    ChecklistItem(title: 'Surgery', isChecked: false),
    ChecklistItem(title: 'Paediatrics', isChecked: false),
    ChecklistItem(title: 'Internal Medicine', isChecked: false),
    ChecklistItem(title: 'Obstetrics & Gynaecology', isChecked: false),
    ChecklistItem(title: 'Cardiology', isChecked: false),
    ChecklistItem(title: 'Oncology', isChecked: false),
    ChecklistItem(title: 'Neurology', isChecked: false),
    ChecklistItem(title: 'Other', isChecked: false),
  ];

  List<ChecklistItem> checklistFacilities = [
    ChecklistItem(title: 'Emergency Room', isChecked: false),
    ChecklistItem(title: 'Laboratory', isChecked: false),
    ChecklistItem(title: 'Radiology', isChecked: false),
    ChecklistItem(title: 'Pharmacy', isChecked: false),
    ChecklistItem(title: 'Intensive Care Unit', isChecked: false),
    ChecklistItem(title: 'Operation Room', isChecked: false),
    ChecklistItem(title: 'Blood Bank', isChecked: false),
    ChecklistItem(title: 'Other', isChecked: false),
  ];

  List<ChecklistItem> checklistHospitalOwners = [
    ChecklistItem(title: 'Individual', isChecked: false),
    ChecklistItem(title: 'Corporate', isChecked: false),
    ChecklistItem(title: 'Government', isChecked: false),
  ];

  List<ChecklistItem> checklistHospitalTypeList = [
    ChecklistItem(title: 'Public', isChecked: false),
    ChecklistItem(title: 'Private', isChecked: false),
    ChecklistItem(title: 'Other', isChecked: false),
  ];

  List<String> hospitalTypeList = ["Public", "Private", "Other"];
  List<String> hospitalSizeList = ["Small", "Medium", "Large"];
  List<String> hospitalSizeOwnershipList = [
    "Individual",
    "Corporate",
    "Government"
  ];

  void setOtherValue(String name, String value) {
    switch (name) {
      case 'hospitalType':
        hospitalType = value;
        break;
      case 'hospitalSize':
        hospitalSize = value;
        break;
      case 'hospitalOwnership':
        hospitalOwnership = value;
        break;
      case 'hospitalBedCapacity':
        hospitalBedCapacity = value;
        break;
      default:
        break;
    }
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImage = File(pickedImage.path);
    }
    notifyListeners();
  }

  void addToMedsChip(String text) {
    debugPrint("AddToMed: $medicalServicesChipItems");

    medicalServicesChipItems.add(text);
    hospitalServices = medicalServicesChipItems.join(', ');
    print(hospitalServices);
    hospitalMedicalController.clear();
    print(text);
    notifyListeners();
  }

  addToFacilitiesChip(String text) {
    debugPrint("AddToFac: $facilitiesAvailableChipItems");
    facilitiesAvailableChipItems.add(text);
    hospitalFacilities = facilitiesAvailableChipItems.join(',');
    print(hospitalFacilities);
    hospitalFacilityController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    hospitalAddressController.dispose();
    hospitalPhoneNumberController.dispose();
    hospitalEmailController.dispose();
    hospitalWebsiteController.dispose();
    hospitalMedicalController.dispose();
    hospitalFacilityController.dispose();
    hospitalTypeController.dispose();
    hospitalSizeController.dispose();
    hospitalOwnerShipController.dispose();
    hospitalNameController.dispose();
    hospitalServicesController.dispose();
    hospitalBedCapacityController.dispose();
    hospitalEmergencyServicesController.dispose();
    super.dispose();
  }

  void addHospital(
      String hospitalName,
      String hospitalWeblink,
      String hospitalEmail,
      String hospitalType,
      String hospitalOwner,
      String hospitalSize,
      String hospitalMedicalServices,
      String hospitalFacilities,
      String hospitalAddress,
      String hospitalLat,
      String hospitalLng,
      String hospitalPhone,
      File? image,
      BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    SharedPreferences pref = await _pref;
    String myEmail = pref.getString('userEmail') ?? '';
    print(myEmail);
    final url = Uri.parse(Apis.addHospital);
    print(url);
    final request = http.MultipartRequest('POST', url);
    
    request.fields['name']= hospitalName;
    request.fields['website']= hospitalWeblink;
    request.fields['email']= hospitalEmail;
    request.fields['placeAddress']=hospitalAddress;
    request.fields['latitude']=hospitalLat;
    request.fields['longitude']=hospitalLng;
     request.fields['phoneNumber']=hospitalPhone;
         request.fields['hospitalType']=hospitalFacilities;
          request.fields['hospitalOwner']=hospitalOwner;
 request.fields['hospitalSize']=hospitalSize;
        request.fields['serviceType']=hospitalMedicalServices;
        request.fields['facilitiesType']=hospitalMedicalServices;
         request.fields['userEmail']=myEmail;

         if (image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('hospitalImage', image.path));
    }


    final response = await request.send();
     try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        snackMessage(message: "Hospital Added Successful!", context: context);
        Get.to(() => const AwaitApprovalScreen(),
            duration: const Duration(
              milliseconds: 800,
            ),
            curve: Curves.easeInCirc,
            transition: Transition.fadeIn);
        notifyListeners();
       
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        final errorMessage =
            'Failed to add blog. Status Code: ${response.reasonPhrase}';
        snackErrorMessage(message: errorMessage, context: context);
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      final errorMessage = 'Error adding blog: $e';
      snackErrorMessage(message: errorMessage, context: context);
      notifyListeners();
    }
  }

  void clear() {
    _reqMessage = '';
    notifyListeners();
  }
  
  // List<ChecklistItem> checklistEmergencyService = [
  //   ChecklistItem(title: 'Ambulance', isChecked: false),
  //   ChecklistItem(title: '24/7 Emergency Room', isChecked: false),
  //   ChecklistItem(title: 'Other', isChecked: false),
  // ];

  // List<ChecklistItem> checklistHospitalSize = [
  //   ChecklistItem(title: 'Ambulance', isChecked: false),
  //   ChecklistItem(title: '24/7 Emergency Room', isChecked: false),
  //   ChecklistItem(title: 'Other', isChecked: false),
  // ];

  // void concatenateEmergencyService() {
  //   String concatenatedItems = '';
  //   for (var item in checklistEmergencyService) {
  //     if (item.isChecked) {
  //       concatenatedItems += '${item.title},';
  //     }
  //   }
  //   if (concatenatedItems.isNotEmpty) {
  //     concatenatedItems =
  //         concatenatedItems.substring(0, concatenatedItems.length - 1);
  //   }
  //   hospitalEmergencyServices = concatenatedItems;
  // }

  // void concatenateMedicalServices() {
  //   String concatenatedItems = '';
  //   for (var item in checklistMedicalServices) {
  //     if (item.isChecked) {
  //       concatenatedItems += '${item.title},';
  //     }
  //   }
  //   if (concatenatedItems.isNotEmpty) {
  //     concatenatedItems =
  //         concatenatedItems.substring(0, concatenatedItems.length - 1);
  //   }
  //   hospitalServices = concatenatedItems;
  //   print(hospitalServices);
  // }

  // void concatenateFacilities() {
  //   String concatenatedItems = '';
  //   for (var item in checklistFacilities) {
  //     if (item.isChecked) {
  //       concatenatedItems += '${item.title},';
  //     }
  //   }
  //   if (concatenatedItems.isNotEmpty) {
  //     concatenatedItems =
  //         concatenatedItems.substring(0, concatenatedItems.length - 1);
  //   }
  //   hospitalFacilities = concatenatedItems;
  //   print(hospitalFacilities);
  // }
}
