// class FacilitiesModel {
//   final String image;
//   final String name;
//   final String address;

//   FacilitiesModel(
//       {required this.image, required this.name, required this.address});
// }

// List<FacilitiesModel> facilities = [
//   FacilitiesModel(
//       image: 'lib/assests/images/central_park.png',
//       name: 'Central Park Hospital',
//       address: 'London, UK'),
//   FacilitiesModel(
//       image: 'lib/assests/images/oakville.png',
//       name: 'Oakville Hospital',
//       address: 'Cape Town, South Africa')
// ];

class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

// To parse this JSON data, do
//
//     final facilitiesModel = facilitiesModelFromJson(jsonString);



// FacilitiesModel facilitiesModelFromJson(String str) => FacilitiesModel.fromJson(json.decode(str));

// String facilitiesModelToJson(FacilitiesModel data) => json.encode(data.toJson());

class FacilitiesModel {
    List<String>? serviceType;
    String? website;
    String? hospitalType;
    List<String>? facilitiesType;
    String? latitude;
    String? hospitalOwner;
    String? hospitalSize;
    bool? isApprove;
    String? idToken;
    String? name;
    String? email;
    String? longitude;
    String? phoneNumber;
    String? hospitalImage;
    String? id;

    FacilitiesModel({
        this.serviceType,
        this.website,
        this.hospitalType,
        this.facilitiesType,
        this.latitude,
        this.hospitalOwner,
        this.hospitalSize,
        this.isApprove,
        this.idToken,
        this.name,
        this.email,
        this.longitude,
        this.phoneNumber,
        this.hospitalImage,
        this.id,
    });

    FacilitiesModel copyWith({
        List<String>? serviceType,
        String? website,
        String? hospitalType,
        List<String>? facilitiesType,
        String? latitude,
        String? hospitalOwner,
        String? hospitalSize,
        bool? isApprove,
        String? idToken,
        String? name,
        String? email,
        String? longitude,
        String? phoneNumber,
        String? hospitalImage,
        String? id,
    }) => 
        FacilitiesModel(
            serviceType: serviceType ?? this.serviceType,
            website: website ?? this.website,
            hospitalType: hospitalType ?? this.hospitalType,
            facilitiesType: facilitiesType ?? this.facilitiesType,
            latitude: latitude ?? this.latitude,
            hospitalOwner: hospitalOwner ?? this.hospitalOwner,
            hospitalSize: hospitalSize ?? this.hospitalSize,
            isApprove: isApprove ?? this.isApprove,
            idToken: idToken ?? this.idToken,
            name: name ?? this.name,
            email: email ?? this.email,
            longitude: longitude ?? this.longitude,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            hospitalImage: hospitalImage ?? this.hospitalImage,
            id: id ?? this.id,
        );

    factory FacilitiesModel.fromJson(Map<String, dynamic> json) => FacilitiesModel(
        serviceType: json["serviceType"] == null ? [] : List<String>.from(json["serviceType"]!.map((x) => x)),
        website: json["website"],
        hospitalType: json["hospitalType"],
        facilitiesType: json["facilitiesType"] == null ? [] : List<String>.from(json["facilitiesType"]!.map((x) => x)),
        latitude: json["latitude"],
        hospitalOwner: json["hospitalOwner"],
        hospitalSize: json["hospitalSize"],
        isApprove: json["isApprove"],
        idToken: json["idToken"],
        name: json["name"],
        email: json["email"],
        longitude: json["longitude"],
        phoneNumber: json["phoneNumber"],
        hospitalImage: json["hospitalImage"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "serviceType": serviceType == null ? [] : List<dynamic>.from(serviceType!.map((x) => x)),
        "website": website,
        "hospitalType": hospitalType,
        "facilitiesType": facilitiesType == null ? [] : List<dynamic>.from(facilitiesType!.map((x) => x)),
        "latitude": latitude,
        "hospitalOwner": hospitalOwner,
        "hospitalSize": hospitalSize,
        "isApprove": isApprove,
        "idToken": idToken,
        "name": name,
        "email": email,
        "longitude": longitude,
        "phoneNumber": phoneNumber,
        "hospitalImage": hospitalImage,
        "id": id,
    };
  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}
