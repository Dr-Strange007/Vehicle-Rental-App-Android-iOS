class HistoryModel {
  Message message;
  List<Datum> data;
  String type;

  HistoryModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        message: Message.fromJson(json["message"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        type: json["type"],
      );
}

class Datum {
  int id;
  int carId;
  int userId;
  dynamic slug;
  dynamic phone;
  dynamic email;
  dynamic location;
  dynamic destination;
  dynamic pickupTime;
  dynamic roundPickupTime;
  DateTime pickupDate;
  dynamic roundPickupDate;
  dynamic message;
  int status;

  Cars cars;
  User user;

  Datum({
    required this.id,
    required this.carId,
    required this.userId,
    required this.slug,
    required this.phone,
    required this.email,
    required this.location,
    required this.destination,
    required this.pickupTime,
    required this.roundPickupTime,
    required this.pickupDate,
    required this.roundPickupDate,
    required this.message,
    required this.status,
   
    required this.cars,
    required this.user,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        carId: json["car_id"],
        userId: json["user_id"],
        slug: json["slug"] ?? '',
        phone: json["phone"] ?? '',
        email: json["email"] ?? '',
        location: json["location"] ?? '',
        destination: json["destination"] ?? '',
        pickupTime: json["pickup_time"] ?? '',
        roundPickupTime: json["round_pickup_time"] ?? '',
        pickupDate: DateTime.parse(json["pickup_date"]),
        roundPickupDate: json["round_pickup_date"] ?? '',
        message: json["message"] ?? '',
        status: json["status"],
       
        cars: Cars.fromJson(json["cars"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "car_id": carId,
        "user_id": userId,
        "slug": slug,
        "phone": phone,
        "email": email,
        "location": location,
        "destination": destination,
        "pickup_time": pickupTime,
        "round_pickup_time": roundPickupTime,
        "pickup_date":
            "${pickupDate.year.toString().padLeft(4, '0')}-${pickupDate.month.toString().padLeft(2, '0')}-${pickupDate.day.toString().padLeft(2, '0')}",
        "round_pickup_date": roundPickupDate,
        "message": message,
        "status": status,
        
        "cars": cars.toJson(),
        "user": user.toJson(),
      };
}

class Cars {
  int id;
  int carAreaId;
  int carTypeId;
  dynamic slug;
  dynamic carModel;
  int seat;
  int experience;
  dynamic carNumber;
  dynamic fees;
  dynamic image;
  int status;


  Cars({
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

  factory Cars.fromJson(Map<String, dynamic> json) => Cars(
        id: json["id"],
        carAreaId: json["car_area_id"],
        carTypeId: json["car_type_id"],
        slug: json["slug"],
        carModel: json["car_model"] ?? '',
        seat: json["seat"] ?? '',
        experience: json["experience"],
        carNumber: json["car_number"],
        fees: json["fees"] ?? '',
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

class User {
  int id;
  dynamic firstname;
  dynamic lastname;
  dynamic username;
  dynamic email;
  dynamic mobileCode;
  dynamic mobile;
  dynamic fullMobile;
  dynamic image;
  int status;
  dynamic address;
  dynamic country;
  int emailVerified;
  dynamic verCode;
  dynamic verCodeSendAt;
  dynamic deviceId;
  dynamic emailVerifiedAt;
  dynamic deletedAt;
  DateTime createdAt;
  dynamic updatedAt;
  dynamic fullname;
  dynamic userImage;
 
  dynamic lastLogin;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.mobileCode,
    required this.mobile,
    required this.fullMobile,
    required this.image,
    required this.status,
    required this.address,
    required this.country,
    required this.emailVerified,
    required this.verCode,
    required this.verCodeSendAt,
    required this.deviceId,
    required this.emailVerifiedAt,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.fullname,
    required this.userImage,
    required this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        mobileCode: json["mobile_code"] ?? '',
        mobile: json["mobile"] ?? '',
        fullMobile: json["full_mobile"] ?? '',
        image: json["image"] ?? '',
        status: json["status"],
        address: json["address"] ?? '',
        country: json["country"] ?? '',
        emailVerified: json["email_verified"],
        verCode: json["ver_code"] ?? '',
        verCodeSendAt: json["ver_code_send_at"] ?? '',
        deviceId: json["device_id"] ?? '',
        emailVerifiedAt: json["email_verified_at"] ?? '',
        deletedAt: json["deleted_at"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] ?? '',
        fullname: json["fullname"] ?? '',
        userImage: json["userImage"] ?? '',
        lastLogin: json["lastLogin"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "mobile_code": mobileCode,
        "mobile": mobile,
        "full_mobile": fullMobile,
        "image": image,
        "status": status,
        "address": address,
        "country": country,
        "email_verified": emailVerified,
        "ver_code": verCode,
        "ver_code_send_at": verCodeSendAt,
        "device_id": deviceId,
        "email_verified_at": emailVerifiedAt,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "fullname": fullname,
        "userImage": userImage,

        "lastLogin": lastLogin,
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
