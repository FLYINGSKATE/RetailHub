// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.position,
        required this.email,
        required this.isBlocked,
        required this.isVerified,
        required this.isApprovedByAdmin,
        required this.role,
        required this.createdAt,
        required this.updatedAt,
        required this.phoneNumber,
        required this.status,
        required this.isEnabled2Fa,
        required this.approvedByAdminAt,
        required this.retailer,
        required this.token,
        required this.onlineStatus,
        required this.fullName,
        required this.isEnableMailing,
        required this.city,
        required this.country,
        required this.completePercentage,
        required this.trial,
    });

    int id;
    String firstName;
    String lastName;
    String position;
    String email;
    bool isBlocked;
    bool isVerified;
    bool isApprovedByAdmin;
    String role;
    int createdAt;
    int updatedAt;
    String phoneNumber;
    String status;
    bool isEnabled2Fa;
    int approvedByAdminAt;
    Retailer retailer;
    String token;
    OnlineStatus onlineStatus;
    String fullName;
    bool isEnableMailing;
    String city;
    Country country;
    String completePercentage;
    bool trial;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        position: json["position"],
        email: json["email"],
        isBlocked: json["isBlocked"],
        isVerified: json["isVerified"],
        isApprovedByAdmin: json["isApprovedByAdmin"],
        role: json["role"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        phoneNumber: json["phoneNumber"],
        status: json["status"],
        isEnabled2Fa: json["isEnabled2fa"],
        approvedByAdminAt: json["approvedByAdminAt"],
        retailer: Retailer.fromJson(json["retailer"]),
        token: json["token"],
        onlineStatus: OnlineStatus.fromJson(json["onlineStatus"]),
        fullName: json["fullName"],
        isEnableMailing: json["isEnableMailing"],
        city: json["city"],
        country: Country.fromJson(json["country"]),
        completePercentage: json["completePercentage"],
        trial: json["trial"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "position": position,
        "email": email,
        "isBlocked": isBlocked,
        "isVerified": isVerified,
        "isApprovedByAdmin": isApprovedByAdmin,
        "role": role,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "phoneNumber": phoneNumber,
        "status": status,
        "isEnabled2fa": isEnabled2Fa,
        "approvedByAdminAt": approvedByAdminAt,
        "retailer": retailer.toJson(),
        "token": token,
        "onlineStatus": onlineStatus.toJson(),
        "fullName": fullName,
        "isEnableMailing": isEnableMailing,
        "city": city,
        "country": country.toJson(),
        "completePercentage": completePercentage,
        "trial": trial,
    };
}

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

class OnlineStatus {
    OnlineStatus({
        required this.userId,
        required this.onlineStatus,
        required this.visitedAt,
    });

    int userId;
    String onlineStatus;
    int visitedAt;

    factory OnlineStatus.fromJson(Map<String, dynamic> json) => OnlineStatus(
        userId: json["userId"],
        onlineStatus: json["onlineStatus"],
        visitedAt: json["visitedAt"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "onlineStatus": onlineStatus,
        "visitedAt": visitedAt,
    };
}

class Retailer {
    Retailer({
        required this.id,
        required this.country,
        required this.emailDomain,
        required this.companyLegalName,
        required this.companyShortName,
        required this.phoneNumber,
        required this.createdAt,
        required this.updatedAt,
        required this.isVerified,
        required this.paymentPlan,
        required this.logo120,
        required this.logo60,
        required this.logo30,
        required this.city,
        required this.urlOfCompanyWebsite,
        required this.companyDescription,
        required this.tags,
        required this.address,
        required this.companySectors,
        required this.customerId,
        required this.stripePaymentSettings,
        required this.members,
    });

    int id;
    Country country;
    String emailDomain;
    String companyLegalName;
    String companyShortName;
    String phoneNumber;
    int createdAt;
    int updatedAt;
    bool isVerified;
    PaymentPlan paymentPlan;
    Logo120 logo120;
    Logo120 logo60;
    Logo120 logo30;
    String city;
    String urlOfCompanyWebsite;
    String companyDescription;
    List<String> tags;
    String address;
    List<CompanySector> companySectors;
    String customerId;
    StripePaymentSettings stripePaymentSettings;
    List<dynamic> members;

    factory Retailer.fromJson(Map<String, dynamic> json) => Retailer(
        id: json["id"],
        country: Country.fromJson(json["country"]),
        emailDomain: json["emailDomain"],
        companyLegalName: json["companyLegalName"],
        companyShortName: json["companyShortName"],
        phoneNumber: json["phoneNumber"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        isVerified: json["isVerified"],
        paymentPlan: PaymentPlan.fromJson(json["paymentPlan"]),
        logo120: Logo120.fromJson(json["logo120"]),
        logo60: Logo120.fromJson(json["logo60"]),
        logo30: Logo120.fromJson(json["logo30"]),
        city: json["city"],
        urlOfCompanyWebsite: json["urlOfCompanyWebsite"],
        companyDescription: json["companyDescription"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        address: json["address"],
        companySectors: List<CompanySector>.from(json["companySectors"].map((x) => CompanySector.fromJson(x))),
        customerId: json["customerId"],
        stripePaymentSettings: StripePaymentSettings.fromJson(json["stripePaymentSettings"]),
        members: List<dynamic>.from(json["members"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "country": country.toJson(),
        "emailDomain": emailDomain,
        "companyLegalName": companyLegalName,
        "companyShortName": companyShortName,
        "phoneNumber": phoneNumber,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "isVerified": isVerified,
        "paymentPlan": paymentPlan.toJson(),
        "logo120": logo120.toJson(),
        "logo60": logo60.toJson(),
        "logo30": logo30.toJson(),
        "city": city,
        "urlOfCompanyWebsite": urlOfCompanyWebsite,
        "companyDescription": companyDescription,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "address": address,
        "companySectors": List<dynamic>.from(companySectors.map((x) => x.toJson())),
        "customerId": customerId,
        "stripePaymentSettings": stripePaymentSettings.toJson(),
        "members": List<dynamic>.from(members.map((x) => x)),
    };
}

class CompanySector {
    CompanySector({
        required this.id,
        required this.name,
        required this.parentNames,
        required this.isCustom,
        required this.createdAt,
        required this.updatedAt,
        required this.childHeader,
        required this.weight,
        required this.countUsingStartupInCategories,
        required this.countUsingStartupInAreasOfInterest,
        required this.countUsingRetailers,
        required this.countSubcategories,
        required this.logo,
        required this.areasLogo,
        required this.level,
    });

    int id;
    String name;
    List<String> parentNames;
    bool isCustom;
    int createdAt;
    int updatedAt;
    String childHeader;
    int weight;
    int countUsingStartupInCategories;
    int countUsingStartupInAreasOfInterest;
    int countUsingRetailers;
    int countSubcategories;
    Logo120 logo;
    Logo120 areasLogo;
    int level;

    factory CompanySector.fromJson(Map<String, dynamic> json) => CompanySector(
        id: json["id"],
        name: json["name"],
        parentNames: List<String>.from(json["parentNames"].map((x) => x)),
        isCustom: json["isCustom"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        childHeader: json["childHeader"],
        weight: json["weight"],
        countUsingStartupInCategories: json["countUsingStartupInCategories"],
        countUsingStartupInAreasOfInterest: json["countUsingStartupInAreasOfInterest"],
        countUsingRetailers: json["countUsingRetailers"],
        countSubcategories: json["countSubcategories"],
        logo: Logo120.fromJson(json["logo"]),
        areasLogo: Logo120.fromJson(json["areasLogo"]),
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parentNames": List<dynamic>.from(parentNames.map((x) => x)),
        "isCustom": isCustom,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "childHeader": childHeader,
        "weight": weight,
        "countUsingStartupInCategories": countUsingStartupInCategories,
        "countUsingStartupInAreasOfInterest": countUsingStartupInAreasOfInterest,
        "countUsingRetailers": countUsingRetailers,
        "countSubcategories": countSubcategories,
        "logo": logo.toJson(),
        "areasLogo": areasLogo.toJson(),
        "level": level,
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

enum Extension { SVG, EXTENSION_SVG, PNG }

final extensionValues = EnumValues({
    "SVG": Extension.EXTENSION_SVG,
    "png": Extension.PNG,
    "svg": Extension.SVG
});

class PaymentPlan {
    PaymentPlan({
        required this.id,
        required this.planType,
        required this.role,
        required this.price,
        required this.stripeName,
        required this.uiName,
        required this.createdAt,
        required this.updatedAt,
        required this.stripeProductId,
        required this.stripePriceId,
        required this.interval,
        required this.trial,
        required this.usingCount,
        required this.isDiscountable,
        required this.discountCount,
        required this.isHidden,
    });

    int id;
    String planType;
    String role;
    Price price;
    String stripeName;
    String uiName;
    int createdAt;
    int updatedAt;
    String stripeProductId;
    String stripePriceId;
    String interval;
    int trial;
    int usingCount;
    bool isDiscountable;
    int discountCount;
    bool isHidden;

    factory PaymentPlan.fromJson(Map<String, dynamic> json) => PaymentPlan(
        id: json["id"],
        planType: json["planType"],
        role: json["role"],
        price: Price.fromJson(json["price"]),
        stripeName: json["stripeName"],
        uiName: json["uiName"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        stripeProductId: json["stripeProductId"],
        stripePriceId: json["stripePriceId"],
        interval: json["interval"],
        trial: json["trial"],
        usingCount: json["usingCount"],
        isDiscountable: json["isDiscountable"],
        discountCount: json["discountCount"],
        isHidden: json["isHidden"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "planType": planType,
        "role": role,
        "price": price.toJson(),
        "stripeName": stripeName,
        "uiName": uiName,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "stripeProductId": stripeProductId,
        "stripePriceId": stripePriceId,
        "interval": interval,
        "trial": trial,
        "usingCount": usingCount,
        "isDiscountable": isDiscountable,
        "discountCount": discountCount,
        "isHidden": isHidden,
    };
}

class Price {
    Price({
        required this.id,
        required this.name,
        required this.unitAmount,
        required this.comment,
        required this.currency,
        required this.createdAt,
        required this.updatedAt,
        required this.usingCount,
    });

    int id;
    String name;
    int unitAmount;
    String comment;
    String currency;
    DateTime createdAt;
    DateTime updatedAt;
    int usingCount;

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        id: json["id"],
        name: json["name"],
        unitAmount: json["unitAmount"],
        comment: json["comment"],
        currency: json["currency"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        usingCount: json["usingCount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "unitAmount": unitAmount,
        "comment": comment,
        "currency": currency,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "usingCount": usingCount,
    };
}

class StripePaymentSettings {
    StripePaymentSettings({
        required this.id,
        required this.stripeSubscriptionId,
        required this.isSubscriptionPaid,
        required this.isPayStripeSubscriptionFromReserveCard,
        required this.nextPaymentDate,
        required this.subscriptionStatus,
        required this.isTrial,
        required this.trialEndsAt,
        required this.isCancelled,
        required this.subscriptionEndsAt,
        required this.stripePaymentMethodId,
    });

    int id;
    String stripeSubscriptionId;
    bool isSubscriptionPaid;
    bool isPayStripeSubscriptionFromReserveCard;
    int nextPaymentDate;
    String subscriptionStatus;
    bool isTrial;
    int trialEndsAt;
    bool isCancelled;
    int subscriptionEndsAt;
    String stripePaymentMethodId;

    factory StripePaymentSettings.fromJson(Map<String, dynamic> json) => StripePaymentSettings(
        id: json["id"],
        stripeSubscriptionId: json["stripeSubscriptionId"],
        isSubscriptionPaid: json["isSubscriptionPaid"],
        isPayStripeSubscriptionFromReserveCard: json["isPayStripeSubscriptionFromReserveCard"],
        nextPaymentDate: json["nextPaymentDate"],
        subscriptionStatus: json["subscriptionStatus"],
        isTrial: json["isTrial"],
        trialEndsAt: json["trialEndsAt"],
        isCancelled: json["isCancelled"],
        subscriptionEndsAt: json["subscriptionEndsAt"],
        stripePaymentMethodId: json["stripePaymentMethodId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "stripeSubscriptionId": stripeSubscriptionId,
        "isSubscriptionPaid": isSubscriptionPaid,
        "isPayStripeSubscriptionFromReserveCard": isPayStripeSubscriptionFromReserveCard,
        "nextPaymentDate": nextPaymentDate,
        "subscriptionStatus": subscriptionStatus,
        "isTrial": isTrial,
        "trialEndsAt": trialEndsAt,
        "isCancelled": isCancelled,
        "subscriptionEndsAt": subscriptionEndsAt,
        "stripePaymentMethodId": stripePaymentMethodId,
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
