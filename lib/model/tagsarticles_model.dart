// To parse this JSON data, do
//
//     final tagsArticleModel = tagsArticleModelFromJson(jsonString);

import 'dart:convert';

List<TagsArticleModel> tagsArticleModelFromJson(String str) => List<TagsArticleModel>.from(json.decode(str).map((x) => TagsArticleModel.fromJson(x)));

String tagsArticleModelToJson(List<TagsArticleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TagsArticleModel {
    TagsArticleModel({
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
        required this.tags,
    });

    int id;
    String body;
    DateTime date;
    String description;
    bool isdeleted;
    String articlesLink;
    String title;
    dynamic fileId;
    String startUpId;
    dynamic imagedata;
    String imageName;
    dynamic imageType;
    var areaInterest;
    String restricted;
    DateTime createdAt;
    DateTime updatedAt;
    List<Tag> tags;

    factory TagsArticleModel.fromJson(Map<String, dynamic> json) => TagsArticleModel(
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
        imageName: json["image_name"],
        imageType: json["image_type"],
        areaInterest:"",
        restricted: json["restricted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
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
        "area_interest": areaInterest.toJson(),
        "restricted": restricted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    };
}

class AreaInterest {
    AreaInterest({
        required this.name,
    });

    String name;

    factory AreaInterest.fromJson(Map<String, dynamic> json) => AreaInterest(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class Tag {
    Tag({
        required this.id,
        required this.name,
        required this.nameLowerCase,
        required this.articleTag,
    });

    String id;
    String name;
    String? nameLowerCase;
    ArticleTag articleTag;

    factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
        nameLowerCase: json["name_lower_case"],
        articleTag: ArticleTag.fromJson(json["article_tag"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_lower_case": nameLowerCase,
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
