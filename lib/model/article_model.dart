// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ArticleModel articleModelFromJson(String str) => ArticleModel.fromJson(json.decode(str));

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel {
    ArticleModel({
        required this.success,
        required this.message,
        required this.data,
    });

    bool success;
    String message;
    List<Datum> data;

    factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.id,
        required this.body,
        required this.date,
        required this.description,
        required this.isdeleted,
        required this.articlesLink,
        required this.title,
        required this.fileId,
        required this.startUpId,
        required this.imagedata,
        required this.imageName,
        required this.imageType,
        required this.tags,
        required this.areaInterest,
        required this.image,
    });

    String id;
    String body;
    DateTime date;
    String description;
    bool isdeleted;
    String articlesLink;
    String title;
    String fileId;
    String startUpId;
    dynamic imagedata;
    String imageName;
    dynamic imageType;
    dynamic tags;
    dynamic areaInterest;
    Image image;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        body: json["body"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
        isdeleted: json["isdeleted"],
        articlesLink: json["articles_link"],
        title: json["title"],
        fileId: json["file_id"],
        startUpId: json["start_up_id"],
        imagedata: json["imagedata"],
        imageName: json["image_name"]??"",
        imageType: json["image_type"]??"",
        tags: json["tags"]??"",
        areaInterest: json["area_interest"]??"",
        image: Image.fromJson(json["image"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "date": date.toIso8601String(),
        "description": description,
        "isdeleted": isdeleted,
        "articles_link": articlesLink,
        "title": title,
        "file_id": fileId,
        "start_up_id": startUpId,
        "imagedata": imagedata,
        "image_name": imageName,
        "image_type": imageType,
        "tags": tags,
        "area_interest": areaInterest,
        "image": image.toJson(),
    };
}

class Image {
    Image({
        required this.id,
        required this.extension,
        required this.filename,
        required this.filenameOnDisk,
        required this.size,
        required this.userId,
        required this.thumbnailId,
        required this.pdfId,
        required this.previewId,
    });

    String id;
    String extension;
    String filename;
    String filenameOnDisk;
    String size;
    String userId;
    dynamic thumbnailId;
    dynamic pdfId;
    dynamic previewId;

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        extension: json["extension"],
        filename: json["filename"],
        filenameOnDisk: json["filename_on_disk"],
        size: json["size"],
        userId: json["user_id"],
        thumbnailId: json["thumbnail_id"],
        pdfId: json["pdf_id"],
        previewId: json["preview_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "extension": extension,
        "filename": filename,
        "filename_on_disk": filenameOnDisk,
        "size": size,
        "user_id": userId,
        "thumbnail_id": thumbnailId,
        "pdf_id": pdfId,
        "preview_id": previewId,
    };
}
