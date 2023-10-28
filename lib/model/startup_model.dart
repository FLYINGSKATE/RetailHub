import 'dart:convert';

StartupModal startupModelFromJson(String str) => StartupModal.fromJson(json.decode(str));

String startupModelToJson(StartupModal data) => json.encode(data.toJson());

class StartupModal {
  Data? data;

  StartupModal({
    this.data,
  });

  StartupModal.fromJson(Map<String, dynamic> json) {
    data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['data'] = data?.toJson();
    return json;
  }







}

class Data {
  int? count;
  List<Startups>? startups;

  Data({
    this.count,
    this.startups,
  });

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'] as int?;
    startups = (json['startups'] as List?)?.map((dynamic e) => Startups.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['count'] = count;
    json['startups'] = startups?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Startups {
  String? id;
  dynamic accountStatus;
  String? businessModel;
  String? city;
  String? clientsList;
  String? companyDescription;
  String? companyLegalName;
  String? companyShortName;
  String? companyType;
  String? companyStatus;
  dynamic emailDomain;
  String? feedbackCount;
  String? foundedAt;
  dynamic integrationTiming;
  bool? isBlocked;
  bool? isCompany;
  bool? isNewFeedbacks;
  bool? isVerified;
  dynamic linkedInCompanyPage;
  String? numberOfClients;
  String? owner;
  dynamic phoneNumber;
  String? platformPartners;
  int? rate;
  int? rateStars;
  String? solutionsProductsServices;
  String? totalFundingAmount;
  dynamic urlOfCompanyWebsite;
  String? hqCountryId;
  dynamic logoId;
  String? logo120Id;
  String? logo30Id;
  String? logo60Id;
  String? accountType;
  String? adminNote;
  String? approvedAt;
  String? companyShortNameLowerCase;
  bool? isEnableMailing;
  bool? isApprovedByAdmin;
  dynamic startupInterviewVideoId;
  dynamic startupMarketingVideoId;
  String? brandName;
  bool? recommendedTop6;
  bool? recommendedTop20;
  bool? isDeleted;
  List<Tags>? tags;
  List<Category>? category;
  Country? country;
  dynamic logo;
  Logo120? logo120;
  Logo30? logo30;
  Logo60? logo60;
  dynamic startupInterviewVideo;
  dynamic startupMarketingVideo;
  List<StartupArticles>? startupArticles;

  Startups({
    this.id,
    this.accountStatus,
    this.businessModel,
    this.city,
    this.clientsList,
    this.companyDescription,
    this.companyLegalName,
    this.companyShortName,
    this.companyType,
    this.companyStatus,
    this.emailDomain,
    this.feedbackCount,
    this.foundedAt,
    this.integrationTiming,
    this.isBlocked,
    this.isCompany,
    this.isNewFeedbacks,
    this.isVerified,
    this.linkedInCompanyPage,
    this.numberOfClients,
    this.owner,
    this.phoneNumber,
    this.platformPartners,
    this.rate,
    this.rateStars,
    this.solutionsProductsServices,
    this.totalFundingAmount,
    this.urlOfCompanyWebsite,
    this.hqCountryId,
    this.logoId,
    this.logo120Id,
    this.logo30Id,
    this.logo60Id,
    this.accountType,
    this.adminNote,
    this.approvedAt,
    this.companyShortNameLowerCase,
    this.isEnableMailing,
    this.isApprovedByAdmin,
    this.startupInterviewVideoId,
    this.startupMarketingVideoId,
    this.brandName,
    this.recommendedTop6,
    this.recommendedTop20,
    this.isDeleted,
    this.tags,
    this.category,
    this.country,
    this.logo,
    this.logo120,
    this.logo30,
    this.logo60,
    this.startupInterviewVideo,
    this.startupMarketingVideo,
    this.startupArticles,
  });

  Startups.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    accountStatus = json['account_status'];
    businessModel = json['business_model'] as String?;
    city = json['city'] as String?;
    clientsList = json['clients_list'] as String?;
    companyDescription = json['company_description'] as String?;
    companyLegalName = json['company_legal_name'] as String?;
    companyShortName = json['company_short_name'] as String?;
    companyType = json['company_type'] as String?;
    companyStatus = json['company_status'] as String?;
    emailDomain = json['email_domain'];
    feedbackCount = json['feedback_count'] as String?;
    foundedAt = json['founded_at'] as String?;
    integrationTiming = json['integration_timing'];
    isBlocked = json['is_blocked'] as bool?;
    isCompany = json['is_company'] as bool?;
    isNewFeedbacks = json['is_new_feedbacks'] as bool?;
    isVerified = json['is_verified'] as bool?;
    linkedInCompanyPage = json['linked_in_company_page'];
    numberOfClients = json['number_of_clients'] as String?;
    owner = json['owner'] as String?;
    phoneNumber = json['phone_number'];
    platformPartners = json['platform_partners'] as String?;
    rate = json['rate'] as int?;
    rateStars = json['rate_stars'] as int?;
    solutionsProductsServices = json['solutions_products_services'] as String?;
    totalFundingAmount = json['total_funding_amount'] as String?;
    urlOfCompanyWebsite = json['url_of_company_website'];
    hqCountryId = json['hq_country_id'] as String?;
    logoId = json['logo_id'];
    logo120Id = json['logo_120_id'] as String?;
    logo30Id = json['logo_30_id'] as String?;
    logo60Id = json['logo_60_id'] as String?;
    accountType = json['account_type'] as String?;
    adminNote = json['admin_note'] as String?;
    approvedAt = json['approved_at'] as String?;
    companyShortNameLowerCase = json['company_short_name_lower_case'] as String?;
    isEnableMailing = json['is_enable_mailing'] as bool?;
    isApprovedByAdmin = json['is_approved_by_admin'] as bool?;
    startupInterviewVideoId = json['startup_interview_video_id'];
    startupMarketingVideoId = json['startup_marketing_video_id'];
    brandName = json['brand_name'] as String?;
    recommendedTop6 = json['recommended_top_6'] as bool?;
    recommendedTop20 = json['recommended_top_20'] as bool?;
    isDeleted = json['is_deleted'] as bool?;
    tags = (json['tags'] as List?)?.map((dynamic e) => Tags.fromJson(e as Map<String,dynamic>)).toList();
    category = (json['category'] as List?)?.map((dynamic e) => Category.fromJson(e as Map<String,dynamic>)).toList();
    country = (json['country'] as Map<String,dynamic>?) != null ? Country.fromJson(json['country'] as Map<String,dynamic>) : null;
    logo = json['logo'];
    logo120 = (json['logo_120'] as Map<String,dynamic>?) != null ? Logo120.fromJson(json['logo_120'] as Map<String,dynamic>) : null;
    logo30 = (json['logo_30'] as Map<String,dynamic>?) != null ? Logo30.fromJson(json['logo_30'] as Map<String,dynamic>) : null;
    logo60 = (json['logo_60'] as Map<String,dynamic>?) != null ? Logo60.fromJson(json['logo_60'] as Map<String,dynamic>) : null;
    startupInterviewVideo = json['startup_interview_video'];
    startupMarketingVideo = json['startup_marketing_video'];
    startupArticles = (json['startup_articles'] as List?)?.map((dynamic e) => StartupArticles.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['account_status'] = accountStatus;
    json['business_model'] = businessModel;
    json['city'] = city;
    json['clients_list'] = clientsList;
    json['company_description'] = companyDescription;
    json['company_legal_name'] = companyLegalName;
    json['company_short_name'] = companyShortName;
    json['company_type'] = companyType;
    json['company_status'] = companyStatus;
    json['email_domain'] = emailDomain;
    json['feedback_count'] = feedbackCount;
    json['founded_at'] = foundedAt;
    json['integration_timing'] = integrationTiming;
    json['is_blocked'] = isBlocked;
    json['is_company'] = isCompany;
    json['is_new_feedbacks'] = isNewFeedbacks;
    json['is_verified'] = isVerified;
    json['linked_in_company_page'] = linkedInCompanyPage;
    json['number_of_clients'] = numberOfClients;
    json['owner'] = owner;
    json['phone_number'] = phoneNumber;
    json['platform_partners'] = platformPartners;
    json['rate'] = rate;
    json['rate_stars'] = rateStars;
    json['solutions_products_services'] = solutionsProductsServices;
    json['total_funding_amount'] = totalFundingAmount;
    json['url_of_company_website'] = urlOfCompanyWebsite;
    json['hq_country_id'] = hqCountryId;
    json['logo_id'] = logoId;
    json['logo_120_id'] = logo120Id;
    json['logo_30_id'] = logo30Id;
    json['logo_60_id'] = logo60Id;
    json['account_type'] = accountType;
    json['admin_note'] = adminNote;
    json['approved_at'] = approvedAt;
    json['company_short_name_lower_case'] = companyShortNameLowerCase;
    json['is_enable_mailing'] = isEnableMailing;
    json['is_approved_by_admin'] = isApprovedByAdmin;
    json['startup_interview_video_id'] = startupInterviewVideoId;
    json['startup_marketing_video_id'] = startupMarketingVideoId;
    json['brand_name'] = brandName;
    json['recommended_top_6'] = recommendedTop6;
    json['recommended_top_20'] = recommendedTop20;
    json['is_deleted'] = isDeleted;
    json['tags'] = tags?.map((e) => e.toJson()).toList();
    json['category'] = category?.map((e) => e.toJson()).toList();
    json['country'] = country?.toJson();
    json['logo'] = logo;
    json['logo_120'] = logo120?.toJson();
    json['logo_30'] = logo30?.toJson();
    json['logo_60'] = logo60?.toJson();
    json['startup_interview_video'] = startupInterviewVideo;
    json['startup_marketing_video'] = startupMarketingVideo;
    json['startup_articles'] = startupArticles?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Tags {
  String? id;
  String? name;
  StartupTags? startupTags;

  Tags({
    this.id,
    this.name,
    this.startupTags,
  });

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    startupTags = (json['startup_tags'] as Map<String,dynamic>?) != null ? StartupTags.fromJson(json['startup_tags'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['startup_tags'] = startupTags?.toJson();
    return json;
  }
}

class StartupTags {
  String? startupId;
  String? tagsId;

  StartupTags({
    this.startupId,
    this.tagsId,
  });

  StartupTags.fromJson(Map<String, dynamic> json) {
    startupId = json['startup_id'] as String?;
    tagsId = json['tags_id'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['startup_id'] = startupId;
    json['tags_id'] = tagsId;
    return json;
  }
}

class Category {
  String? id;
  String? name;
  String? parentId;
  String? parentNames;
  StartupCategories? startupCategories;

  Category({
    this.id,
    this.name,
    this.parentId,
    this.parentNames,
    this.startupCategories,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    parentId = json['parent_id'] as String?;
    parentNames = json['parent_names'] as String?;
    startupCategories = (json['startup_categories'] as Map<String,dynamic>?) != null ? StartupCategories.fromJson(json['startup_categories'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['parent_id'] = parentId;
    json['parent_names'] = parentNames;
    json['startup_categories'] = startupCategories?.toJson();
    return json;
  }
}

class StartupCategories {
  String? startupId;
  String? categoryId;

  StartupCategories({
    this.startupId,
    this.categoryId,
  });

  StartupCategories.fromJson(Map<String, dynamic> json) {
    startupId = json['startup_id'] as String?;
    categoryId = json['category_id'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['startup_id'] = startupId;
    json['category_id'] = categoryId;
    return json;
  }
}

class Country {
  String? id;
  String? name;
  String? iso;
  String? iso3;
  String? nicename;
  String? numcode;
  String? phonecode;

  Country({
    this.id,
    this.name,
    this.iso,
    this.iso3,
    this.nicename,
    this.numcode,
    this.phonecode,
  });

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    iso = json['iso'] as String?;
    iso3 = json['iso3'] as String?;
    nicename = json['nicename'] as String?;
    numcode = json['numcode'] as String?;
    phonecode = json['phonecode'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['iso'] = iso;
    json['iso3'] = iso3;
    json['nicename'] = nicename;
    json['numcode'] = numcode;
    json['phonecode'] = phonecode;
    return json;
  }
}

class Logo120 {
  String? id;
  String? extension;
  String? filename;
  String? filenameOnDisk;
  String? size;
  String? userId;
  dynamic thumbnailId;
  dynamic pdfId;
  dynamic previewId;

  Logo120({
    this.id,
    this.extension,
    this.filename,
    this.filenameOnDisk,
    this.size,
    this.userId,
    this.thumbnailId,
    this.pdfId,
    this.previewId,
  });

  Logo120.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    extension = json['extension'] as String?;
    filename = json['filename'] as String?;
    filenameOnDisk = json['filename_on_disk'] as String?;
    size = json['size'] as String?;
    userId = json['user_id'] as String?;
    thumbnailId = json['thumbnail_id'];
    pdfId = json['pdf_id'];
    previewId = json['preview_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['extension'] = extension;
    json['filename'] = filename;
    json['filename_on_disk'] = filenameOnDisk;
    json['size'] = size;
    json['user_id'] = userId;
    json['thumbnail_id'] = thumbnailId;
    json['pdf_id'] = pdfId;
    json['preview_id'] = previewId;
    return json;
  }
}

class Logo30 {
  String? id;
  String? extension;
  String? filename;
  String? filenameOnDisk;
  String? size;
  String? userId;
  dynamic thumbnailId;
  dynamic pdfId;
  dynamic previewId;

  Logo30({
    this.id,
    this.extension,
    this.filename,
    this.filenameOnDisk,
    this.size,
    this.userId,
    this.thumbnailId,
    this.pdfId,
    this.previewId,
  });

  Logo30.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    extension = json['extension'] as String?;
    filename = json['filename'] as String?;
    filenameOnDisk = json['filename_on_disk'] as String?;
    size = json['size'] as String?;
    userId = json['user_id'] as String?;
    thumbnailId = json['thumbnail_id'];
    pdfId = json['pdf_id'];
    previewId = json['preview_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['extension'] = extension;
    json['filename'] = filename;
    json['filename_on_disk'] = filenameOnDisk;
    json['size'] = size;
    json['user_id'] = userId;
    json['thumbnail_id'] = thumbnailId;
    json['pdf_id'] = pdfId;
    json['preview_id'] = previewId;
    return json;
  }
}

class Logo60 {
  String? id;
  String? extension;
  String? filename;
  String? filenameOnDisk;
  String? size;
  String? userId;
  dynamic thumbnailId;
  dynamic pdfId;
  dynamic previewId;

  Logo60({
    this.id,
    this.extension,
    this.filename,
    this.filenameOnDisk,
    this.size,
    this.userId,
    this.thumbnailId,
    this.pdfId,
    this.previewId,
  });

  Logo60.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    extension = json['extension'] as String?;
    filename = json['filename'] as String?;
    filenameOnDisk = json['filename_on_disk'] as String?;
    size = json['size'] as String?;
    userId = json['user_id'] as String?;
    thumbnailId = json['thumbnail_id'];
    pdfId = json['pdf_id'];
    previewId = json['preview_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['extension'] = extension;
    json['filename'] = filename;
    json['filename_on_disk'] = filenameOnDisk;
    json['size'] = size;
    json['user_id'] = userId;
    json['thumbnail_id'] = thumbnailId;
    json['pdf_id'] = pdfId;
    json['preview_id'] = previewId;
    return json;
  }
}

class StartupArticles {
  int? id;
  String? body;
  String? date;
  String? description;
  bool? isdeleted;
  String? articlesLink;
  String? title;
  dynamic fileId;
  String? startUpId;
  dynamic imagedata;
  String? imageName;
  dynamic imageType;
  List<AreaInterest>? areaInterest;
  String? restricted;
  String? createdAt;
  String? updatedAt;

  StartupArticles({
    this.id,
    this.body,
    this.date,
    this.description,
    this.isdeleted,
    this.articlesLink,
    this.title,
    this.fileId,
    this.startUpId,
    this.imagedata,
    this.imageName,
    this.imageType,
    this.areaInterest,
    this.restricted,
    this.createdAt,
    this.updatedAt,
  });

  StartupArticles.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    body = json['body'] as String?;
    date = json['date'] as String?;
    description = json['description'] as String?;
    isdeleted = json['isdeleted'] as bool?;
    articlesLink = json['articles_link'] as String?;
    title = json['title'] as String?;
    fileId = json['file_id'];
    startUpId = json['start_up_id'] as String?;
    imagedata = json['imagedata'];
    imageName = json['image_name'] as String?;
    imageType = json['image_type'];
    areaInterest = (json['area_interest'] as List?)?.map((dynamic e) => AreaInterest.fromJson(e as Map<String,dynamic>)).toList();
    restricted = json['restricted'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['body'] = body;
    json['date'] = date;
    json['description'] = description;
    json['isdeleted'] = isdeleted;
    json['articles_link'] = articlesLink;
    json['title'] = title;
    json['file_id'] = fileId;
    json['start_up_id'] = startUpId;
    json['imagedata'] = imagedata;
    json['image_name'] = imageName;
    json['image_type'] = imageType;
    json['area_interest'] = areaInterest?.map((e) => e.toJson()).toList();
    json['restricted'] = restricted;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    return json;
  }
}

class AreaInterest {
  int? id;
  String? name;
  List<String>? parentNames;
  int? parentId;
  bool? isCustom;
  int? createdAt;
  int? updatedAt;
  String? childHeader;
  int? weight;
  int? countUsingStartupInCategories;
  int? countUsingStartupInAreasOfInterest;
  int? countUsingRetailers;
  int? countSubcategories;
  int? level;

  AreaInterest({
    this.id,
    this.name,
    this.parentNames,
    this.parentId,
    this.isCustom,
    this.createdAt,
    this.updatedAt,
    this.childHeader,
    this.weight,
    this.countUsingStartupInCategories,
    this.countUsingStartupInAreasOfInterest,
    this.countUsingRetailers,
    this.countSubcategories,
    this.level,
  });

  AreaInterest.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    parentNames = (json['parentNames'] as List?)?.map((dynamic e) => e as String).toList();
    parentId = json['parentId'] as int?;
    isCustom = json['isCustom'] as bool?;
    createdAt = json['createdAt'] as int?;
    updatedAt = json['updatedAt'] as int?;
    childHeader = json['childHeader'] as String?;
    weight = json['weight'] as int?;
    countUsingStartupInCategories = json['countUsingStartupInCategories'] as int?;
    countUsingStartupInAreasOfInterest = json['countUsingStartupInAreasOfInterest'] as int?;
    countUsingRetailers = json['countUsingRetailers'] as int?;
    countSubcategories = json['countSubcategories'] as int?;
    level = json['level'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['parentNames'] = parentNames;
    json['parentId'] = parentId;
    json['isCustom'] = isCustom;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['childHeader'] = childHeader;
    json['weight'] = weight;
    json['countUsingStartupInCategories'] = countUsingStartupInCategories;
    json['countUsingStartupInAreasOfInterest'] = countUsingStartupInAreasOfInterest;
    json['countUsingRetailers'] = countUsingRetailers;
    json['countSubcategories'] = countSubcategories;
    json['level'] = level;
    return json;
  }
}