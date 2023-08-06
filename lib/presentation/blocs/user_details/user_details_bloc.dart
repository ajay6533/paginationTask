import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:task/models/user_details_model.dart';

import '../../../repo/users_repo.dart';

part 'user_details_event.dart';

part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  num? userID;

  UserDetailsBloc({this.userID}) : super(UserDetailsInitial()) {
    UserDetailsModel user = UserDetailsModel();

    on<UserDetailsEvent>((event, emit) async {
      if (event is UsersDetailsLoadEvent) {
        emit(UsersDetailsInitialLoading(message: 'Fetching users....'));
        final response = await UserRepo.getUserDetails(userId: userID ?? 0);
        response.fold(
            (l) => emit(UsersDetailsLoaded(
                  user: user,
                )),
                (r) {
          user = UserDetailsModel(
            data: r.data,
          );
          if (user.data! == null) {
            emit(UsersDetailsEmpty());
          } else {
            emit(UsersDetailsLoaded(user: user));
          }
        });
      }
    });
  }
}
