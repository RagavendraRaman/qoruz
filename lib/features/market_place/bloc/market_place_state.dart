part of 'market_place_bloc.dart';

@immutable
sealed class MarketPlaceState {}

abstract class MarketPlaceActionState extends MarketPlaceState {}

final class MarketPlaceInitial extends MarketPlaceState {}

final class MarketPlaceLoadingState extends MarketPlaceState {}

final class MarketPlaceSucessState extends MarketPlaceState {
  final MarketMeta marketMeta;

  MarketPlaceSucessState({required this.marketMeta});
}

final class MarketPlaceErrorState extends MarketPlaceState {
  final String errorMessage;

  MarketPlaceErrorState({required this.errorMessage});
}

final class ChoiceChangedState extends MarketPlaceState {
  final int changedChoiceIndex;

  ChoiceChangedState({required this.changedChoiceIndex});
}

final class NavigateToDetailsState extends MarketPlaceActionState {
  final String id;

  NavigateToDetailsState({required this.id});
}

final class PaginatedState extends MarketPlaceState {
  final List<MarketplaceRequest> marketPlaceRequestList;
  final Pagination pagination;

  PaginatedState({
    required this.marketPlaceRequestList,
    required this.pagination,
  });
}

final class ButtonTapState extends MarketPlaceActionState {
  final String message;

  ButtonTapState({required this.message});
}
