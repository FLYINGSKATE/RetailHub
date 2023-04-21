// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.message,
        required this.data,
    });

    String message;
    Data data;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.token,
        required this.user,
        required this.success,
    });

    String token;
    User user;
    bool success;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
        "success": success,
    };
}

class User {
    User({
        required this.id,
        required this.email,
        required this.name,
        required this.firstName,
        required this.lastName,
        required this.createdAt,
        required this.isVerified,
    });

    int id;
    String email;
    String name;
    String firstName;
    String lastName;
    DateTime createdAt;
    bool isVerified;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        createdAt: DateTime.parse(json["createdAt"]),
        isVerified: json["isVerified"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "createdAt": createdAt.toIso8601String(),
        "isVerified": isVerified,
    };
}
