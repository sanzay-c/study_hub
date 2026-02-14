import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'main_bottom_nav_event.dart';
part 'main_bottom_nav_state.dart';

@injectable
class MainBottomNavBloc extends Bloc<MainBottomNavEvent, MainBottomNavState> {
  MainBottomNavBloc() : super(BottomNavInitial()) {
    on<NavSlugChanged>((event, emit) {
      emit((state as BottomNavInitial).copyWith(currentSlug: event.slug));
    });
  }
}
