import 'package:equatable/equatable.dart';

abstract class UsersState extends Equatable {

  const UsersState();

  @override
  List<Object> get props => [];
}

class AddUserState extends UsersState {}