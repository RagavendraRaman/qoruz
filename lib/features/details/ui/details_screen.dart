import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qoruz/features/details/bloc/details_bloc.dart';
import 'package:qoruz/features/market_place/modal/market_place_modal.dart';
import 'package:qoruz/reusable_widgets/circle_progress_indicator.dart';
import 'package:qoruz/utils/app_colors.dart';
import 'package:qoruz/utils/app_constants.dart';
import 'package:qoruz/utils/extensions.dart';

class DetailsScreen extends StatefulWidget {
  final String id;
  const DetailsScreen({
    super.key,
    required this.id,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  final DetailsBloc detailsBloc = DetailsBloc();
  late MarketplaceRequest marketplaceRequest;
  late AnimationController bottomSheetAnimationController;

  @override
  void initState() {
    detailsBloc.add(GetDetailsEvent(id: widget.id));
    bottomSheetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = context.width();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * AppConstants.horizontalPadding,
          ),
          child: GestureDetector(
            onTap: () => detailsBloc.add(NavigateToBackEvent()),
            child: SvgPicture.asset(
              "assets/icons/details/arrow-left.svg",
            ),
          ),
        ),
        actions: [
          SvgPicture.asset(
            "assets/icons/details/delete.svg",
            height: 30,
            width: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * AppConstants.horizontalPadding,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Color(0XFFFF7304),
                    Color(0XFFFB2A77),
                  ],
                  transform: GradientRotation(20),
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  "assets/icons/details/share.svg",
                  height: 25,
                  width: 25,
                ),
              ),
            ),
          ),
        ],
        shape: Border(
          bottom: BorderSide(
            color: AppColors.searchInputBorder.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      body: BlocConsumer<DetailsBloc, DetailsState>(
        bloc: detailsBloc,
        listenWhen: (previous, current) => current is DetailsActionState,
        buildWhen: (previous, current) => current is! DetailsActionState,
        listener: (context, state) {
          if (state is NavigateToBackState) {
            Navigator.pop(context);
          } else if (state is ButtonTapState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  backgroundColor: AppColors.bottomNavselectedColor,
                  behavior: SnackBarBehavior.floating,
                ),
              );
          }
        },
        builder: (context, state) {
          if (state is DetailsLoadingState) {
            return const Center(
              child: CircleProgressIndicatorWidget(
                height: 30,
              ),
            );
          } else if (state is DetailsErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is DetailsSuccesState) {
            marketplaceRequest = state.marketplaceRequest;
            bottomSheetAnimationController.forward();
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Color(0XFFF5F6FB),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * AppConstants.horizontalPadding,
                      vertical: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/icons/details/profile_picture.png",
                          fit: BoxFit.fill,
                          height: 50,
                          width: 50,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        marketplaceRequest.userDetails.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Image.asset(
                                        "assets/icons/details/linkedin.png",
                                        height: 15,
                                        width: 15,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/details/Verified.svg",
                                      height: 15,
                                      width: 15,
                                    ),
                                  ],
                                ),
                                Text(
                                  marketplaceRequest.userDetails.designation,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.searchInputHintColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/details/organization.svg",
                                      height: 16,
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        child: Text(
                                          marketplaceRequest
                                              .userDetails.company,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color:
                                                AppColors.searchInputHintColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "${marketplaceRequest.createdAt.convertPostedDuration(
                            marketplaceRequest.createdAt,
                          )} ago",
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.searchInputHintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * AppConstants.horizontalPadding,
                    vertical: 12,
                  ),
                  child: LookingForWidget(
                    serviceType: marketplaceRequest.serviceType,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * AppConstants.horizontalPadding,
                  ),
                  child: const Divider(
                    color: AppColors.detailsPageDividerColor,
                    height: 0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * AppConstants.horizontalPadding,
                    vertical: 10,
                  ),
                  child: const Text(
                    "Highligts",
                    style: TextStyle(
                      color: AppColors.bottomNavUnselectedColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * AppConstants.horizontalPadding,
                  ),
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      HighlightsWidget(
                        assestPath: "assets/icons/details/rupee.svg",
                        content:
                            "Budget: ${marketplaceRequest.requestDetails?.budget ?? 150000}",
                      ),
                      HighlightsWidget(
                        assestPath: "assets/icons/details/brand.svg",
                        content:
                            "Brand: ${marketplaceRequest.requestDetails?.brand ?? "Swiggy"}",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * AppConstants.horizontalPadding,
                    vertical: 10,
                  ),
                  child: Text(
                    "${marketplaceRequest.description} Budget: ₹1,50,000Brand: WanderFit LuggageLocation: Goa & KeralaType: Lifestyle & Adventure travel content with a focus on young, urban audiencesLanguage: English and HindiLooking for a travel influencer who can showcase our premium luggage line in scenic beach and nature destinations. Content should emphasize ease of travel and durability of the product.",
                    style: const TextStyle(
                      fontSize: 17,
                      color: AppColors.descriptionTextColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * AppConstants.horizontalPadding,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: ShareWidget(
                          assetPath: "assets/icons/details/whatsapp.png",
                          shareContent: "Share via ",
                          appName: "WhatsApp",
                          backGroundColor: AppColors.whatsappShareColor,
                        ),
                      ),
                      Flexible(
                        child: ShareWidget(
                          assetPath: "assets/icons/details/linkedin_logo.png",
                          shareContent: "Share on ",
                          appName: "LinkedIn",
                          backGroundColor: AppColors.linkedInShareColor,
                        ),
                      ),
                    ],
                  ),
                ),
                KeyHighlightedListContainer(
                  width: width,
                  marketplaceRequest: marketplaceRequest,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, -1),
              color: AppColors.searchInputHintColor.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 3,
            ),
          ],
        ),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(bottomSheetAnimationController),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * AppConstants.horizontalPadding,
              vertical: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: SvgPicture.asset(
                          "assets/icons/market_place/clock.svg"),
                    ),
                    const Flexible(
                      child: Text(
                        "Your post has will be expired on 26 July",
                        style: TextStyle(
                          color: AppColors.descriptionTextColor,
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          detailsBloc.add(ButtonTapEvent(
                            message: "Edit button pressed",
                          ));
                        },
                        style: OutlinedButton.styleFrom(
                          fixedSize: Size(width * 0.45, 40),
                          side: const BorderSide(
                            color: AppColors.bottomNavselectedColor,
                          ),
                        ),
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            color: AppColors.bottomNavselectedColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          detailsBloc.add(ButtonTapEvent(
                            message: "Close button pressed",
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.bottomNavselectedColor,
                          fixedSize: Size(width * 0.45, 40),
                        ),
                        child: const Text(
                          "Close",
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KeyHighlightedListContainer extends StatelessWidget {
  const KeyHighlightedListContainer({
    super.key,
    required this.width,
    required this.marketplaceRequest,
  });

  final double width;
  final MarketplaceRequest marketplaceRequest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * AppConstants.horizontalPadding,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              "Key Highlighted Details",
              style: TextStyle(
                color: AppColors.bottomNavUnselectedColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          HorizontalDetailsWidget(
            widgets: [
              Expanded(
                child: KeyHighLightWidget(
                  heading: "Category",
                  content:
                      marketplaceRequest.requestDetails.getCatergoriesList(),
                ),
              ),
              Expanded(
                child: KeyHighLightWidget(
                  heading: "Platfrom",
                  content: marketplaceRequest.requestDetails.getPlatformList(),
                ),
              ),
            ],
          ),
          HorizontalDetailsWidget(
            widgets: [
              Expanded(
                child: KeyHighLightWidget(
                  heading: "Language",
                  content: marketplaceRequest.requestDetails.getLanguageList(),
                ),
              ),
              Expanded(
                child: KeyHighLightWidget(
                  heading: "Location",
                  content: marketplaceRequest.requestDetails.getLocationList(),
                ),
              ),
            ],
          ),
          HorizontalDetailsWidget(
            widgets: [
              Expanded(
                child: KeyHighLightWidget(
                  heading: "Required count",
                  content:
                      "${marketplaceRequest.requestDetails?.creatorCountMin ?? 10} - ${marketplaceRequest.requestDetails?.creatorCountMax ?? 20}",
                ),
              ),
              Expanded(
                child: KeyHighLightWidget(
                  heading: "Our Budget",
                  content:
                      "₹${marketplaceRequest.requestDetails?.budget ?? 150000}",
                ),
              ),
            ],
          ),
          HorizontalDetailsWidget(
            widgets: [
              Expanded(
                child: KeyHighLightWidget(
                  heading: "Brand collab with",
                  content: marketplaceRequest.requestDetails?.brand ?? "Swiggy",
                ),
              ),
              Expanded(
                child: RequiredFollowersWidget(
                  heading: "Required followers",
                  platformList:
                      marketplaceRequest.requestDetails?.platform ?? [],
                  followersRange:
                      marketplaceRequest.requestDetails?.followersRange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HorizontalDetailsWidget extends StatelessWidget {
  final List<Widget> widgets;
  const HorizontalDetailsWidget({
    super.key,
    required this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widgets,
      ),
    );
  }
}

class KeyHighLightWidget extends StatelessWidget {
  final String heading;
  final String content;
  const KeyHighLightWidget({
    super.key,
    required this.heading,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.bottomNavUnselectedColor,
          ),
        ),
      ],
    );
  }
}

class RequiredFollowersWidget extends StatelessWidget {
  final List<String> platformList;
  final String heading;
  final FollowersRange? followersRange;
  const RequiredFollowersWidget({
    super.key,
    required this.heading,
    required this.platformList,
    this.followersRange,
  });

  Widget socialMediaWidget({
    required String assetPath,
    required String followersCount,
  }) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: SvgPicture.asset(
            assetPath,
            height: 16,
            width: 16,
          ),
        ),
        Text(
          followersCount,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.bottomNavUnselectedColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: Text(
            heading,
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        if (platformList.isEmpty)
          socialMediaWidget(
            assetPath: "assets/icons/details/instagram.svg",
            followersCount: "500k - 1M+",
          ),
        ...List.generate(
          platformList.length,
          (index) {
            if (platformList[index] == "YouTube") {
              socialMediaWidget(
                assetPath: "assets/icons/details/youtube.svg",
                followersCount:
                    "${followersRange?.ytSubscribersMin ?? "500"} - ${followersRange?.ytSubscribersMax ?? "1M"}+",
              );
            }
            return socialMediaWidget(
              assetPath: "assets/icons/details/instagram.svg",
              followersCount:
                  "${followersRange?.igFollowersMin ?? "500"} - ${followersRange?.igFollowersMax ?? "1M"}+",
            );
          },
        ),
      ],
    );
  }
}

class ShareWidget extends StatelessWidget {
  final String assetPath;
  final String shareContent;
  final String appName;
  final Color backGroundColor;

  const ShareWidget({
    super.key,
    required this.assetPath,
    required this.shareContent,
    required this.appName,
    required this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backGroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Image.asset(
                assetPath,
                height: 16,
                width: 16,
              ),
            ),
            Flexible(
              child: Text(
                shareContent,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            Flexible(
              child: Text(
                appName,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HighlightsWidget extends StatelessWidget {
  final String assestPath;
  final String content;
  final ColorFilter? colorFilter;
  const HighlightsWidget({
    super.key,
    required this.assestPath,
    required this.content,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0XFFF5F6FB),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: SvgPicture.asset(
                assestPath,
                colorFilter: colorFilter,
                height: 16,
                width: 16,
              ),
            ),
            Flexible(
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.searchInputHintColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LookingForWidget extends StatelessWidget {
  final String serviceType;
  const LookingForWidget({
    super.key,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Text(
            "Looking for",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.searchInputHintColor,
            ),
          ),
        ),
        Row(
          children: [
            SvgPicture.asset(
              serviceType.getServiceTypeLogo(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  serviceType,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
