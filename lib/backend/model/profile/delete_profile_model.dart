
import 'dart:convert';

DeleteAccountModel deleteAccountModelFromJson(String str) => DeleteAccountModel.fromJson(json.decode(str));

String deleteAccountModelToJson(DeleteAccountModel data) => json.encode(data.toJson());

class DeleteAccountModel {
  final Message message;
  final Data data;
  final String type;

  DeleteAccountModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) => DeleteAccountModel(
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
  final int id;


  Data({
    required this.id,

  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,

  };
}

class Address {
  final dynamic state;


  Address({
    required this.state,

  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    state: json["state"] ?? '',

  );

  Map<String, dynamic> toJson() => {
    "state": state,

  };
}

class StringStatus {
  final dynamic stringStatusClass;


  StringStatus({
    required this.stringStatusClass,

  });

  factory StringStatus.fromJson(Map<String, dynamic> json) => StringStatus(
    stringStatusClass: json["class"] ?? '',

  );

  Map<String, dynamic> toJson() => {
    "class": stringStatusClass,

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
