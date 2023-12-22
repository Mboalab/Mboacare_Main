import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'dart:developer' as devtools show log;
import 'package:http/http.dart' as http;

import '../widgets/snackbar.dart';
import '../app_modules/med_user/screen/dashboard/hospital/add_hopital.dart';

class AddHospitalProvider extends ChangeNotifier {
  AddHospitalProvider() {
    fetchApiKey();
  }

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
  final hospitalSpecialitiesController = TextEditingController();
  final hospitalBedCapacityController = TextEditingController();
  final hospitalEmergencyServicesController = TextEditingController();
  String initialCountry = 'CM';
  final number = PhoneNumber(isoCode: 'CM');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String documentId =
      'aeac9fSTIeI6UD0OywSj'; // ID of the document to fetch
  final String collectionName = 'sendgrid'; // Name of the collection
  final String fieldName = 'apiKey'; // Name of the field to retrieve
  String apiKeySG = '';
  final ImagePicker _imagePicker = ImagePicker();
  File? selectedImage;

  String? hospitalName;
  String? hospitalAddress;
  String? hospitalPhone;
  String? hospitalEmail;
  String? hospitalWebsite;
  String? hospitalType;
  String? hospitalSize;
  String? hospitalOwnership;
  String? hospitalSpecialities;
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

  Future<void> fetchApiKey() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(documentId)
          .get();
      if (documentSnapshot.exists) {
        apiKeySG = documentSnapshot.get(fieldName);
        devtools.log(apiKeySG);
      } else {
        devtools.log('Document not found');
      }
    } catch (error) {
      devtools.log('Error fetching data: $error');
    }
  }

  Future<void> sendRegisterSuccessEmail(
      String recipientEmail, String recipientName) async {
    String apiKey = apiKeySG;
    final Uri uri = Uri.https(
      'api.sendgrid.com',
      '/v3/mail/send',
    );

    final Map<String, dynamic> data = {
      'personalizations': [
        {
          'to': [
            {
              'email': recipientEmail,
              'name': recipientName
            }, // Included recipient's name
          ],
          'subject': 'Thank You for Registering with Mboacare!',
        },
      ],
      'from': {'email': 'mboacare@gmail.com'},
      'content': [
        {
          'type': 'text/plain',
          'value': '''
Dear $recipientName,

Thank you for registering your facility with Mboacare! We have received your details and appreciate your interest in joining our platform.

Our team is currently reviewing the information you've provided to ensure that it aligns with our quality standards. We're committed to creating a network of reliable medical facilities that users can trust. As soon as the review process is complete, we will notify you about the status of your registration.

We appreciate your patience during this process. If you have any questions or need further assistance, please don't hesitate to reach out to us at [contact email or phone number]. We look forward to potentially featuring your hospital on Mboacare and expanding our network of healthcare providers.

Thank you once again for considering Mboacare.

Best regards,
The Mboacare Team
        '''
        },
      ],
    };

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 202) {
      devtools.log('Email sent successfully');
    } else {
      devtools.log('Failed to send email. Status code: ${response.statusCode}');
    }
  }

  void submitForm({Function()? onSuccessNavigate}) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // Convert hospitalData to a map
      final hospitalDataMap = {
        'hospitalName': hospitalNameController.text,
        'hospitalAddress': hospitalAddressController.text,
        'hospitalPhone': hospitalPhoneNumberController.text,
        'hospitalEmail': hospitalEmailController.text,
        'hospitalWebsite': hospitalWebsiteController.text,
        'hospitalType': hospitalTypeController.text,
        'hospitalSize': hospitalSizeController.text,
        'hospitalOwnership': hospitalOwnerShipController.text,
        'hospitalSpecialities': hospitalSpecialitiesController.text,
        'hospitalFacilities': hospitalFacilityController.text,
        'hospitalBedCapacity': hospitalBedCapacityController.text,
        'hospitalEmergencyServices': hospitalEmergencyServicesController.text
      };

      // CollectionReference for the hospitals collection in Cloud Firestore
      final CollectionReference hospitalsRef =
          FirebaseFirestore.instance.collection('hospitals');

      try {
        if (selectedImage != null) {
          // Upload the selected image to Firebase Storage
          //   final Reference storageReference = FirebaseStorage.instance
          //       .ref()
          //       .child(
          //           'hospital_images/${DateTime.now().millisecondsSinceEpoch}');
          //   final UploadTask uploadTask =
          //       storageReference.putFile(_selectedImage!);
          //   final TaskSnapshot storageTaskSnapshot =
          //       await uploadTask.whenComplete(() {});
          //   final String downloadUrl =
          //       await storageTaskSnapshot.ref.getDownloadURL();
          //   hospitalDataMap['hospitalImageUrl'] =
          //       downloadUrl; // Add the download URL to the map
          //               // Save hospital data to Cloud Firestore
          // await _hospitalsRef.add(hospitalDataMap);
          final Reference storageReference = FirebaseStorage.instance
              .ref()
              .child(
                  'hospital_images/${DateTime.now().millisecondsSinceEpoch}');

          final UploadTask uploadTask =
              storageReference.putFile(selectedImage!);
          TaskSnapshot storageTaskSnapshot = await uploadTask;

          if (uploadTask.snapshot.state == TaskState.success) {
            final String downloadUrl =
                await storageTaskSnapshot.ref.getDownloadURL();
            devtools.log("Download URL: $downloadUrl");

            hospitalDataMap['hospitalImageUrl'] = downloadUrl;
            // Add other data to hospitalDataMap

            // Save hospital data to Cloud Firestore
            await hospitalsRef.add(hospitalDataMap);

            devtools.log("Hospital data saved successfully.");
          } else {
            devtools.log("Image upload task failed.");
          }
        } else {
          // Save hospital data to Cloud Firestore
          hospitalDataMap['hospitalImageUrl'] = '';
          await hospitalsRef.add(hospitalDataMap);
        }
        if (hospitalEmail!.isNotEmpty) {
          sendRegisterSuccessEmail(hospitalEmail!, hospitalName!);
        }
        // Show a snackbar indicating successful form submission
        showMessage(message: 'Form submitted successfully');

        // Clear the form fields and selected image after successful submission
        formKey.currentState?.reset();
        selectedImage = null;
        notifyListeners();

        // Add hospital data to the HospitalProvider
        // final hospitalProvider =
        //     Provider.of<HospitalProvider>(context, listen: false);
        // hospitalProvider.addHospital(HospitalData(
        //   hospitalName: _hospitalName!,
        //   hospitalAddress: _hospitalAddress!,
        //   hospitalSpecialities: _hospitalSpecialities!,
        //   hospitalImageUrl: hospitalDataMap['hospitalImageUrl'],
        // ));
        Future.delayed(const Duration(seconds: 1)).then((_) {
          // Navigate to the HospitalDashboard screen
          onSuccessNavigate!();
        });
      } catch (e) {
        devtools.log('Error saving data to Cloud Firestore: $e');

        // Show an error message if there's an issue with data saving
        showMessage(
            isError: true, message: 'Error saving data. Please try again.');
      }
    }
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

  List<ChecklistItem> checklistEmergencyService = [
    ChecklistItem(title: 'Ambulance', isChecked: false),
    ChecklistItem(title: '24/7 Emergency Room', isChecked: false),
    ChecklistItem(title: 'Other', isChecked: false),
  ];

  List<ChecklistItem> checklistHospitalSize = [
    ChecklistItem(title: 'Ambulance', isChecked: false),
    ChecklistItem(title: '24/7 Emergency Room', isChecked: false),
    ChecklistItem(title: 'Other', isChecked: false),
  ];

  List<ChecklistItem> checklistHospitalOwners = [
    ChecklistItem(title: 'Individual', isChecked: false),
    ChecklistItem(title: 'Corp0rate', isChecked: false),
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

  void concatenateMedicalServices() {
    String concatenatedItems = '';
    for (var item in checklistMedicalServices) {
      if (item.isChecked) {
        concatenatedItems += '${item.title},';
      }
    }
    if (concatenatedItems.isNotEmpty) {
      concatenatedItems =
          concatenatedItems.substring(0, concatenatedItems.length - 1);
    }
    hospitalSpecialities = concatenatedItems;
  }

  void concatenateFacilities() {
    String concatenatedItems = '';
    for (var item in checklistFacilities) {
      if (item.isChecked) {
        concatenatedItems += '${item.title},';
      }
    }
    if (concatenatedItems.isNotEmpty) {
      concatenatedItems =
          concatenatedItems.substring(0, concatenatedItems.length - 1);
    }
    hospitalFacilities = concatenatedItems;
  }

  void concatenateEmergencyService() {
    String concatenatedItems = '';
    for (var item in checklistEmergencyService) {
      if (item.isChecked) {
        concatenatedItems += '${item.title},';
      }
    }
    if (concatenatedItems.isNotEmpty) {
      concatenatedItems =
          concatenatedItems.substring(0, concatenatedItems.length - 1);
    }
    hospitalEmergencyServices = concatenatedItems;
  }

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
    hospitalMedicalController.clear();
    notifyListeners();
  }

  void addToFacilitiesChip(String text) {
    debugPrint("AddToFac: $facilitiesAvailableChipItems");
    facilitiesAvailableChipItems.add(text);
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
    hospitalSpecialitiesController.dispose();
    hospitalBedCapacityController.dispose();
    hospitalEmergencyServicesController.dispose();
    super.dispose();
  }
}
