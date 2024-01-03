import 'dart:convert';

import 'package:collection/collection.dart';

class HospitalModel {
	List<String>? serviceType;
	String? website;
	String? hospitalType;
	List<String>? facilitiesType;
	String? latitude;
	String? placeAddress;
	String? hospitalOwner;
	String? hospitalSize;
	bool? isApprove;
	String? phoneNumber;
	String? name;
	String? hospitalImage;
	String? userEmail;
	String? id;
	String? email;
	String? longitude;

	HospitalModel({
		this.serviceType, 
		this.website, 
		this.hospitalType, 
		this.facilitiesType, 
		this.latitude, 
		this.placeAddress, 
		this.hospitalOwner, 
		this.hospitalSize, 
		this.isApprove, 
		this.phoneNumber, 
		this.name, 
		this.hospitalImage, 
		this.userEmail, 
		this.id, 
		this.email, 
		this.longitude, 
	});

	@override
	String toString() {
		return 'HospitalModel(serviceType: $serviceType, website: $website, hospitalType: $hospitalType, facilitiesType: $facilitiesType, latitude: $latitude, placeAddress: $placeAddress, hospitalOwner: $hospitalOwner, hospitalSize: $hospitalSize, isApprove: $isApprove, phoneNumber: $phoneNumber, name: $name, hospitalImage: $hospitalImage, userEmail: $userEmail, id: $id, email: $email, longitude: $longitude)';
	}

	factory HospitalModel.fromMap(Map<String, dynamic> data) => HospitalModel(
				serviceType: data['serviceType'] as List<String>?,
				website: data['website'] as String?,
				hospitalType: data['hospitalType'] as String?,
				facilitiesType: data['facilitiesType'] as List<String>?,
				latitude: data['latitude'] as String?,
				placeAddress: data['placeAddress'] as String?,
				hospitalOwner: data['hospitalOwner'] as String?,
				hospitalSize: data['hospitalSize'] as String?,
				isApprove: data['isApprove'] as bool?,
				phoneNumber: data['phoneNumber'] as String?,
				name: data['name'] as String?,
				hospitalImage: data['hospitalImage'] as String?,
				userEmail: data['userEmail'] as String?,
				id: data['id'] as String?,
				email: data['email'] as String?,
				longitude: data['longitude'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'serviceType': serviceType,
				'website': website,
				'hospitalType': hospitalType,
				'facilitiesType': facilitiesType,
				'latitude': latitude,
				'placeAddress': placeAddress,
				'hospitalOwner': hospitalOwner,
				'hospitalSize': hospitalSize,
				'isApprove': isApprove,
				'phoneNumber': phoneNumber,
				'name': name,
				'hospitalImage': hospitalImage,
				'userEmail': userEmail,
				'id': id,
				'email': email,
				'longitude': longitude,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [HospitalModel].
	factory HospitalModel.fromJson(String data) {
		return HospitalModel.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [HospitalModel] to a JSON string.
	String toJson() => json.encode(toMap());

	HospitalModel copyWith({
		List<String>? serviceType,
		String? website,
		String? hospitalType,
		List<String>? facilitiesType,
		String? latitude,
		String? placeAddress,
		String? hospitalOwner,
		String? hospitalSize,
		bool? isApprove,
		String? phoneNumber,
		String? name,
		String? hospitalImage,
		String? userEmail,
		String? id,
		String? email,
		String? longitude,
	}) {
		return HospitalModel(
			serviceType: serviceType ?? this.serviceType,
			website: website ?? this.website,
			hospitalType: hospitalType ?? this.hospitalType,
			facilitiesType: facilitiesType ?? this.facilitiesType,
			latitude: latitude ?? this.latitude,
			placeAddress: placeAddress ?? this.placeAddress,
			hospitalOwner: hospitalOwner ?? this.hospitalOwner,
			hospitalSize: hospitalSize ?? this.hospitalSize,
			isApprove: isApprove ?? this.isApprove,
			phoneNumber: phoneNumber ?? this.phoneNumber,
			name: name ?? this.name,
			hospitalImage: hospitalImage ?? this.hospitalImage,
			userEmail: userEmail ?? this.userEmail,
			id: id ?? this.id,
			email: email ?? this.email,
			longitude: longitude ?? this.longitude,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! HospitalModel) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			serviceType.hashCode ^
			website.hashCode ^
			hospitalType.hashCode ^
			facilitiesType.hashCode ^
			latitude.hashCode ^
			placeAddress.hashCode ^
			hospitalOwner.hashCode ^
			hospitalSize.hashCode ^
			isApprove.hashCode ^
			phoneNumber.hashCode ^
			name.hashCode ^
			hospitalImage.hashCode ^
			userEmail.hashCode ^
			id.hashCode ^
			email.hashCode ^
			longitude.hashCode;
}
