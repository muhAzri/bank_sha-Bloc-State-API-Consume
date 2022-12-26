part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserFailed extends UserState {
  final String e;

  UserFailed(this.e);

  @override
  List<Object> get props => [e];
}

class UserSuccess extends UserState {
  final List<UserModel> users;

  UserSuccess(this.users);

  @override
  List<Object> get props => [users];
}
