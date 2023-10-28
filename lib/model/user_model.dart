// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String message;
    Data data;

    UserModel({
        required this.message,
        required this.data,
    });

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
    String token;
    User user;

    Data({
        required this.token,
        required this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
    };
}

class User {
    int id;
    String email;
    String name;
    String firstName;
    String lastName;
    String phoneNumber;
    bool isLinkedinUser;
    DateTime createdAt;
    bool isVerified;

    User({
        required this.id,
        required this.email,
        required this.name,
        required this.firstName,
        required this.lastName,
        required this.phoneNumber,
        required this.isLinkedinUser,
        required this.createdAt,
        required this.isVerified,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        isLinkedinUser: json["is_linkedin_user"],
        createdAt: DateTime.parse(json["createdAt"]),
        isVerified: json["isVerified"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "is_linkedin_user": isLinkedinUser,
        "createdAt": createdAt.toIso8601String(),
        "isVerified": isVerified,
    };
}
