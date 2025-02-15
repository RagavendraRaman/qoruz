part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationEvent {}

final class ChangeScreenEvent extends BottomNavigationEvent {
  final int screenIndex;

  ChangeScreenEvent({required this.screenIndex});
}
