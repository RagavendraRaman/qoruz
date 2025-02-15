import 'package:flutter/material.dart';
import 'package:qoruz/features/market_place/modal/market_place_modal.dart';

extension MediaQueryExtension on BuildContext {
  double width() {
    return MediaQuery.sizeOf(this).width;
  }

  double height() {
    return MediaQuery.sizeOf(this).height;
  }
}

extension ServiceIcon on String {
  String getServiceTypeLogo() {
    if (this == "Photographers / Videographers") {
      return "assets/icons/market_place/video_photographer.svg";
    } else if (this == "Talent Management Agencies") {
      return "assets/icons/market_place/talent_management.svg";
    }
    return "assets/icons/market_place/influencer_marketing_agency.svg";
  }
}

extension KeyHighlights on RequestDetails? {
  String getCatergoriesList() {
    if (this == null || this?.categories == null || this!.categories!.isEmpty) {
      return "Lifestyle, Fashion";
    }
    return this!.categories!.join(", ");
  }

  String getPlatformList() {
    if (this == null || this?.platform == null || this!.platform!.isEmpty) {
      return "Instagram";
    }
    return this!.platform!.join(", ");
  }

  String getLanguageList() {
    if (this == null || this?.languages == null || this!.languages!.isEmpty) {
      return "Hindi";
    }
    return this!.languages!.join(", ");
  }

  String getLocationList() {
    if (this == null || this?.cities == null || this!.cities!.isEmpty) {
      return "Bangalore";
    }
    return this!.cities!.join(", ");
  }
}

extension PostDate on String {
  String convertPostedDuration(String createdAt) {
    List<String> splittedString = createdAt.split(" ");
    if (splittedString.length <= 1) {
      return createdAt;
    }
    return "${splittedString.first}${splittedString[1][0]}";
  }
}
