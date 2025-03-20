import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mobile_app_flutter/src/core/errors/failure.dart';
import 'package:mobile_app_flutter/src/core/network/dio_client.dart';
import 'package:mobile_app_flutter/src/screens/user/cubit/user_flow/user_flow_event.dart';
import 'package:mobile_app_flutter/src/screens/user/cubit/user_flow/user_flow_state.dart';
import 'package:http/http.dart' as http;

class UserFlowBloc extends Bloc<UserFlowEvent, UserFlowState> {
  final DioClient _dioClient = DioClient();
  
  UserFlowBloc() : super(UserFlowInitial()) {
    on<UserFlowEvent>((event, emit) {});
    on<LoadUsersEvent>(loadUsersEvent);
  }

  int page = 1;
  bool hasMore = true;
  bool isMaxPage = false;
  List<dynamic> users = [];

  FutureOr<void> loadUsersEvent(LoadUsersEvent event, Emitter<UserFlowState> emit) async {
    try {
      print("📢 Fetching Users... Page: $page, Initial: ${event.isInitialEvent}");

      if (event.isInitialEvent) {
        isMaxPage = false;
        page = 1;
        users.clear();
        emit(UsersLoadingState());
      }

      if (!isMaxPage) {
        if (!event.isInitialEvent) {
          page++;
        }

        final response = await _dioClient.getRequest('/api/v1/users', queryParams: {'page': page});

        if (response != null && response.statusCode == 200) {
          final responseData = response.data;

          if (responseData['success']) {
            final List<dynamic> newUsers = responseData['data']['data'];
            final int totalPages = responseData['data']['last_page'];

            if (newUsers.isEmpty || page >= totalPages) {
              hasMore = false;
              isMaxPage = true;
            } else {
              hasMore = true;
              isMaxPage = false;
            }
            print('new user ${newUsers}');
            users.addAll(newUsers);

            emit(UsersSuccessState(data: users, hasMore: hasMore));
          } else {
            emit(UsersErrorState(failure: TypeFailure(errorCode: 500, errorMessage: responseData['message'] ?? "Failed to load users")));
          }
        } else {
            emit(UsersErrorState(failure: ServerFailure(errorCode: 500, errorMessage: "Internal Server Error")));
        }
      } else {
        hasMore = false;
      }
    } catch (e) {
      emit(UsersErrorState(failure: ServerFailure(errorCode: e is Failure ? e.errorCode : 500, errorMessage: e is Failure ? e.errorMessage : "")));
    }
  }
}