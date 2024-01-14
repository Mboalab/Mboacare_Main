import 'package:flutter/material.dart';

class AddHospitalModel {
  String? id;
  String? userEmail;
  String? name;
  String? phoneNumber;
  String? email;
  String? website;
  String? placeAddress;
  String? latitude;
  String? longitude;
  List<String>? serviceType;
  List<String>? facilitiesType;
  String? hospitalType;
  String? hospitalOwner;
  String? hospitalSize;
  bool? isApprove;
  String? hospitalImage;

  AddHospitalModel(
      {this.id,
      this.userEmail,
      this.name,
      this.phoneNumber,
      this.email,
      this.website,
      this.placeAddress,
      this.latitude,
      this.longitude,
      this.serviceType,
      this.facilitiesType,
      this.hospitalType,
      this.hospitalOwner,
      this.hospitalSize,
      this.isApprove,
      this.hospitalImage});

  AddHospitalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userEmail = json['userEmail'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    website = json['website'];
    placeAddress = json['placeAddress'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    serviceType = json['serviceType'].cast<String>();
    facilitiesType = json['facilitiesType'].cast<String>();
    hospitalType = json['hospitalType'];
    hospitalOwner = json['hospitalOwner'];
    hospitalSize = json['hospitalSize'];
    isApprove = json['isApprove'];
    hospitalImage = json['hospitalImage'];
  }
}
