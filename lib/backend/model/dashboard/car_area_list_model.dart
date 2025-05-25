import 'dart:convert';

CarAreaListModel carAreaListModelFromJson(String str) =>
    CarAreaListModel.fromJson(json.decode(str));

String carAreaListModelToJson(CarAreaListModel data) =>
    json.encode(data.toJson());

class CarAreaListModel {
  Message message;
  List<Datum> data;
  String type;

  CarAreaListModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory CarAreaListModel.fromJson(Map<String, dynamic> json) =>
      CarAreaListModel(
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
  String name;
  String slug;
  int status;

  Datum({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
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
