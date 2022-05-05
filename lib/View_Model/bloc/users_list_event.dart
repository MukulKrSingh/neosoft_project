// ignore_for_file: camel_case_types

part of 'users_list_bloc.dart';

abstract class UsersListEvent extends Equatable {
  const UsersListEvent();

  @override
  List<Object> get props => [];
}

class getUsersList extends UsersListEvent {
}

//class getNextPage extends UsersListEvent {}
