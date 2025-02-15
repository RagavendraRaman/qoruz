part of 'market_place_bloc.dart';

@immutable
sealed class MarketPlaceEvent {}

final class GetPostsEvent extends MarketPlaceEvent {}

final class ChangeChoiceEvent extends MarketPlaceEvent {
  final int choiceIndex;
  final String choice;

  ChangeChoiceEvent({
    required this.choiceIndex,
    required this.choice,
  });
}

final class NavigateToDetailEvent extends MarketPlaceEvent {
  final String id;

  NavigateToDetailEvent({required this.id});
}

final class GetPaginationEvent extends MarketPlaceEvent {
  final int page;

  GetPaginationEvent({required this.page});
}

final class ButtonTapEvent extends MarketPlaceEvent {
  final String message;

  ButtonTapEvent({required this.message});
}
