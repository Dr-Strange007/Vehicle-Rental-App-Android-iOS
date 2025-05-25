// To parse this JSON data, do
//
//     final carAreaTypeModel = carAreaTypeModelFromJson(jsonString);

import 'dart:convert';

CarAreaTypeModel carAreaTypeModelFromJson(String str) =>
    CarAreaTypeModel.fromJson(json.decode(str));

String carAreaTypeModelToJson(CarAreaTypeModel data) =>
    json.encode(data.toJson());

class CarAreaTypeModel {
  Message message;
  Data data;
  String type;

  CarAreaTypeModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory CarAreaTypeModel.fromJson(Map<String, dynamic> json) =>
      CarAreaTypeModel(
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
  Area area;

  Data({
    required this.area,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        area: Area.fromJson(json["area"]),
      );

  Map<String, dynamic> toJson() => {
        "area": area.toJson(),
      };
}

class Type {
  int id;
  int carAreaId;
  int carTypeId;

  Area type;

  Type({
    required this.id,
    required this.carAreaId,
    required this.carTypeId,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        carAreaId: json["car_area_id"],
        carTypeId: json["car_type_id"],
        type: Area.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "car_area_id": carAreaId,
        "car_type_id": carTypeId,
        "type": type.toJson(),
      };
}

class Area {
  int id;
  String name;
  String slug;
  int status;
  int lastEditBy;

  List<Type> types;

  Area({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.lastEditBy,
    required this.types,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        status: json["status"],
        lastEditBy: json["last_edit_by"],
        types: json["types"] != null
            ? List<Type>.from(json["types"].map((x) => Type.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "status": status,
        "last_edit_by": lastEditBy,
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
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
