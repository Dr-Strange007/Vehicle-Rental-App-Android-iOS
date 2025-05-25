import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  final Message message;
  final Data data;
  final String type;

  SignUpModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
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
  final String token;
  final UserInfo userInfo;
  final Authorization authorization;

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
  final bool status;
  final String token;

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
  final int id;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final String country;
  final String mobileCode;
  final int emailVerified;

  UserInfo({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.country,
    required this.mobileCode,
    required this.emailVerified,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        country: json["country"],
        mobileCode: json["mobile_code"],
        emailVerified: json["email_verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "country": country,
        "mobile_code": mobileCode,
        "email_verified": emailVerified,
      };
}

class Message {
  final List<String> success;

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
