import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yagnik_task/model/user_model.dart';
import 'package:yagnik_task/repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;
  List<User> _cachedUsers = [];
  int currentPage = 1;

  UserBloc(UserRepository userRepository, {required this.repository}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<LoadMoreUsers>(_onLoadMoreUsers);
    on<AddUser>(_onAddUser);
    on<EditUser>(_onEditUser);
    on<SearchUsers>(_onSearchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await repository.fetchUsers(page: event.page);
      _cachedUsers = users;
      currentPage = event.page;
      if(users.isEmpty){
        emit(UserInitial());
      }
      emit(UserLoaded(users: _cachedUsers, hasMore: users.length == 10));
      
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onLoadMoreUsers(LoadMoreUsers event, Emitter<UserState> emit) async {
    try {
      final users = await repository.fetchUsers(page: event.page);
      _cachedUsers.addAll(users);
      currentPage = event.page;
      emit(UserLoaded(users: _cachedUsers, hasMore: users.length == 10));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _onAddUser(AddUser event, Emitter<UserState> emit) {
    _cachedUsers.insert(0, event.user);
    repository.addUserLocally(event.user);
    emit(UserLoaded(users: _cachedUsers, hasMore: true));
  }

  void _onEditUser(EditUser event, Emitter<UserState> emit) {
    final index = _cachedUsers.indexWhere((u) => u.id == event.user.id);
    if (index != -1) {
      _cachedUsers[index] = event.user;
      repository.updateUserLocally(event.user);
      emit(UserLoaded(users: _cachedUsers, hasMore: true));
    }
  }

  void _onSearchUsers(SearchUsers event, Emitter<UserState> emit) {
    final filtered = _cachedUsers
        .where((u) =>
            u.name.toLowerCase().contains(event.query.toLowerCase()) ||
            u.email.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(UserLoaded(users: filtered, hasMore: false));
  }
}
