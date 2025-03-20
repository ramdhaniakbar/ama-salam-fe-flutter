import 'package:equatable/equatable.dart';
import 'package:mobile_app_flutter/src/core/errors/failure.dart';

sealed class UserFlowState extends Equatable {
  const UserFlowState();

  @override
  List<Object> get props => [];
}

final class UserFlowInitial extends UserFlowState {}


class UsersLoadingState extends UserFlowState {}

class UsersSuccessState extends UserFlowState {
  final List<dynamic> data;
  final bool hasMore;

  const UsersSuccessState({required this.data, required this.hasMore});
}

final class UsersErrorState extends UserFlowState {
  final Failure failure;
  const UsersErrorState({required this.failure});
}