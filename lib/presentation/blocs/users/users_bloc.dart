import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/user_list_model.dart';
import '../../../repo/users_repo.dart';
part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UserListModel users =  UserListModel(
    data: [],
    page: 1,
  );
  UsersBloc() : super(UsersInitial()) {
    on<UsersEvent>((event, emit) async {
      if (event is UsersLoadEvent) {
        bool isInitial = users.page == 1;
        isInitial
            ? emit(UsersInitialLoading(message: 'Fetching users....'))
            : emit(UsersLoaded(
                users: users,
                loading: LoadingMore(message: 'Fetching more users...')));
        final response =
            await UserRepo.getUsers(page: users.page!);
        response.fold(
            (l) => isInitial
                ? emit(UsersInitialError(message: 'Failed to load users'))
                : emit(UsersLoaded(
                    users: users,
                    error: LoadMoreError(
                        message: 'Failed to load more users'))), (r) {
          if (isInitial) {
            users = UserListModel(
                data: r.data,
                page: (r.totalPages != r.page!) ?  r.page! + 1 : 0,
            );

            if (users.data!.isEmpty) {
              emit(UsersEmpty());
            }
          } else {
            //Adding users to existing list
            users = UserListModel(
                data: users.data! + r.data!,
                page:(r.totalPages != r.page!) ?  r.page! + 1 : 0,
                );
          }
          emit(UsersLoaded(users: users));
        });
      }
    });
  }
}
