part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

//State for initial Loading when current page will be 1
class UsersInitialLoading extends UsersState {
  final String message;
  UsersInitialLoading({required this.message});
}

class UsersInitialError extends UsersState {
  final String message;
  UsersInitialError({required this.message});
}

class UsersEmpty extends UsersState {}

class UsersLoaded extends UsersState {
  final UserListModel users;
  final LoadingMore? loading;
  final LoadMoreError? error;
  UsersLoaded({
    required this.users,
    this.loading,
    this.error,
  });
}

class LoadingMore {
  final String message;
  LoadingMore({required this.message});
}

class LoadMoreError {
  final String message;
  LoadMoreError({required this.message});
}
