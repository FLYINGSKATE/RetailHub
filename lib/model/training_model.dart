// To parse this JSON data, do
//
//     final trainingModel = trainingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<TrainingModel> trainingModelFromJson(String str) => List<TrainingModel>.from(json.decode(str).map((x) => TrainingModel.fromJson(x)));

String trainingModelToJson(List<TrainingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrainingModel {
    TrainingModel({
        required this.id,
        required this.title,
        required this.desc,
        required this.imgur,
        required this.articleurl,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String title;
    String desc;
    String imgur;
    String articleurl;
    DateTime createdAt;
    DateTime updatedAt;

    factory TrainingModel.fromJson(Map<String, dynamic> json) => TrainingModel(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        imgur: json["imgur"],
        articleurl: json["articleurl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "imgur": imgur,
        "articleurl": articleurl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
