import 'package:equatable/equatable.dart';
import 'package:free_books/models/models.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class AddUserEvent extends UserEvent {

  final User user;
  const AddUserEvent(this.user);

  @override
  List<Object> get props => [user];
}