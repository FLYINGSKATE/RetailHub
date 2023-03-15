// To parse this JSON data, do
//
//     final blogModel = blogModelFromJson(jsonString);

import 'dart:convert';

BlogModel? blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));

String blogModelToJson(BlogModel? data) => json.encode(data!.toJson());

class BlogModel {
    BlogModel({
        required this.status,
        required this.message,
        required this.data,
    });

    String? status;
    String? message;
    List<Datum?>? data;

    factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    };
}

class Datum {
    Datum({
        required this.id,
        required this.newsTitle,
        required this.newsDesc,
        required this.imageUrl,
        required this.status,
        required this.date,
    });

    String? id;
    String? newsTitle;
    String? newsDesc;
    String? imageUrl;
    String? status;
    DateTime? date;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        newsTitle: json["news_title"],
        newsDesc: json["news_desc"],
        imageUrl: json["image_url"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "news_title": newsTitle,
        "news_desc": newsDesc,
        "image_url": imageUrl,
        "status": status,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    };
}
