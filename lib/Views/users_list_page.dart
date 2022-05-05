import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/user_model.dart';
import '../View_Model/bloc/users_list_bloc.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool isLoading = true;
  //final UsersListBloc _bloc = UsersListBloc();
  final UsersListBloc _bloc = UsersListBloc();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    _bloc.add(getUsersList());

    //code to check when scroll reaches end
    // scrollController.addListener(() {
    //   if (scrollController.position.maxScrollExtent ==
    //       scrollController.offset) {
    //     _bloc.add(getUsersList());
    //   }
    // });
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
    return NotificationListener<ScrollNotification>(
      onNotification: _handelScrollNotification,
      child: ListView.builder(
        controller: scrollController,
        itemCount: userModel.length + 1,
        itemBuilder: (context, index) {
          return index > userModel.length-1
              ? _buildLoading()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: ClipOval(
                        child: Image.network(userModel[index].avatarUrl)),
                    title: Text(userModel[index].login),
                  ),
                );
        },
      ),
    );
  }

  Widget _buildLoading() {
    //print('Inside  Loading');
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  bool _handelScrollNotification(ScrollNotification notification) {
    //print('In scroll handler');
    if (notification is ScrollEndNotification && scrollController.position.maxScrollExtent == scrollController.offset ) {
      _bloc.add(getUsersList());
    }
    return false;
  }
}
