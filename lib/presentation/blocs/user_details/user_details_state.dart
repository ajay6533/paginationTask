part of 'user_details_bloc.dart';

abstract class UserDetailsState  {
  const UserDetailsState();
}

class UserDetailsInitial extends UserDetailsState {
  @override
  List<Object> get props => [];
}

//State for initial Loading when current page will be 1
class UsersDetailsInitialLoading extends UserDetailsState {
  final String message;
  UsersDetailsInitialLoading({required this.message});
}

class UsersDetailsInitialError extends UserDetailsState {
  final String message;
  UsersDetailsInitialError({required this.message});
}

class UsersDetailsEmpty extends UserDetailsState {}

class UsersDetailsLoaded extends UserDetailsState {
  final UserDetailsModel user;

  UsersDetailsLoaded({
    required this.user,
  });
}


