import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_project/bloc/users_list_bloc.dart';

import '../Models/user_model.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool isLoading = true;
  //final UsersListBloc _bloc = UsersListBloc();
  final UsersListBloc _bloc = UsersListBloc();

  @override
  void initState() {
    _bloc.add(getUsersList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildUsersList();
  }

  Widget _buildUsersList() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<UsersListBloc, UsersListState>(
          listener: (context, state) {
            //Initial checking for any error
            if (state is UsersListError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<UsersListBloc, UsersListState>(
            builder: (context, state) {
              if (state is UsersListInitial) {
                isLoading = true;
                return _buildLoading();
              } else if (state is UsersListLoading) {
                isLoading = true;
                return _buildLoading();
              } else if (state is UsersListLoaded) {
                isLoading = false;
                return _buildUserTile(context, state.userModel);
              } else if (state is UsersListError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUserTile(BuildContext context, List<User> userModel) {
    return ListView.builder(
      itemCount: userModel.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading:
                ClipOval(child: Image.network(userModel[index].avatarUrl)),
            title: Text(userModel[index].login),
          ),
        );
      },
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
