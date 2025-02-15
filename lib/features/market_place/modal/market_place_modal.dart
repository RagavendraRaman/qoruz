class MarketMeta {
  bool ok;
  List<MarketplaceRequest> marketplaceRequests;
  Pagination pagination;

  MarketMeta({
    required this.ok,
    required this.marketplaceRequests,
    required this.pagination,
  });

  factory MarketMeta.fromJson(Map<String, dynamic> json) => MarketMeta(
        ok: json["ok"],
        marketplaceRequests: List<MarketplaceRequest>.from(
          json["marketplace_requests"].map(
            (x) => MarketplaceRequest.fromJson(x),
          ),
        ),
        pagination: Pagination.fromJson(json["pagination"]),
      );
}

class MarketplaceRequest {
  String idHash;
  UserDetails userDetails;
  bool isHighValue;
  String createdAt;
  String description;
  RequestDetails? requestDetails;
  String status;
  String serviceType;
  String targetAudience;
  bool isOpen;
  bool isPanIndia;
  bool anyLanguage;
  bool isDealClosed;
  String slug;

  MarketplaceRequest({
    required this.idHash,
    required this.userDetails,
    required this.isHighValue,
    required this.createdAt,
    required this.description,
    required this.requestDetails,
    required this.status,
    required this.serviceType,
    required this.targetAudience,
    required this.isOpen,
    required this.isPanIndia,
    required this.anyLanguage,
    required this.isDealClosed,
    required this.slug,
  });

  factory MarketplaceRequest.fromJson(Map<String, dynamic> json) =>
      MarketplaceRequest(
        idHash: json["id_hash"],
        userDetails: UserDetails.fromJson(json["user_details"]),
        isHighValue: json["is_high_value"],
        createdAt: json["created_at"],
        description: json["description"],
        requestDetails: json["request_details"] == null
            ? null
            : RequestDetails.fromJson(json["request_details"]),
        status: json["status"],
        serviceType: json["service_type"],
        targetAudience: json["target_audience"],
        isOpen: json["is_open"],
        isPanIndia: json["is_pan_india"],
        anyLanguage: json["any_language"],
        isDealClosed: json["is_deal_closed"],
        slug: json["slug"],
      );
}

class RequestDetails {
  FollowersRange? followersRange;
  List<String>? platform;
  List<String>? cities;
  List<String>? categories;
  int? creatorCountMin;
  int? creatorCountMax;
  String? budget;
  String? brand;
  List<String>? languages;
  String? gender;

  RequestDetails({
    required this.followersRange,
    required this.platform,
    this.cities,
    this.categories,
    this.creatorCountMin,
    this.creatorCountMax,
    this.budget,
    this.brand,
    this.languages,
    this.gender,
  });

  factory RequestDetails.fromJson(Map<String, dynamic> json) => RequestDetails(
        followersRange: json["followers_range"] != null
            ? FollowersRange.fromJson(json["followers_range"])
            : null,
        platform: json["platform"] != null
            ? List<String>.from(json["platform"].map((x) => x))
            : null,
        cities: json["cities"] == null
            ? []
            : List<String>.from(json["cities"]!.map((x) => x)),
        categories: json["categories"] == null
            ? []
            : List<String>.from(json["categories"]!.map((x) => x)),
        creatorCountMin: json["creator_count_min"],
        creatorCountMax: json["creator_count_max"],
        budget: json["budget"],
        brand: json["brand"],
        languages: json["languages"] == null
            ? []
            : List<String>.from(json["languages"]!.map((x) => x)),
        gender: json["gender"],
      );
}

class FollowersRange {
  String igFollowersMin;
  String igFollowersMax;
  String? ytSubscribersMin;
  String? ytSubscribersMax;

  FollowersRange({
    required this.igFollowersMin,
    required this.igFollowersMax,
    this.ytSubscribersMin,
    this.ytSubscribersMax,
  });

  factory FollowersRange.fromJson(Map<String, dynamic> json) => FollowersRange(
        igFollowersMin: json["ig_followers_min"],
        igFollowersMax: json["ig_followers_max"],
        ytSubscribersMin: json["yt_subscribers_min"],
        ytSubscribersMax: json["yt_subscribers_max"],
      );
}

class UserDetails {
  String name;
  String? profileImage;
  String company;
  String designation;

  UserDetails({
    required this.name,
    required this.profileImage,
    required this.company,
    required this.designation,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        name: json["name"],
        profileImage: json["profile_image"],
        company: json["company"],
        designation: json["designation"]!,
      );
}

class Pagination {
  bool hasMore;
  int total;
  int count;
  int perPage;
  int currentPage;
  int totalPages;
  String? nextPageUrl;
  dynamic previousPageUrl;
  String url;

  Pagination({
    required this.hasMore,
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    required this.nextPageUrl,
    required this.previousPageUrl,
    required this.url,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        hasMore: json["has_more"],
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        nextPageUrl: json["next_page_url"],
        previousPageUrl: json["previous_page_url"],
        url: json["url"],
      );
}
