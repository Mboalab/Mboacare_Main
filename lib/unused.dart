// import 'package:flutter/material.dart';

// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'dart:developer' as devtools show log;

// import 'model/hospital_data.dart';

// //hospital provider from firebase firestore.

// class HospitalProvider with ChangeNotifier {
//   List<HospitalData> _hospitals = [];
//   List<HospitalData> _filteredHospitals = [];
//   String _selectedFilter = 'View All'; // Initialize with 'View All'

//   List<HospitalData> get hospitals => _hospitals;
//   List<HospitalData> get filteredHospitals => _filteredHospitals;
//   String get selectedFilter => _selectedFilter;

//   // Constructor to initialize the HospitalProvider with data
//   HospitalProvider() {
//     _fetchHospitalsFromFirestore();
//   }

//   // Stream that listens for changes in the Firestore collection
//   Stream<List<HospitalData>> getHospitalsStream() {
//     return FirebaseFirestore.instance.collection('hospitals').snapshots().map(
//       (querySnapshot) {
//         List<HospitalData> hospitals = [];
//         for (var doc in querySnapshot.docs) {
//           final hospital = HospitalData(
//             hospitalName: doc.get('hospitalName') ?? '',
//             hospitalAddress: doc.get('hospitalAddress') ?? '',
//             hospitalSpecialities: doc.get('hospitalSpecialities') ?? '',
//             hospitalImageUrl: doc.get('hospitalImageUrl') ?? '',
//             hospitalWebsite: doc.get('hospitalWebsite') ?? '',
//             hospitalEmail: doc.get('hospitalEmail') ?? '',
//             hospitalPhone: doc.get('hospitalPhone') ?? '',
//             hospitalBedCapacity: doc.get('hospitalBedCapacity') ?? '',
//             hospitalFacilities: doc.get('hospitalFacilities') ?? '',
//             hospitalEmergencyServices:
//                 doc.get('hospitalEmergencyServices') ?? '',
//             // Add other fields if needed
//           );
//           //devtools.log(hospital.hospitalImageUrl);
//           hospitals.add(hospital);
//         }
//         return hospitals;
//       },
//     );
//   }

//   void filterHospitals(String query) {
//     devtools.log('Filtering hospitals with query: $query');
//     _filteredHospitals = applyFilters(_hospitals, query, _selectedFilter);
//     notifyListeners();
//   }

//   List<HospitalData> applyFilters(
//       List<HospitalData> hospitals, String query, String selectedFilter) {
//     final filteredHospitals = hospitals.where((hospital) {
//       final nameMatches =
//           hospital.hospitalName.toLowerCase().contains(query.toLowerCase());
//       final addressMatches =
//           hospital.hospitalAddress.toLowerCase().contains(query.toLowerCase());
//       final specialitiesMatch = hospital.hospitalSpecialities
//           .toLowerCase()
//           .contains(query.toLowerCase());
//       final facilitiesMatch = hospital.hospitalFacilities
//           .toLowerCase()
//           .contains(query.toLowerCase());
//       // Check if the hospital matches the selected filter
//       final filterMatches = selectedFilter == 'View All' ||
//           hospital.hospitalSpecialities
//               .toLowerCase()
//               .contains(selectedFilter.toLowerCase()) ||
//           hospital.hospitalFacilities
//               .toLowerCase()
//               .contains(selectedFilter.toLowerCase());

//       return (nameMatches ||
//               addressMatches ||
//               specialitiesMatch ||
//               facilitiesMatch) &&
//           filterMatches;
//     }).toList();

//     return filteredHospitals;
//   }

//   void setSelectedFilter(String filterOption) {
//     _selectedFilter = filterOption;
//     notifyListeners();
//   }

//   void addHospital(HospitalData hospital) async {
//     // Convert hospital data to a map
//     final hospitalDataMap = {
//       'hospitalName': hospital.hospitalName,
//       'hospitalAddress': hospital.hospitalAddress,
//       'hospitalSpecialities': hospital.hospitalSpecialities,
//       'hospitalImagePath': hospital.hospitalImageUrl,
//       // Add other fields if needed
//     };

//     try {
//       // Save hospital data to Cloud Firestore
//       await FirebaseFirestore.instance
//           .collection('hospitals')
//           .add(hospitalDataMap);

//       // You can also add the hospital to the local list to display it immediately
//       _hospitals.add(hospital);
//       _filteredHospitals.add(hospital);

//       notifyListeners();
//     } catch (e) {
//       devtools.log('Error saving data to Cloud Firestore: $e');
//     }
//   }

//   void _fetchHospitalsFromFirestore() async {
//     try {
//       final querySnapshot =
//           await FirebaseFirestore.instance.collection('hospitals').get();

//       _hospitals = [];
//       for (var doc in querySnapshot.docs) {
//         final hospital = HospitalData(
//           hospitalName: doc.get('hospitalName') ?? '',
//           hospitalAddress: doc.get('hospitalAddress') ?? '',
//           hospitalSpecialities: doc.get('hospitalSpecialities') ?? '',
//           hospitalImageUrl: doc.get('hospitalImageUrl') ?? '',
//           hospitalWebsite: doc.get('hospitalWebsite') ?? '',
//           hospitalEmail: doc.get('hospitalEmail') ?? '',
//           hospitalPhone: doc.get('hospitalPhone') ?? '',
//           hospitalBedCapacity: doc.get('hospitalBedCapacity') ?? '',
//           hospitalFacilities: doc.get('hospitalFacilities') ?? '',
//           hospitalEmergencyServices: doc.get('hospitalEmergencyServices') ?? '',
//           // Add other fields if needed
//         );
//         _hospitals.add(hospital);
//       }

//       // Set filteredHospitals to all hospitals initially
//       _filteredHospitals = _hospitals;

//       // devtools.log the first hospital's image URL to check if it's retrieved correctly
//       if (_hospitals.isNotEmpty) {
//         devtools
//             .log('First hospital image URL: ${_hospitals[0].hospitalImageUrl}');
//       }
//       notifyListeners();
//     } catch (e) {
//       devtools.log('Error fetching data from Cloud Firestore: $e');
//     }
//   }

//   // Method to update filtered hospitals based on selected filter tab
//   void updateFilteredHospitals(List<HospitalData> hospitals) {
//     if (_selectedFilter == 'View All') {
//       _filteredHospitals = hospitals;
//     } else {
//       _filteredHospitals = hospitals
//           .where((hospital) => hospital.hospitalSpecialities
//               .toLowerCase()
//               .contains(_selectedFilter.toLowerCase()))
//           .toList();
//     }
//     notifyListeners();
//   }

//   void updateFilteredHospitalsDropdown(List<HospitalData> hospitals) {
//     if (_selectedFilter == 'View All') {
//       _filteredHospitals = hospitals;
//     } else {
//       _filteredHospitals = hospitals
//           .where((hospital) => hospital.hospitalFacilities
//               .toLowerCase()
//               .contains(_selectedFilter.toLowerCase()))
//           .toList();
//       devtools.log('Drop : ${_filteredHospitals.length}');
//     }
//     notifyListeners();
//   }
// }

// import 'dart:convert';

// import 'package:collection/collection.dart';

// class HospitalModel {
//   List<String>? serviceType;
//   String? website;
//   String? hospitalType;
//   List<String>? facilitiesType;
//   String? latitude;
//   String? placeAddress;
//   String? hospitalOwner;
//   String? hospitalSize;
//   bool? isApprove;
//   String? phoneNumber;
//   String? name;
//   String? hospitalImage;
//   String? userEmail;
//   String? id;
//   String? email;
//   String? longitude;

//   HospitalModel({
//     this.serviceType,
//     this.website,
//     this.hospitalType,
//     this.facilitiesType,
//     this.latitude,
//     this.placeAddress,
//     this.hospitalOwner,
//     this.hospitalSize,
//     this.isApprove,
//     this.phoneNumber,
//     this.name,
//     this.hospitalImage,
//     this.userEmail,
//     this.id,
//     this.email,
//     this.longitude,
//   });

//   @override
//   String toString() {
//     return 'HospitalModel(serviceType: $serviceType, website: $website, hospitalType: $hospitalType, facilitiesType: $facilitiesType, latitude: $latitude, placeAddress: $placeAddress, hospitalOwner: $hospitalOwner, hospitalSize: $hospitalSize, isApprove: $isApprove, phoneNumber: $phoneNumber, name: $name, hospitalImage: $hospitalImage, userEmail: $userEmail, id: $id, email: $email, longitude: $longitude)';
//   }

//   factory HospitalModel.fromMap(Map<String, dynamic> data) => HospitalModel(
//         serviceType: data['serviceType'] as List<String>?,
//         website: data['website'] as String?,
//         hospitalType: data['hospitalType'] as String?,
//         facilitiesType: data['facilitiesType'] as List<String>?,
//         latitude: data['latitude'] as String?,
//         placeAddress: data['placeAddress'] as String?,
//         hospitalOwner: data['hospitalOwner'] as String?,
//         hospitalSize: data['hospitalSize'] as String?,
//         isApprove: data['isApprove'] as bool?,
//         phoneNumber: data['phoneNumber'] as String?,
//         name: data['name'] as String?,
//         hospitalImage: data['hospitalImage'] as String?,
//         userEmail: data['userEmail'] as String?,
//         id: data['id'] as String?,
//         email: data['email'] as String?,
//         longitude: data['longitude'] as String?,
//       );

//   Map<String, dynamic> toMap() => {
//         'serviceType': serviceType,
//         'website': website,
//         'hospitalType': hospitalType,
//         'facilitiesType': facilitiesType,
//         'latitude': latitude,
//         'placeAddress': placeAddress,
//         'hospitalOwner': hospitalOwner,
//         'hospitalSize': hospitalSize,
//         'isApprove': isApprove,
//         'phoneNumber': phoneNumber,
//         'name': name,
//         'hospitalImage': hospitalImage,
//         'userEmail': userEmail,
//         'id': id,
//         'email': email,
//         'longitude': longitude,
//       };

//   /// `dart:convert`
//   ///
//   /// Parses the string and returns the resulting Json object
//   /// as [HospitalModel].
//   factory HospitalModel.fromJson(String data) {
//     return HospitalModel.fromMap(json.decode(data) as Map<String, dynamic>);
//   }

//   /// `dart:convert`
//   ///
//   /// Converts [HospitalModel] to a JSON string.
//   String toJson() => json.encode(toMap());

//   HospitalModel copyWith({
//     List<String>? serviceType,
//     String? website,
//     String? hospitalType,
//     List<String>? facilitiesType,
//     String? latitude,
//     String? placeAddress,
//     String? hospitalOwner,
//     String? hospitalSize,
//     bool? isApprove,
//     String? phoneNumber,
//     String? name,
//     String? hospitalImage,
//     String? userEmail,
//     String? id,
//     String? email,
//     String? longitude,
//   }) {
//     return HospitalModel(
//       serviceType: serviceType ?? this.serviceType,
//       website: website ?? this.website,
//       hospitalType: hospitalType ?? this.hospitalType,
//       facilitiesType: facilitiesType ?? this.facilitiesType,
//       latitude: latitude ?? this.latitude,
//       placeAddress: placeAddress ?? this.placeAddress,
//       hospitalOwner: hospitalOwner ?? this.hospitalOwner,
//       hospitalSize: hospitalSize ?? this.hospitalSize,
//       isApprove: isApprove ?? this.isApprove,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       name: name ?? this.name,
//       hospitalImage: hospitalImage ?? this.hospitalImage,
//       userEmail: userEmail ?? this.userEmail,
//       id: id ?? this.id,
//       email: email ?? this.email,
//       longitude: longitude ?? this.longitude,
//     );
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     if (other is! HospitalModel) return false;
//     final mapEquals = const DeepCollectionEquality().equals;
//     return mapEquals(other.toMap(), toMap());
//   }

//   @override
//   int get hashCode =>
//       serviceType.hashCode ^
//       website.hashCode ^
//       hospitalType.hashCode ^
//       facilitiesType.hashCode ^
//       latitude.hashCode ^
//       placeAddress.hashCode ^
//       hospitalOwner.hashCode ^
//       hospitalSize.hashCode ^
//       isApprove.hashCode ^
//       phoneNumber.hashCode ^
//       name.hashCode ^
//       hospitalImage.hashCode ^
//       userEmail.hashCode ^
//       id.hashCode ^
//       email.hashCode ^
//       longitude.hashCode;
// }

// import 'dart:convert';
// import 'dart:developer' as devtools show log;

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:mboacare/model/hospital_model/hospital_model.dart';
// import 'package:mboacare/services/apis.dart';

// class HospitalProvider extends ChangeNotifier {
//   List<HospitalModel> _allHospitals = [];
//   List<HospitalModel> _filteredHospitals = [];
//   String _selectedFilter = 'View All'; // Initialize with 'View All'

//   List<HospitalModel> get allHospitals => _allHospitals;
//   List<HospitalModel> get filteredHospitals => _filteredHospitals;
//   String get selectedFilter => _selectedFilter;
//   Future<void> fetchAllHospitals() async {
//     final apiUrl = Uri.parse(Apis.allHospitals);

//     try {
//       final response = await http.get(apiUrl, headers: {
//         'Content-Type': 'application/json; charset=utf-8',
//       });
//       if (response.statusCode == 200) {
//         dynamic responseData = json.decode(response.body);
//         print('Response Data: $responseData');
//         if (responseData is List) {
//           _allHospitals = responseData
//               .map((hospitalData) => HospitalModel.fromMap(hospitalData))
//               .toList();
//         } else {
//           final HospitalModel hospital = HospitalModel.fromMap(responseData);
//           _allHospitals = [hospital];
//         }

//         _filteredHospitals = _allHospitals;
//         notifyListeners();
//       } else {
//         devtools.log(
//             'Failed to fetch hospitals. Status code: ${response.statusCode}');
//         // throw Exception(
//         //     'Failed to fetch hospitals. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       devtools.log('Error fetching hospitals: $e');
//       // throw Exception('Error fetching hospitals: $e');
//     }
//   }

//   Future<List<HospitalModel>> filterHospitals(
//       List<String> selectedTypes) async {
//     return allHospitals.where((hospital) {
//       return hospital.facilitiesType != null &&
//           hospital.facilitiesType!.any((type) => selectedTypes.contains(type));
//     }).toList();
//   }

//   List<HospitalModel> applyFilters(
//       List<HospitalModel> hospitals, String query, String selectedFilter) {
//     final filteredHospitals = hospitals.where((hospital) {
//       final nameMatches =
//           hospital.name?.toLowerCase().contains(query.toLowerCase()) ?? false;
//       final addressMatches =
//           hospital.placeAddress?.toLowerCase().contains(query.toLowerCase()) ??
//               false;
//       final specialitiesMatch = hospital.serviceType?.any((speciality) =>
//               speciality.toLowerCase().contains(query.toLowerCase())) ??
//           false;
//       final facilitiesMatch = hospital.facilitiesType?.any((facility) =>
//               facility.toLowerCase().contains(query.toLowerCase())) ??
//           false;
//       //check if hospital matches selected filter
//       final filterMatches = selectedFilter == 'View All' ||
//           (hospital.serviceType?.any((speciality) => speciality
//                   .toLowerCase()
//                   .contains(selectedFilter.toLowerCase())) ??
//               false) ||
//           (hospital.facilitiesType?.any((facility) => facility
//                   .toLowerCase()
//                   .contains(selectedFilter.toLowerCase())) ??
//               false);
//       return (nameMatches ||
//               addressMatches ||
//               specialitiesMatch ||
//               facilitiesMatch) &&
//           filterMatches;
//     }).toList();

//     return filteredHospitals;
//   }

//   void setSelectedFilter(String filter) {
//     _selectedFilter = filter;
//     notifyListeners();
//   }

//   Future<void> addHospital(HospitalModel newHospital) async {
//     try {
//       final response = await http.post(
//         Uri.parse(Apis.addHospitals),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(newHospital.toMap()),
//       );

//       if (response.statusCode == 201) {
//         final dynamic jsonResponse = json.decode(response.body);

//         String successMessage =
//             jsonResponse['message'] as String? ?? 'Hospital added successfully';
//         print(successMessage);

//         await fetchAllHospitals();
//       } else {
//         // Handle different HTTP status codes or check for specific error messages
//         final dynamic jsonResponse = json.decode(response.body);
//         final errorMessage =
//             jsonResponse['message'] as String? ?? 'Failed to add hospital';
//         throw Exception(errorMessage);
//       }
//     } catch (e) {
//       throw Exception('Failed to add hospital: $e');
//     }
//   }

//   Future<void> updateHospital(HospitalModel updatedHospital) async {
//     try {
//       final response = await http.put(
//         Uri.parse(Apis.updateHospitals),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(updatedHospital.toMap()),
//       );

//       if (response.statusCode == 200) {
//         await fetchAllHospitals();
//       } else {
//         final dynamic jsonResponse = json.decode(response.body);
//         final errorMessage =
//             jsonResponse['message'] as String? ?? 'Failed to update hospital';
//         throw Exception(errorMessage);
//       }
//     } catch (e) {
//       throw Exception('Failed to update hospital: $e');
//     }
//   }

//   void updateFilteredHospitals(String selectedFilter) {
//     if (selectedFilter == 'View All') {
//       // If 'View All' selected, show all hospitals
//       _filteredHospitals = List.from(_allHospitals);
//     } else {
//       // Filter hospitals based on selected speciality or facility
//       _filteredHospitals = _allHospitals.where((hospital) {
//         return hospital.serviceType?.contains(selectedFilter) == true ||
//             hospital.facilitiesType?.contains(selectedFilter) == true;
//       }).toList();
//     }

//     notifyListeners();
//   }

//   void updateFilteredHospitalsDropdown(List<HospitalModel> hospitals) {
//     if (_selectedFilter == 'View All') {
//       _filteredHospitals = hospitals;
//     } else {
//       _filteredHospitals = hospitals
//           .where((hospital) =>
//               hospital.facilitiesType?.any((facility) =>
//                   facility.toLowerCase() == _selectedFilter.toLowerCase()) ??
//               false)
//           .toList();
//       devtools.log('Drop : ${_filteredHospitals.length}');
//     }
//     notifyListeners();
//   }
// }





    // try {
    //   final response = await http.get(apiUrl, headers: {
    //     'Content-Type': 'application/json; charset=utf-8',
    //   });
    //   if (response.statusCode == 200) {
    //     dynamic responseData = json.decode(response.body);
    //     print('Response Data: $responseData');
    //     if (responseData is List) {
    //       // Handle the list of hospitals:

    //       // Create a list to store the HospitalModel objects
    //       List<HospitalModel> hospitals = [];

    //       // Iterate through each hospital map in the list
    //       for (final hospitalMap in responseData) {
    //         // Create a HospitalModel object from the map
    //         HospitalModel hospital = HospitalModel.fromMap(hospitalMap);

    //         // Add the hospital object to the list
    //         hospitals.add(hospital);
    //       }

    //       // Assign the parsed hospitals list to a variable
    //       _allHospitals = hospitals;
    //     }
    //   } else {
    //     devtools.log(
    //         'Failed to fetch hospitals. Status code: ${response.statusCode}');
    //     // throw Exception(
    //     //     'Failed to fetch hospitals. Status code: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   devtools.log('Error fetching hospitals: $e');
    //   // throw Exception('Error fetching hospitals: $e');



      // Expanded(
      //                         child: FutureBuilder<List<HospitalModel>>(
      //                             future: ApiServices().fetchAllHospitals(),
      //                             builder: (context, snapshot) {
      //                               if (!snapshot.hasData) {
      //                                 return const Center(
      //                                   child: SpinKitWaveSpinner(
      //                                     size: 50.0,
      //                                     color: AppColors.buttonColor,
      //                                     trackColor: AppColors.registerCard,
      //                                     waveColor: AppColors.deleteColor,
      //                                   ),
      //                                 );
      //                               }
      //                               if (snapshot.hasError) {
      //                                 return Text('Error: ${snapshot.error}');
      //                               }

      //                               final hospitalData = snapshot.data;
      //                               return ListView.builder(
      //                                 itemCount: hospitalData!.length,
      //                                 itemBuilder: (context, index) {
      //                                   final hospital = hospitalData[index];

      //                                   return Card(



        // List<HospitalModel> _filterHospitals(String name, String location) {
  //   return hospitalData
  //       .where((hospital) =>
  //           hospital.name?.toLowerCase().contains(name.toLowerCase()) == true ||
  //           hospital.placeAddress
  //                   ?.toLowerCase()
  //                   .contains(location.toLowerCase()) ==
  //               true)
  //       .toList();
  // }