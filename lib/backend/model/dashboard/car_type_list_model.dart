// To parse this JSON data, do
//
//     final carTypeListModel = carTypeListModelFromJson(jsonString);

import 'dart:convert';

CarTypeListModel carTypeListModelFromJson(String str) =>
    CarTypeListModel.fromJson(json.decode(str));

String carTypeListModelToJson(CarTypeListModel data) =>
    json.encode(data.toJson());

class CarTypeListModel {
  Message message;
  List<Datum> data;
  String type;

  CarTypeListModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory CarTypeListModel.fromJson(Map<String, dynamic> json) =>
      CarTypeListModel(
        message: Message.fromJson(json["message"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "type": type,
      };
}

class Datum {
  int id;
  String slug;
  String name;
  int status;

  Datum({
    required this.id,
    required this.slug,
    required this.name,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "status": status,
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
