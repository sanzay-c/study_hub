part of 'main_bottom_nav_bloc.dart';

@immutable
sealed class MainBottomNavEvent extends Equatable {
  const MainBottomNavEvent();

  @override
  List<Object> get props => [];
}

final class NavSlugChanged extends MainBottomNavEvent {
  final String slug;

  const NavSlugChanged(this.slug);

  @override
  List<Object> get props => [slug];
}