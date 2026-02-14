part of 'connectivity_cubit.dart';

@immutable
sealed class ConnectivityState extends Equatable {}

final class ConnectivityInitial extends ConnectivityState {
  @override
  List<Object?> get props => [];
}

class ConnectivityOnline extends ConnectivityState {
  final String connectionType;
  
  ConnectivityOnline(this.connectionType);
  
  @override
  List<Object?> get props => [connectionType];
}

class ConnectivityOffline extends ConnectivityState {
  @override
  List<Object?> get props => [];
}
