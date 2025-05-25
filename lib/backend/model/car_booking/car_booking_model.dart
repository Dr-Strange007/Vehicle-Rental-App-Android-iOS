import 'dart:convert';

CarBookingModel carBookingModelFromJson(String str) =>
    CarBookingModel.fromJson(json.decode(str));

String carBookingModelToJson(CarBookingModel data) =>
    json.encode(data.toJson());

class CarBookingModel {
  Message message;
  CarBookingModelData data;
  String type;

  CarBookingModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory CarBookingModel.fromJson(Map<String, dynamic> json) =>
      CarBookingModel(
        message: Message.fromJson(json["message"]),
        data: CarBookingModelData.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
      };
}

class CarBookingModelData {
  String token;
  DataData data;

  CarBookingModelData({
    required this.token,
    required this.data,
  });

  factory CarBookingModelData.fromJson(Map<String, dynamic> json) =>
      CarBookingModelData(
        token: json["token"],
        data: DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "data": data.toJson(),
      };
}

class DataData {
  String car;
  String location;
  String destination;
  String credentials;
  String pickupTime;
  DateTime pickupDate;
  String mobile;
  dynamic roundPickupDate;
  dynamic roundPickupTime;
  dynamic message;
  String email;
  String phone;
  String slug;
  dynamic userId;
  int carId;

  DataData({
    required this.car,
    required this.location,
    required this.destination,
    required this.credentials,
    required this.pickupTime,
    required this.pickupDate,
    required this.mobile,
    required this.roundPickupDate,
    required this.roundPickupTime,
    required this.message,
    required this.email,
    required this.phone,
    required this.slug,
    required this.userId,
    required this.carId,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        car: json["car"],
        location: json["location"],
        destination: json["destination"],
        credentials: json["credentials"],
        pickupTime: json["pickup_time"],
        pickupDate: DateTime.parse(json["pickup_date"]),
        mobile: json["mobile"],
        roundPickupDate: json["round_pickup_date"] ?? '',
        roundPickupTime: json["round_pickup_time"] ?? '',
        message: json["message"],
        email: json["email"],
        phone: json["phone"],
        slug: json["slug"],
        userId: json["user_id"],
        carId: json["car_id"],
      );

  Map<String, dynamic> toJson() => {
        "car": car,
        "location": location,
        "destination": destination,
        "credentials": credentials,
        "pickup_time": pickupTime,
        "pickup_date":
            "${pickupDate.year.toString().padLeft(4, '0')}-${pickupDate.month.toString().padLeft(2, '0')}-${pickupDate.day.toString().padLeft(2, '0')}",
        "mobile": mobile,
        "round_pickup_date": roundPickupDate,
        "round_pickup_time": roundPickupTime,
        "message": message,
        "email": email,
        "phone": phone,
        "slug": slug,
        "user_id": userId,
        "car_id": carId,
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
