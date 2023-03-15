// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
    SearchModel({
        required this.items,
        required this.count,
    });

    List<Item> items;
    int count;

    factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "count": count,
    };
}

class Item {
    Item({
        required this.id,
        required this.city,
        required this.isCompany,
        required this.country,
        required this.emailDomain,
        required this.companyLegalName,
        required this.companyShortNameLowerCase,
        required this.companyShortName,
        required this.owner,
        required this.createdAt,
        required this.updatedAt,
        required this.isVerified,
        required this.linkedInCompanyPage,
        required this.urlOfCompanyWebsite,
        required this.foundedAt,
        required this.companyType,
        required this.businessModel,
        required this.companyStatus,
        required this.targetMarket,
        required this.clientsList,
        required this.companyDescription,
        required this.solutionProductsServices,
        required this.platformPartners,
        required this.numberOfClients,
        required this.logo120,
        required this.logo60,
        required this.logo30,
        required this.presenceInCountries,
        required this.totalFundingAmount,
        required this.documents,
        required this.categories,
        required this.areasOfInterest,
        required this.tags,
        required this.rate,
        required this.rateStars,
        required this.isNewFeedbacks,
        required this.user,
        required this.isBlocked,
        required this.accountType,
        required this.isEnableMailing,
        required this.isBookmarked,
        required this.browseType,
        required this.feedbackCount,
    });

    int id;
    String city;
    bool isCompany;
    Country country;
    String? emailDomain;
    String? companyLegalName;
    String? companyShortNameLowerCase;
    String? companyShortName;
    String? owner;
    int createdAt;
    int updatedAt;
    bool isVerified;
    String? linkedInCompanyPage;
    String? urlOfCompanyWebsite;
    var foundedAt;
    String? companyType;
    String? businessModel;
    String? companyStatus;
    List<String>? targetMarket;
    List<String>? clientsList;
    String? companyDescription;
    String? solutionProductsServices;
    List<String>? platformPartners;
    var numberOfClients;
    Logo120 logo120;
    Logo120 logo60;
    Logo120 logo30;
    List<Country> presenceInCountries;
    var totalFundingAmount;
    List<dynamic> documents;
    List<AreasOfInterest> categories;
    List<AreasOfInterest> areasOfInterest;
    List<String>? tags;
    var rate;
    var rateStars;
    bool isNewFeedbacks;
    User user;
    bool isBlocked;
    String? accountType;
    bool isEnableMailing;
    bool isBookmarked;
    String? browseType;
    var feedbackCount;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        city: json["city"],
        isCompany: json["isCompany"],
        country: Country.fromJson(json["country"]),
        emailDomain: json["emailDomain"],
        companyLegalName: json["companyLegalName"],
        companyShortNameLowerCase: json["companyShortNameLowerCase"],
        companyShortName: json["companyShortName"],
        owner: json["owner"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        isVerified: json["isVerified"],
        linkedInCompanyPage: json["linkedInCompanyPage"],
        urlOfCompanyWebsite: json["urlOfCompanyWebsite"],
        foundedAt: json["foundedAt"],
        companyType: json["companyType"],
        businessModel: json["businessModel"],
        companyStatus: json["companyStatus"],
        targetMarket: List<String>.from(json["targetMarket"].map((x) => x)),
        clientsList: List<String>.from(json["clientsList"].map((x) => x)),
        companyDescription: json["companyDescription"],
        solutionProductsServices: json["solutionProductsServices"],
        platformPartners: List<String>.from(json["platformPartners"].map((x) => x)),
        numberOfClients: json["numberOfClients"],
        logo120: Logo120.fromJson(json["logo120"]),
        logo60: Logo120.fromJson(json["logo60"]),
        logo30: Logo120.fromJson(json["logo30"]),
        presenceInCountries: List<Country>.from(json["presenceInCountries"].map((x) => Country.fromJson(x))),
        totalFundingAmount: json["totalFundingAmount"],
        documents: List<dynamic>.from(json["documents"].map((x) => x)),
        categories: List<AreasOfInterest>.from(json["categories"].map((x) => AreasOfInterest.fromJson(x))),
        areasOfInterest: List<AreasOfInterest>.from(json["areasOfInterest"].map((x) => AreasOfInterest.fromJson(x))),
        tags: List<String>.from(json["tags"].map((x) => x)),
        rate: json["rate"],
        rateStars: json["rateStars"],
        isNewFeedbacks: json["isNewFeedbacks"],
        user: User.fromJson(json["user"]),
        isBlocked: json["isBlocked"],
        accountType: json["accountType"],
        isEnableMailing: json["isEnableMailing"],
        isBookmarked: json["isBookmarked"],
        browseType: json["browseType"],
        feedbackCount: json["feedbackCount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "isCompany": isCompany,
        "country": country.toJson(),
        "emailDomain": emailDomain,
        "companyLegalName": companyLegalName,
        "companyShortNameLowerCase": companyShortNameLowerCase,
        "companyShortName": companyShortName,
        "owner": owner,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "isVerified": isVerified,
        "linkedInCompanyPage": linkedInCompanyPage,
        "urlOfCompanyWebsite": urlOfCompanyWebsite,
        "foundedAt": foundedAt,
        "companyType": companyType,
        "businessModel": businessModel,
        "companyStatus": companyStatus,
        "companyDescription": companyDescription,
        "solutionProductsServices": solutionProductsServices,
        "numberOfClients": numberOfClients,
        "logo120": logo120.toJson(),
        "logo60": logo60.toJson(),
        "logo30": logo30.toJson(),
        "presenceInCountries": List<dynamic>.from(presenceInCountries.map((x) => x.toJson())),
        "totalFundingAmount": totalFundingAmount,
        "documents": List<dynamic>.from(documents.map((x) => x)),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "areasOfInterest": List<dynamic>.from(areasOfInterest.map((x) => x.toJson())),
        "rate": rate,
        "rateStars": rateStars,
        "isNewFeedbacks": isNewFeedbacks,
        "user": user.toJson(),
        "isBlocked": isBlocked,
        "accountType": accountType,
        "isEnableMailing": isEnableMailing,
        "isBookmarked": isBookmarked,
        "browseType": browseType,
        "feedbackCount": feedbackCount,
    };
}

class AreasOfInterest {
    AreasOfInterest({
        required this.id,
        required this.name,
        required this.parentNames,
        required this.parentId,
        required this.createdAt,
        required this.updatedAt,
        required this.weight,
        required this.countUsingStartupInCategories,
        required this.countUsingStartupInAreasOfInterest,
        required this.countUsingRetailers,
        required this.level,
        required this.isCustom,
        required this.childHeader,
        required this.countSubcategories,
     
    });

    int id;
    String name;
    List<String> parentNames;
    int parentId;
    int createdAt;
    int updatedAt;
    int weight;
    int countUsingStartupInCategories;
    int countUsingStartupInAreasOfInterest;
    int countUsingRetailers;
    int level;
    bool isCustom;
    String childHeader;
    int countSubcategories;
  

    factory AreasOfInterest.fromJson(Map<String, dynamic> json) => AreasOfInterest(
        id: json["id"],
        name: json["name"],
        parentNames: List<String>.from(json["parentNames"].map((x) => x)),
        parentId: json["parentId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        weight: json["weight"],
        countUsingStartupInCategories: json["countUsingStartupInCategories"],
        countUsingStartupInAreasOfInterest: json["countUsingStartupInAreasOfInterest"],
        countUsingRetailers: json["countUsingRetailers"],
        level: json["level"],
        isCustom: json["isCustom"]??false,
        childHeader: json["childHeader"]??"",
        countSubcategories: json["countSubcategories"]??0,
      
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parentNames": List<dynamic>.from(parentNames.map((x) => x)),
        "parentId": parentId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "weight": weight,
        "countUsingStartupInCategories": countUsingStartupInCategories,
        "countUsingStartupInAreasOfInterest": countUsingStartupInAreasOfInterest,
        "countUsingRetailers": countUsingRetailers,
        "level": level,
        "isCustom": isCustom,
        "childHeader": childHeader,
        "countSubcategories": countSubcategories,
      
    };
}

class Logo120 {
    Logo120({
        required this.id,
        required this.filename,
        required this.extension,
        required this.size,
    });

    int id;
    String filename;
    Extension extension;
    int size;

    factory Logo120.fromJson(Map<String, dynamic> json) => Logo120(
        id: json["id"],
        filename: json["filename"],
        extension: extensionValues.map[json["extension"]]!,
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "extension": extensionValues.reverse[extension],
        "size": size,
    };
}

enum Extension { SVG, PNG }

final extensionValues = EnumValues({
    "PNG": Extension.PNG,
    "svg": Extension.SVG
});

class Country {
    Country({
        required this.id,
        required this.name,
        required this.iso,
        required this.iso3,
        required this.numcode,
        required this.phonecode,
    });

    int id;
    String name;
    String iso;
    String iso3;
    int numcode;
    int phonecode;

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        iso: json["iso"],
        iso3: json["iso3"],
        numcode: json["numcode"],
        phonecode: json["phonecode"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "iso": iso,
        "iso3": iso3,
        "numcode": numcode,
        "phonecode": phonecode,
    };
}

class User {
    User({
        required this.id,
        required this.companyShortName,
        required this.startupId,
        required this.logo120,
        required this.logo60,
        required this.logo30,
        required this.isEnableMailing,
        required this.firstName,
        required this.lastName,
        required this.fullName,
    });

    int id;
    String? companyShortName;
    int? startupId;
    Logo120? logo120;
    Logo120? logo60;
    Logo120? logo30;
    bool? isEnableMailing;
    String? firstName;
    String? lastName;
    String? fullName;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        companyShortName: json["companyShortName"],
        startupId: json["startupId"],
        logo120: Logo120.fromJson(json["logo120"]),
        logo60: Logo120.fromJson(json["logo60"]),
        logo30: Logo120.fromJson(json["logo30"]),
        isEnableMailing: json["isEnableMailing"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "companyShortName": companyShortName,
        "startupId": startupId,
        "logo120": logo120!.toJson(),
        "logo60": logo60!.toJson(),
        "logo30": logo30!.toJson(),
        "isEnableMailing": isEnableMailing,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
    };
}

class Department {
    Department({
        required this.id,
        required this.name,
        required this.createdAt,
    });

    int id;
    String name;
    DateTime createdAt;

    factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
