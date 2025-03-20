import 'package:equatable/equatable.dart';

sealed class UserFlowEvent extends Equatable {
  const UserFlowEvent();

  @override
  List<Object> get props => [];
}

final class LoadUsersEvent extends UserFlowEvent {
  final bool isInitialEvent;

  const LoadUsersEvent({this.isInitialEvent = false});
}