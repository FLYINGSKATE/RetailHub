// To parse this JSON data, do
//
//     final coWorkingModel = coWorkingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CoWorkingModel coWorkingModelFromJson(String str) => CoWorkingModel.fromJson(json.decode(str));

String coWorkingModelToJson(CoWorkingModel data) => json.encode(data.toJson());

class CoWorkingModel {
    CoWorkingModel({
        required this.record,
        required this.metadata,
    });

    Record record;
    Metadata metadata;

    factory CoWorkingModel.fromJson(Map<String, dynamic> json) => CoWorkingModel(
        record: Record.fromJson(json["record"]),
        metadata: Metadata.fromJson(json["metadata"]),
    );

    Map<String, dynamic> toJson() => {
        "record": record.toJson(),
        "metadata": metadata.toJson(),
    };
}

class Metadata {
    Metadata({
        required this.id,
        required this.private,
        required this.createdAt,
    });

    String id;
    bool private;
    DateTime createdAt;

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        id: json["id"],
        private: json["private"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "private": private,
        "createdAt": createdAt.toIso8601String(),
    };
}

class Record {
    Record({
        required this.status,
        required this.message,
        required this.data,
    });

    int status;
    String message;
    List<Datum> data;

    factory Record.fromJson(Map<String, dynamic> json) => Record(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.title,
        required this.desc,
        required this.imgur,
        required this.id,
        required this.articleurl,
    });

    String title;
    String desc;
    String imgur;
    String id;
    String articleurl;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        desc: json["desc"],
        imgur: json["imgur"],
        id: json["id"],
        articleurl: json["articleurl"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "desc": desc,
        "imgur": imgur,
        "id": id,
        "articleurl": articleurl,
    };
}
