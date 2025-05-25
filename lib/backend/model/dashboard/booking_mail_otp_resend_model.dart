// To parse this JSON data, do
//
//     final bookingMailOtpResendModel = bookingMailOtpResendModelFromJson(jsonString);

import 'dart:convert';

BookingMailOtpResendModel bookingMailOtpResendModelFromJson(String str) =>
    BookingMailOtpResendModel.fromJson(json.decode(str));

String bookingMailOtpResendModelToJson(BookingMailOtpResendModel data) =>
    json.encode(data.toJson());

class BookingMailOtpResendModel {
  Message message;
  Data data;
  String type;

  BookingMailOtpResendModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory BookingMailOtpResendModel.fromJson(Map<String, dynamic> json) =>
      BookingMailOtpResendModel(
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

  Data({
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}

class Message {
  Success success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: Success.fromJson(json["success"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success.toJson(),
      };
}

class Success {
  List<String> success;

  Success({
    required this.success,
  });

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
