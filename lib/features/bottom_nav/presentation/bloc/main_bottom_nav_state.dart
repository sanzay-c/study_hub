part of 'main_bottom_nav_bloc.dart';

@immutable
sealed class MainBottomNavState extends Equatable {
  const MainBottomNavState();
  
  @override
  List<Object> get props => [];
}

final class BottomNavInitial extends MainBottomNavState {
  final String currentSlug;

  const BottomNavInitial({this.currentSlug = 'Groups'});

  BottomNavInitial copyWith({String? currentSlug}) {
    return BottomNavInitial(
      currentSlug: currentSlug ?? this.currentSlug,
    );
  }

  @override
  List<Object> get props => [currentSlug];
}