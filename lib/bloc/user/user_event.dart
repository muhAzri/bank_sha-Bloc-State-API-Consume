part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserGetByUsermame extends UserEvent {
  final String username;

  UserGetByUsermame(this.username);

  @override
  List<Object> get props => [username];
}

class UserGetRecent extends UserEvent {}
