part of 'users_list_bloc.dart';

abstract class UsersListState extends Equatable {
  const UsersListState();

  @override
  List<Object> get props => [];
}

class UsersListInitial extends UsersListState {}

class UsersListLoading extends UsersListState {}

class UsersListLoaded extends UsersListState {
  final List<User> userModel;

  const UsersListLoaded(this.userModel);
}

class UsersListError extends UsersListState {
  final String message;

  const UsersListError(this.message);
}
