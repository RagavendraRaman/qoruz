part of 'details_bloc.dart';

@immutable
sealed class DetailsEvent {}

final class GetDetailsEvent extends DetailsEvent {
  final String id;

  GetDetailsEvent({required this.id});
}

final class NavigateToBackEvent extends DetailsEvent {}

final class ButtonTapEvent extends DetailsEvent {
  final String message;

  ButtonTapEvent({required this.message});
}
