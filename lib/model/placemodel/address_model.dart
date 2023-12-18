// ignore_for_file: public_member_api_docs, sort_constructors_first

class AddressModel {
  final String? address;
  final String? postalCode;
  final String? locality;
  final String? country;

  AddressModel({
    required this.address,
    required this.locality,
    required this.postalCode,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'address': address,
      'postalCode': postalCode,
      'locality': locality,
      'country': country,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> map) {
    return AddressModel(
      address: map['address'] != null ? map['address'] as String : null,
      postalCode:
          map['postalCode'] != null ? map['postalCode'] as String : null,
      locality: map['locality'] != null ? map['locality'] as String : null,
      country: map['country'] as String,
    );
  }
}
