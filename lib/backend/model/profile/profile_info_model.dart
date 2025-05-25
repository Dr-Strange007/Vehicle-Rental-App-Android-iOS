// To parse this JSON data, do
//
//     final profileInfoModel = profileInfoModelFromJson(jsonString);

import 'dart:convert';

ProfileInfoModel profileInfoModelFromJson(String str) =>
    ProfileInfoModel.fromJson(json.decode(str));

String profileInfoModelToJson(ProfileInfoModel data) =>
    json.encode(data.toJson());

class ProfileInfoModel {
  Message message;
  Data data;
  String type;

  ProfileInfoModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory ProfileInfoModel.fromJson(Map<String, dynamic> json) =>
      ProfileInfoModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
      };
}

class Data {
  UserInfo userInfo;
  String pageTitle;

  Data({
    required this.userInfo,
    required this.pageTitle,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userInfo: UserInfo.fromJson(json["user_info"]),
        pageTitle: json["page_title"],
      );

  Map<String, dynamic> toJson() => {
        "user_info": userInfo.toJson(),
        "page_title": pageTitle,
      };
}

class UserInfo {
  String firstname;
  String lastname;
  String email;
  String mobileCode;
  String mobile;
  String fullMobile;
  dynamic image;
  Address address;
  String country;
  int emailVerified;
  String fullname;
  dynamic userImage;

  UserInfo({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.mobileCode,
    required this.mobile,
    required this.fullMobile,
    required this.image,
    required this.address,
    required this.country,
    required this.fullname,
    required this.emailVerified,
    required this.userImage
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        mobileCode: json["mobile_code"] ?? "",
        mobile: json["mobile"] ?? "",
        fullMobile: json["full_mobile"] ?? "",
        image: json["image"],
        address: Address.fromJson(json["address"]?? Address(state: "", city: "", zip: "", address: "").toJson()),
        country: json["country"] ?? '',
    fullname: json["fullname"] ?? '',
    userImage: json["userImage"] ?? '',
        emailVerified: json["email_verified"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "mobile_code": mobileCode,
        "mobile": mobile,
        "full_mobile": fullMobile,
        "image": image,
        "address": address.toJson(),
        "country": country,
        "email_verified": emailVerified,
        "fullname": fullname,
        "userImage": userImage
      };
}

class Address {
  String state;
  String city;
  String zip;
  String address;

  Address({
    required this.state,
    required this.city,
    required this.zip,
    required this.address,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        state: json["state"] ?? "",
        city: json["city"] ?? "",
        zip: json["zip"] ?? "",
        address: json["address"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "city": city,
        "zip": zip,
        "address": address,
      };
}

class StringStatus {
  String stringStatusClass;
  String value;

  StringStatus({
    required this.stringStatusClass,
    required this.value,
  });

  factory StringStatus.fromJson(Map<String, dynamic> json) => StringStatus(
        stringStatusClass: json["class"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "class": stringStatusClass,
        "value": value,
      };
}

class Message {
  List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
