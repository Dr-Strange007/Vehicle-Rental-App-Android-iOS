import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModelMessage message;
  Data data;
  String type;

  NotificationModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        message: NotificationModelMessage.fromJson(json["message"]),
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
        message: NotificationMessage.fromJson(json["message"]),
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

class NotificationModelMessage {
  List<String> success;

  NotificationModelMessage({
    required this.success,
  });

  factory NotificationModelMessage.fromJson(Map<String, dynamic> json) =>
      NotificationModelMessage(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
