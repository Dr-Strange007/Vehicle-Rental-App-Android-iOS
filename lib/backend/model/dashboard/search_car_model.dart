// To parse this JSON data, do
//
//     final searchCarModel = searchCarModelFromJson(jsonString);

import 'dart:convert';

SearchCarModel searchCarModelFromJson(String str) =>
    SearchCarModel.fromJson(json.decode(str));

String searchCarModelToJson(SearchCarModel data) => json.encode(data.toJson());

class SearchCarModel {
  Message message;
  Data data;
  String type;

  SearchCarModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory SearchCarModel.fromJson(Map<String, dynamic> json) => SearchCarModel(
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
  Cars cars;

  Data({
    required this.cars,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cars: Cars.fromJson(json["cars"]),
      );

  Map<String, dynamic> toJson() => {
        "cars": cars.toJson(),
      };
}

class Cars {
  String baseUrl;
  String imagePath;
  List<Car> cars;

  Cars({
    required this.baseUrl,
    required this.imagePath,
    required this.cars,
  });

  factory Cars.fromJson(Map<String, dynamic> json) => Cars(
        baseUrl: json["base_url"],
        imagePath: json["image_path"],
        cars: List<Car>.from(json["cars"].map((x) => Car.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "base_url": baseUrl,
        "image_path": imagePath,
        "cars": List<dynamic>.from(cars.map((x) => x.toJson())),
      };
}

class Car {
  int id;
  int carAreaId;
  int carTypeId;
  String slug;
  String carModel;
  int seat;
  int experience;
  String carNumber;
  String fees;
  dynamic image;
  int status;

  Car({
    required this.id,
    required this.carAreaId,
    required this.carTypeId,
    required this.slug,
    required this.carModel,
    required this.seat,
    required this.experience,
    required this.carNumber,
    required this.fees,
    required this.image,
    required this.status,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        carAreaId: json["car_area_id"],
        carTypeId: json["car_type_id"],
        slug: json["slug"],
        carModel: json["car_model"],
        seat: json["seat"],
        experience: json["experience"],
        carNumber: json["car_number"],
        fees: json["fees"],
        image: json["image"] ?? '',
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "car_area_id": carAreaId,
        "car_type_id": carTypeId,
        "slug": slug,
        "car_model": carModel,
        "seat": seat,
        "experience": experience,
        "car_number": carNumber,
        "fees": fees,
        "image": image,
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
