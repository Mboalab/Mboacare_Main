// To parse this JSON data, do
//
//     final geometryModel = geometryModelFromJson(jsonString);

import 'dart:convert';

GeometryModel geometryModelFromJson(String str) =>
    GeometryModel.fromJson(json.decode(str));

String geometryModelToJson(GeometryModel data) => json.encode(data.toJson());

class GeometryModel {
  List<dynamic>? htmlAttributions;
  Result? result;
  String? status;

  GeometryModel({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  GeometryModel copyWith({
    List<dynamic>? htmlAttributions,
    Result? result,
    String? status,
  }) =>
      GeometryModel(
        htmlAttributions: htmlAttributions ?? this.htmlAttributions,
        result: result ?? this.result,
        status: status ?? this.status,
      );

  factory GeometryModel.fromJson(Map<String, dynamic> json) => GeometryModel(
        htmlAttributions: json["html_attributions"] == null
            ? []
            : List<dynamic>.from(json["html_attributions"]!.map((x) => x)),
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_attributions": htmlAttributions == null
            ? []
            : List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "result": result?.toJson(),
        "status": status,
      };
}

class Result {
  List<AddressComponent>? addressComponents;
  String? adrAddress;
  String? businessStatus;
  String? formattedAddress;
  String? formattedPhoneNumber;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? internationalPhoneNumber;
  String? name;
  OpeningHours? openingHours;
  List<Photo>? photos;
  String? placeId;
  PlusCode? plusCode;
  int? rating;
  String? reference;
  List<Review>? reviews;
  List<String>? types;
  String? url;
  int? userRatingsTotal;
  int? utcOffset;
  String? vicinity;
  String? website;

  Result({
    this.addressComponents,
    this.adrAddress,
    this.businessStatus,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.internationalPhoneNumber,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.reviews,
    this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
    this.website,
  });

  Result copyWith({
    List<AddressComponent>? addressComponents,
    String? adrAddress,
    String? businessStatus,
    String? formattedAddress,
    String? formattedPhoneNumber,
    Geometry? geometry,
    String? icon,
    String? iconBackgroundColor,
    String? iconMaskBaseUri,
    String? internationalPhoneNumber,
    String? name,
    OpeningHours? openingHours,
    List<Photo>? photos,
    String? placeId,
    PlusCode? plusCode,
    int? rating,
    String? reference,
    List<Review>? reviews,
    List<String>? types,
    String? url,
    int? userRatingsTotal,
    int? utcOffset,
    String? vicinity,
    String? website,
  }) =>
      Result(
        addressComponents: addressComponents ?? this.addressComponents,
        adrAddress: adrAddress ?? this.adrAddress,
        businessStatus: businessStatus ?? this.businessStatus,
        formattedAddress: formattedAddress ?? this.formattedAddress,
        formattedPhoneNumber: formattedPhoneNumber ?? this.formattedPhoneNumber,
        geometry: geometry ?? this.geometry,
        icon: icon ?? this.icon,
        iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
        iconMaskBaseUri: iconMaskBaseUri ?? this.iconMaskBaseUri,
        internationalPhoneNumber:
            internationalPhoneNumber ?? this.internationalPhoneNumber,
        name: name ?? this.name,
        openingHours: openingHours ?? this.openingHours,
        photos: photos ?? this.photos,
        placeId: placeId ?? this.placeId,
        plusCode: plusCode ?? this.plusCode,
        rating: rating ?? this.rating,
        reference: reference ?? this.reference,
        reviews: reviews ?? this.reviews,
        types: types ?? this.types,
        url: url ?? this.url,
        userRatingsTotal: userRatingsTotal ?? this.userRatingsTotal,
        utcOffset: utcOffset ?? this.utcOffset,
        vicinity: vicinity ?? this.vicinity,
        website: website ?? this.website,
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        addressComponents: json["address_components"] == null
            ? []
            : List<AddressComponent>.from(json["address_components"]!
                .map((x) => AddressComponent.fromJson(x))),
        adrAddress: json["adr_address"],
        businessStatus: json["business_status"],
        formattedAddress: json["formatted_address"],
        formattedPhoneNumber: json["formatted_phone_number"],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor: json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        internationalPhoneNumber: json["international_phone_number"],
        name: json["name"],
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHours.fromJson(json["opening_hours"]),
        photos: json["photos"] == null
            ? []
            : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
        placeId: json["place_id"],
        plusCode: json["plus_code"] == null
            ? null
            : PlusCode.fromJson(json["plus_code"]),
        rating: json["rating"],
        reference: json["reference"],
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"]!.map((x) => x)),
        url: json["url"],
        userRatingsTotal: json["user_ratings_total"],
        utcOffset: json["utc_offset"],
        vicinity: json["vicinity"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "address_components": addressComponents == null
            ? []
            : List<dynamic>.from(addressComponents!.map((x) => x.toJson())),
        "adr_address": adrAddress,
        "business_status": businessStatus,
        "formatted_address": formattedAddress,
        "formatted_phone_number": formattedPhoneNumber,
        "geometry": geometry?.toJson(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "international_phone_number": internationalPhoneNumber,
        "name": name,
        "opening_hours": openingHours?.toJson(),
        "photos": photos == null
            ? []
            : List<dynamic>.from(photos!.map((x) => x.toJson())),
        "place_id": placeId,
        "plus_code": plusCode?.toJson(),
        "rating": rating,
        "reference": reference,
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
        "url": url,
        "user_ratings_total": userRatingsTotal,
        "utc_offset": utcOffset,
        "vicinity": vicinity,
        "website": website,
      };
}

class AddressComponent {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  AddressComponent copyWith({
    String? longName,
    String? shortName,
    List<String>? types,
  }) =>
      AddressComponent(
        longName: longName ?? this.longName,
        shortName: shortName ?? this.shortName,
        types: types ?? this.types,
      );

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
      };
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({
    this.location,
    this.viewport,
  });

  Geometry copyWith({
    Location? location,
    Viewport? viewport,
  }) =>
      Geometry(
        location: location ?? this.location,
        viewport: viewport ?? this.viewport,
      );

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        viewport: json["viewport"] == null
            ? null
            : Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "viewport": viewport?.toJson(),
      };
}

class Location {
  double? lat;
  double? lng;

  Location({
    this.lat,
    this.lng,
  });

  Location copyWith({
    double? lat,
    double? lng,
  }) =>
      Location(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({
    this.northeast,
    this.southwest,
  });

  Viewport copyWith({
    Location? northeast,
    Location? southwest,
  }) =>
      Viewport(
        northeast: northeast ?? this.northeast,
        southwest: southwest ?? this.southwest,
      );

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: json["northeast"] == null
            ? null
            : Location.fromJson(json["northeast"]),
        southwest: json["southwest"] == null
            ? null
            : Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast?.toJson(),
        "southwest": southwest?.toJson(),
      };
}

class OpeningHours {
  bool? openNow;
  List<Period>? periods;
  List<String>? weekdayText;

  OpeningHours({
    this.openNow,
    this.periods,
    this.weekdayText,
  });

  OpeningHours copyWith({
    bool? openNow,
    List<Period>? periods,
    List<String>? weekdayText,
  }) =>
      OpeningHours(
        openNow: openNow ?? this.openNow,
        periods: periods ?? this.periods,
        weekdayText: weekdayText ?? this.weekdayText,
      );

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"],
        periods: json["periods"] == null
            ? []
            : List<Period>.from(
                json["periods"]!.map((x) => Period.fromJson(x))),
        weekdayText: json["weekday_text"] == null
            ? []
            : List<String>.from(json["weekday_text"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
        "periods": periods == null
            ? []
            : List<dynamic>.from(periods!.map((x) => x.toJson())),
        "weekday_text": weekdayText == null
            ? []
            : List<dynamic>.from(weekdayText!.map((x) => x)),
      };
}

class Period {
  Close? close;
  Close? open;

  Period({
    this.close,
    this.open,
  });

  Period copyWith({
    Close? close,
    Close? open,
  }) =>
      Period(
        close: close ?? this.close,
        open: open ?? this.open,
      );

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        close: json["close"] == null ? null : Close.fromJson(json["close"]),
        open: json["open"] == null ? null : Close.fromJson(json["open"]),
      );

  Map<String, dynamic> toJson() => {
        "close": close?.toJson(),
        "open": open?.toJson(),
      };
}

class Close {
  int? day;
  String? time;

  Close({
    this.day,
    this.time,
  });

  Close copyWith({
    int? day,
    String? time,
  }) =>
      Close(
        day: day ?? this.day,
        time: time ?? this.time,
      );

  factory Close.fromJson(Map<String, dynamic> json) => Close(
        day: json["day"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "time": time,
      };
}

class Photo {
  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  Photo({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  Photo copyWith({
    int? height,
    List<String>? htmlAttributions,
    String? photoReference,
    int? width,
  }) =>
      Photo(
        height: height ?? this.height,
        htmlAttributions: htmlAttributions ?? this.htmlAttributions,
        photoReference: photoReference ?? this.photoReference,
        width: width ?? this.width,
      );

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"],
        htmlAttributions: json["html_attributions"] == null
            ? []
            : List<String>.from(json["html_attributions"]!.map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions": htmlAttributions == null
            ? []
            : List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
      };
}

class PlusCode {
  String? compoundCode;
  String? globalCode;

  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  PlusCode copyWith({
    String? compoundCode,
    String? globalCode,
  }) =>
      PlusCode(
        compoundCode: compoundCode ?? this.compoundCode,
        globalCode: globalCode ?? this.globalCode,
      );

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
      );

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
      };
}

class Review {
  String? authorName;
  String? authorUrl;
  String? language;
  String? profilePhotoUrl;
  int? rating;
  String? relativeTimeDescription;
  String? text;
  int? time;

  Review({
    this.authorName,
    this.authorUrl,
    this.language,
    this.profilePhotoUrl,
    this.rating,
    this.relativeTimeDescription,
    this.text,
    this.time,
  });

  Review copyWith({
    String? authorName,
    String? authorUrl,
    String? language,
    String? profilePhotoUrl,
    int? rating,
    String? relativeTimeDescription,
    String? text,
    int? time,
  }) =>
      Review(
        authorName: authorName ?? this.authorName,
        authorUrl: authorUrl ?? this.authorUrl,
        language: language ?? this.language,
        profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
        rating: rating ?? this.rating,
        relativeTimeDescription:
            relativeTimeDescription ?? this.relativeTimeDescription,
        text: text ?? this.text,
        time: time ?? this.time,
      );

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        authorName: json["author_name"],
        authorUrl: json["author_url"],
        language: json["language"],
        profilePhotoUrl: json["profile_photo_url"],
        rating: json["rating"],
        relativeTimeDescription: json["relative_time_description"],
        text: json["text"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "author_name": authorName,
        "author_url": authorUrl,
        "language": language,
        "profile_photo_url": profilePhotoUrl,
        "rating": rating,
        "relative_time_description": relativeTimeDescription,
        "text": text,
        "time": time,
      };
  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}
