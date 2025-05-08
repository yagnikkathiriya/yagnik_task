
import 'package:equatable/equatable.dart';
import 'package:yagnik_task/model/user_model.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object?> get props => [];
}

class FetchUsers extends UserEvent {
  final int page;
  const FetchUsers({this.page = 1});
}

class LoadMoreUsers extends UserEvent {
  final int page;
  const LoadMoreUsers({required this.page});
}

class AddUser extends UserEvent {
  final User user;
  const AddUser(this.user);
}

class EditUser extends UserEvent {
  final User user;
  const EditUser(this.user);
}

class SearchUsers extends UserEvent {
  final String query;
  const SearchUsers(this.query);
}
