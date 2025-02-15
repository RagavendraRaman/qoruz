part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationState {}

final class BottomNavigationInitial extends BottomNavigationState {}

final class ChangeScreenState extends BottomNavigationState {
  final int screenId;

  ChangeScreenState({required this.screenId});
}
