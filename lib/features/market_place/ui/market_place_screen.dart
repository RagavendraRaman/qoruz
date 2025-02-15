import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qoruz/features/details/ui/details_screen.dart';
import 'package:qoruz/features/market_place/bloc/market_place_bloc.dart';
import 'package:qoruz/features/market_place/modal/market_place_modal.dart';
import 'package:qoruz/reusable_widgets/circle_progress_indicator.dart';
import 'package:qoruz/reusable_widgets/gradient_appbar.dart';
import 'package:qoruz/utils/app_colors.dart';
import 'package:qoruz/utils/app_constants.dart';
import 'package:qoruz/utils/extensions.dart';
import 'package:readmore/readmore.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({super.key});

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen>
    with AutomaticKeepAliveClientMixin<MarketPlaceScreen> {
  final ScrollController scrollController = ScrollController();
  final MarketPlaceBloc marketPlaceBloc = MarketPlaceBloc();
  late MarketMeta marketMeta;
  Set<MarketplaceRequest> marketplaceRequestSet = {};
  late Pagination pagination;
  int selectedChoice = 1;
  List<String> chipsList = [
    "For You",
    "Recent",
    "My Requests",
    "Top Rating",
  ];
  int page = 1;

  @override
  void initState() {
    marketPlaceBloc.add(GetPostsEvent());
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          pagination.hasMore) {
        marketPlaceBloc.add(GetPaginationEvent(page: page));
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double width = context.width();
    return BlocConsumer<MarketPlaceBloc, MarketPlaceState>(
      bloc: marketPlaceBloc,
      listenWhen: (previous, current) => current is MarketPlaceActionState,
      buildWhen: (previous, current) => current is! MarketPlaceActionState,
      listener: (context, state) {
        if (state is NavigateToDetailsState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => DetailsScreen(
                id: state.id,
              ),
            ),
          );
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
        return Scaffold(
          body: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                const GradientAppbar(title: "Marketplace"),
                bodyWidget(width, state),
              ],
            ),
          ),
          floatingActionButton: GestureDetector(
            onTap: () => marketPlaceBloc.add(ButtonTapEvent(
              message: "Post Request Pressed",
            )),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.bottomNavselectedColor,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Icon(
                        Icons.add,
                        color: AppColors.whiteColor,
                        size: 20,
                      ),
                    ),
                    Text(
                      "Post Request ",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget bodyWidget(double width, MarketPlaceState state) {
    if (state is MarketPlaceLoadingState) {
      return const Padding(
        padding: EdgeInsets.only(top: 100.0),
        child: Center(
          child: CircleProgressIndicatorWidget(
            height: 30,
          ),
        ),
      );
    } else if (state is MarketPlaceErrorState) {
      return Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Center(
          child: Text(state.errorMessage),
        ),
      );
    } else if (state is MarketPlaceSucessState) {
      marketMeta = state.marketMeta;
      pagination = marketMeta.pagination;
      marketplaceRequestSet.addAll(marketMeta.marketplaceRequests);
      page = pagination.hasMore ? page + 1 : page;
    } else if (state is ChoiceChangedState) {
      selectedChoice = state.changedChoiceIndex;
    } else if (state is PaginatedState) {
      marketplaceRequestSet.addAll(state.marketPlaceRequestList);
      pagination = state.pagination;
    }
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: width * AppConstants.horizontalPadding,
          ),
          child: SizedBox(
            width: width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: AppColors.searchInputBorder,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        "assets/icons/market_place/profile_image.png",
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "Type your requirement here. . .",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.searchInputHintColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: SizedBox(
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: chipsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left:
                        index == 0 ? width * AppConstants.horizontalPadding : 0,
                    right: index == chipsList.length - 1
                        ? width * AppConstants.horizontalPadding
                        : 10,
                    bottom: 1,
                  ),
                  child: GestureDetector(
                    onTap: () => marketPlaceBloc.add(ChangeChoiceEvent(
                      choiceIndex: index,
                      choice: chipsList[index],
                    )),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: selectedChoice == index
                            ? AppColors.choiceSelectedColor
                            : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: index == selectedChoice
                              ? AppColors.bottomNavselectedColor
                              : AppColors.searchInputBorder,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (chipsList[index] == "Top Rating")
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 3.0,
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/market_place/star.svg",
                                ),
                              ),
                            Text(chipsList[index]),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (selectedChoice != 1)
          const Padding(
            padding: EdgeInsets.only(top: 100),
            child: Center(
              child: Text(
                "Looks Empty Here!",
                textAlign: TextAlign.center,
              ),
            ),
          )
        else
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  marketplaceRequestSet.length + (pagination.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < marketplaceRequestSet.length) {
                  MarketplaceRequest marketplaceRequest =
                      marketplaceRequestSet.elementAt(index);
                  return GestureDetector(
                    onTap: () => marketPlaceBloc.add(NavigateToDetailEvent(
                      id: marketplaceRequest.idHash,
                    )),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: width * AppConstants.horizontalPadding,
                        right: width * AppConstants.horizontalPadding,
                        top: marketplaceRequest.isHighValue ? 20 : 10,
                        bottom: index == marketplaceRequestSet.length - 1
                            ? pagination.hasMore
                                ? 20
                                : 70
                            : 0,
                      ),
                      child: PostWidget(
                        marketplaceRequest: marketplaceRequest,
                      ),
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: CircleProgressIndicatorWidget(
                        height: 30,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PostWidget extends StatelessWidget {
  final MarketplaceRequest marketplaceRequest;
  const PostWidget({super.key, required this.marketplaceRequest});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border.all(color: AppColors.detailsPageDividerColor),
            boxShadow: [
              BoxShadow(
                offset: const Offset(1, 1),
                color: AppColors.searchInputHintColor.withOpacity(0.3),
                spreadRadius: -1,
                blurRadius: 1,
              ),
              BoxShadow(
                offset: const Offset(-1, -1),
                color: AppColors.searchInputHintColor.withOpacity(0.3),
                spreadRadius: -1,
                blurRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: marketplaceRequest.userDetails.profileImage == null
                          ? Image.asset(
                              "assets/icons/details/profile_picture.png",
                              fit: BoxFit.fill,
                              height: 50,
                              width: 50,
                            )
                          : CachedNetworkImage(
                              imageUrl:
                                  marketplaceRequest.userDetails.profileImage!,
                              height: 50,
                              width: 50,
                            ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              marketplaceRequest.userDetails.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "${marketplaceRequest.userDetails.designation} at ${marketplaceRequest.userDetails.company}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.searchInputHintColor,
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/market_place/clock.svg",
                                  height: 14,
                                  width: 14,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.bottomNavUnselectedColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: Text(
                                      marketplaceRequest.createdAt
                                          .convertPostedDuration(
                                        marketplaceRequest.createdAt,
                                      ),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color:
                                            AppColors.bottomNavUnselectedColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/market_place/forward_icon.svg",
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        marketplaceRequest.serviceType.getServiceTypeLogo(),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Looking for ${marketplaceRequest.serviceType}",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Divider(
                    color: AppColors.detailsPageDividerColor,
                    height: 0,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ReadMoreText(
                    "Budget: ₹1,50,000 \nBrand: WanderFit LuggageLocation: Goa & KeralaType: Lifestyle & Adventure travel content with a focus on young, urban audiencesLanguage: English and HindiLooking for a travel influencer who can showcase our premium luggage line in scenic beach and nature destinations. Content should emphasize ease of travel and durability of the product.",
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    colorClickableText: AppColors.searchInputHintColor,
                    trimCollapsedText: "more",
                    trimExpandedText: "",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: HighlightsWidget(
                    assestPath: "assets/icons/market_place/location.svg",
                    content:
                        marketplaceRequest.requestDetails.getLocationList(),
                  ),
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    const HighlightsWidget(
                      colorFilter: ColorFilter.mode(
                        AppColors.descriptionTextColor,
                        BlendMode.srcIn,
                      ),
                      assestPath: "assets/icons/details/instagram.svg",
                      content: "10k - 100k",
                    ),
                    HighlightsWidget(
                      assestPath: "assets/icons/market_place/category.svg",
                      content: marketplaceRequest.requestDetails
                          .getCatergoriesList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (marketplaceRequest.isHighValue)
          Positioned(
            right: 20,
            top: -10,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: const LinearGradient(
                  colors: [
                    Color(0XFFFE9C13),
                    Color(0XFFFB9428),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: SvgPicture.asset(
                        "assets/icons/market_place/hign_value.svg",
                      ),
                    ),
                    const Text(
                      "HIGH VALUE ",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  String convertPostedDuration(String createdAt) {
    List<String> splittedString = createdAt.split(" ");
    if (splittedString.length <= 1) {
      return createdAt;
    }
    return "${splittedString.first}${splittedString[1][0]}";
  }
}
