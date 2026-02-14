part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent extends Equatable {}

class ToggleThemeEvent extends ThemeEvent {
  ToggleThemeEvent();

  @override
  List<Object?> get props => [];
}