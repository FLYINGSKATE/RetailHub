// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';

ArticleModel articleModelFromJson(String str) => ArticleModel.fromJson(json.decode(str));

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel {
    ArticleModel({
        required this.data,
        required this.message,
    });

    List<Datum> data;
    String message;

    factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
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
        this.fileId,
        required this.startUpId,
        this.imagedata,
        required this.imageName,
        this.imageType,
        required this.areaInterest,
        required this.restricted,
        required this.createdAt,
        required this.updatedAt,
        required this.startup,
        required this.tags,
    });

    String id;
    String body;
    DateTime date;
    String description;
    bool isdeleted;
    String articlesLink;
    String title;
    dynamic? fileId;
    String startUpId;
    dynamic? imagedata;
    String imageName;
    dynamic? imageType;
    dynamic areaInterest;
    String restricted;
    DateTime createdAt;
    DateTime updatedAt;
    Startup? startup;
    var tags;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"].toString(),
        body: json["body"]??'',
        date: DateTime.parse(json["date"]),
        description: json["description"],
        isdeleted: json["isdeleted"],
        articlesLink: json["articles_link"],
        title: json["title"],
        fileId: json["file_id"]??"",
        startUpId: json["start_up_id"],
        imagedata: json["imagedata"]??"",
        imageName: json["image_name"],
        imageType: json["image_type"]??"",
        areaInterest: json["area_interest"],
        restricted: json["restricted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        startup: Startup.fromJson(json["startup"]),
        tags: json["tags"]??[],
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
        "area_interest": areaInterest,
        "restricted": restricted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "startup": startup?.toJson(),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    };
}

class AreaInterestElement {
    AreaInterestElement({
        required this.id,
        required this.name,
        required this.parentNames,
        required this.parentId,
        required this.isCustom,
        required this.createdAt,
        required this.updatedAt,
        this.childHeader,
        required this.weight,
        required this.countUsingStartupInCategories,
        required this.countUsingStartupInAreasOfInterest,
        required this.countUsingRetailers,
        required this.countSubcategories,
        required this.level,
    });

    int id;
    String name;
    List<String> parentNames;
    int parentId;
    bool isCustom;
    int createdAt;
    int updatedAt;
    String? childHeader;
    int weight;
    int countUsingStartupInCategories;
    int countUsingStartupInAreasOfInterest;
    int countUsingRetailers;
    int countSubcategories;
    int level;

    factory AreaInterestElement.fromJson(Map<String, dynamic> json) => AreaInterestElement(
        id: json["id"],
        name: json["name"],
        parentNames: List<String>.from(json["parentNames"].map((x) => x)),
        parentId: json["parentId"],
        isCustom: json["isCustom"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        childHeader: json["childHeader"],
        weight: json["weight"],
        countUsingStartupInCategories: json["countUsingStartupInCategories"],
        countUsingStartupInAreasOfInterest: json["countUsingStartupInAreasOfInterest"],
        countUsingRetailers: json["countUsingRetailers"],
        countSubcategories: json["countSubcategories"],
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parentNames": List<dynamic>.from(parentNames.map((x) => x)),
        "parentId": parentId,
        "isCustom": isCustom,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "childHeader": childHeader,
        "weight": weight,
        "countUsingStartupInCategories": countUsingStartupInCategories,
        "countUsingStartupInAreasOfInterest": countUsingStartupInAreasOfInterest,
        "countUsingRetailers": countUsingRetailers,
        "countSubcategories": countSubcategories,
        "level": level,
    };
}

class PurpleAreaInterest {
    PurpleAreaInterest({
        required this.name,
    });

    String name;

    factory PurpleAreaInterest.fromJson(Map<String, dynamic> json) => PurpleAreaInterest(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class Startup {
    Startup({
        required this.id,
        this.brandName,
        this.companyLegalName,
    });

    String id;
    String? brandName;
    String? companyLegalName;

    factory Startup.fromJson(Map<String, dynamic> json) => Startup(
        id: json["id"],
        brandName: json["brand_name"]??"",
        companyLegalName: json["company_legal_name"]??"",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "brand_name": brandName,
        "company_legal_name": companyLegalName,
    };
}

class Tag {
    Tag({
        required this.id,
        required this.name,
        required this.articleTag,
    });

    String id;
    String name;
    ArticleTag articleTag;

    factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
        articleTag: ArticleTag.fromJson(json["article_tag"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "article_tag": articleTag.toJson(),
    };
}

class ArticleTag {
    ArticleTag({
        required this.articleId,
        required this.tagId,
        required this.createdAt,
        required this.updatedAt,
    });

    int articleId;
    int tagId;
    DateTime createdAt;
    DateTime updatedAt;

    factory ArticleTag.fromJson(Map<String, dynamic> json) => ArticleTag(
        articleId: json["article_id"],
        tagId: json["tag_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "article_id": articleId,
        "tag_id": tagId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
