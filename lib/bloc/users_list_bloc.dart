import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neosoft_project/Models/user_model.dart';
import 'package:neosoft_project/Services/api_services.dart';

part 'users_list_event.dart';
part 'users_list_state.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  UsersListBloc() : super(UsersListInitial()) {
    ApiServices _apiService = ApiServices();
    on<getUsersList>(
      (event, emit) async {
        try {
          //Loading State

          emit(UsersListLoading());
          print('in bloc');
          final usersList = await _apiService.getUsersFromApi();
          print('back with data ${usersList.length}');
          //Loaded State emitted
          emit(UsersListLoaded(usersList));

          //Error State
          if (usersList == Null) {
            emit(const UsersListError('Failed To load Users'));
          }
        } catch (e) {
          emit(const UsersListError('Failed Attempt'));
        }
      },
    );
  }
}
