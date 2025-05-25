// import 'dart:convert';
//todo remove comment
// SignInModel signInModelFromJson(String str) =>
//     SignInModel.fromJson(json.decode(str));
//
// String signInModelToJson(SignInModel data) => json.encode(data.toJson());
//
// class SignInModel {
//   Message message;
//   Data data;
//
//   SignInModel({
//     required this.message,
//     required this.data,
//   });
//
//   factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
//         message: Message.fromJson(json["message"]),
//         data: Data.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "message": message.toJson(),
//         "data": data.toJson(),
//       };
// }
//
// class Data {
//   String token;
//   User user;
//
//   Data({
//     required this.token,
//     required this.user,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         token: json["token"],
//         user: User.fromJson(json["user"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "token": token,
//         "user": user.toJson(),
//       };
// }
//
// class User {
//   int id;
//   String email;
//   int emailVerified;
//   int smsVerified;
//   int kycVerified;
//   int twoFactorVerified;
//   int twoFactorStatus;
//
//   User({
//     required this.id,
//     required this.email,
//     required this.emailVerified,
//     required this.smsVerified,
//     required this.kycVerified,
//     required this.twoFactorVerified,
//     required this.twoFactorStatus,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         email: json["email"],
//         emailVerified: json["email_verified"],
//         smsVerified: json["sms_verified"],
//         kycVerified: json["kyc_verified"],
//         twoFactorVerified: json["two_factor_verified"],
//         twoFactorStatus: json["two_factor_status"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "email": email,
//         "email_verified": emailVerified,
//         "sms_verified": smsVerified,
//         "kyc_verified": kycVerified,
//         "two_factor_verified": twoFactorVerified,
//         "two_factor_status": twoFactorStatus,
//       };
// }
//
// class Message {
//   List<String> success;
//
//   Message({
//     required this.success,
//   });
//
//   factory Message.fromJson(Map<String, dynamic> json) => Message(
//         success: List<String>.from(json["success"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "success": List<dynamic>.from(success.map((x) => x)),
//       };
// }
// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

SignInModel signInModelFromJson(String str) =>
    SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  Message message;
  Data data;
  String type;

  SignInModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
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
  String token;
  UserInfo userInfo;
  Authorization authorization;

  Data({
    required this.token,
    required this.userInfo,
    required this.authorization,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        userInfo: UserInfo.fromJson(json["user_info"]),
        authorization: Authorization.fromJson(json["authorization"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user_info": userInfo.toJson(),
        "authorization": authorization.toJson(),
      };
}

class Authorization {
  bool status;
  String token;

  Authorization({
    required this.status,
    required this.token,
  });

  factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
        status: json["status"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
      };
}

class UserInfo {
  int id;
  String firstname;
  String lastname;
  String username;
  String email;
  int emailVerified;

  UserInfo({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.emailVerified,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        emailVerified: json["email_verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "email_verified": emailVerified,
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
