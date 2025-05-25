// To parse this JSON data, do
//
//     final bookingVerifyModel = bookingVerifyModelFromJson(jsonString);

import 'dart:convert';

BookingVerifyModel bookingVerifyModelFromJson(String str) =>
    BookingVerifyModel.fromJson(json.decode(str));

String bookingVerifyModelToJson(BookingVerifyModel data) =>
    json.encode(data.toJson());

class BookingVerifyModel {
  Message message;
  List<dynamic> data;
  String type;

  BookingVerifyModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory BookingVerifyModel.fromJson(Map<String, dynamic> json) =>
      BookingVerifyModel(
        message: Message.fromJson(json["message"]),
        data: List<dynamic>.from(json["data"].map((x) => x)),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": List<dynamic>.from(data.map((x) => x)),
        "type": type,
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
