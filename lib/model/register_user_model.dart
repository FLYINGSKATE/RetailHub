// To parse this JSON data, do
//
//     final registerUserModel = registerUserModelFromJson(jsonString);

import 'dart:convert';

RegisterUserModel registerUserModelFromJson(String str) => RegisterUserModel.fromJson(json.decode(str));

String registerUserModelToJson(RegisterUserModel data) => json.encode(data.toJson());

class RegisterUserModel {
    RegisterUserModel({
        required this.message,
        required this.user,
        required this.success,
    });

    String message;
    User user;
    bool success;

    factory RegisterUserModel.fromJson(Map<String, dynamic> json) => RegisterUserModel(
        message: json["message"],
        user: User.fromJson(json["user"]),
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
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
