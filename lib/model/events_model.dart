// To parse this JSON data, do
//
//     final eventsModel = eventsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<EventsModel> eventsModelFromJson(String str) => List<EventsModel>.from(json.decode(str).map((x) => EventsModel.fromJson(x)));

String eventsModelToJson(List<EventsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventsModel {
    EventsModel({
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

    factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
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
