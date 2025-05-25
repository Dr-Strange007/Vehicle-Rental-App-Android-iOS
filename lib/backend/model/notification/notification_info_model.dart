// To parse this JSON data, do
//
//     final notificationInfoModel = notificationInfoModelFromJson(jsonString);

import 'dart:convert';

NotificationInfoModel notificationInfoModelFromJson(String str) =>
    NotificationInfoModel.fromJson(json.decode(str));

String notificationInfoModelToJson(NotificationInfoModel data) =>
    json.encode(data.toJson());

class NotificationInfoModel {
  NotificationInfoModelMessage message;
  Data data;
  String type;

  NotificationInfoModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory NotificationInfoModel.fromJson(Map<String, dynamic> json) =>
      NotificationInfoModel(
        message: NotificationInfoModelMessage.fromJson(json["message"]),
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
  List<Notification> notifications;

  Data({
    required this.notifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
      };
}

class Notification {
  int id;
  int userId;
  dynamic type;
  NotificationMessage message;
  DateTime createdAt;
  DateTime updatedAt;

  Notification({
    required this.id,
    required this.userId,
    required this.type,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        message:  NotificationMessage.fromJson(json["message"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "message": message.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class NotificationMessage {
  String title;
  String message;

  NotificationMessage({
    required this.title,
    required this.message,
  });

  factory NotificationMessage.fromJson(Map<String, dynamic> json) =>
      NotificationMessage(
        title: json["title"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
      };
}

class NotificationInfoModelMessage {
  List<String> success;

  NotificationInfoModelMessage({
    required this.success,
  });

  factory NotificationInfoModelMessage.fromJson(Map<String, dynamic> json) =>
      NotificationInfoModelMessage(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
