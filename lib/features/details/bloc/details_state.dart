part of 'details_bloc.dart';

@immutable
sealed class DetailsState {}

abstract class DetailsActionState extends DetailsState {}

final class DetailsInitial extends DetailsState {}

final class DetailsLoadingState extends DetailsState {}

final class DetailsSuccesState extends DetailsState {
  final MarketplaceRequest marketplaceRequest;

  DetailsSuccesState({required this.marketplaceRequest});
}

final class DetailsErrorState extends DetailsState {
  final String errorMessage;

  DetailsErrorState({required this.errorMessage});
}

final class NavigateToBackState extends DetailsActionState {}

final class ButtonTapState extends DetailsActionState {
  final String message;

  ButtonTapState({required this.message});
}
