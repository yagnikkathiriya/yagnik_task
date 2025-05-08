import 'package:equatable/equatable.dart';
import 'package:yagnik_task/model/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  final bool hasMore;
  
  const UserLoaded({required this.users, this.hasMore = true});

  @override
  List<Object?> get props => [users, hasMore];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
