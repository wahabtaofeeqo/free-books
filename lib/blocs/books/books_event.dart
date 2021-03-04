import 'package:equatable/equatable.dart';
import 'package:free_books/models/book.dart';

abstract class BooksEvent extends Equatable {
  const BooksEvent();

  @override
  List<Object> get props => [];
}

class BooksLoadingEvent extends BooksEvent {}

class BooksLoadSuccessEvent extends BooksEvent {}

class BooksLoadFailEvent extends BooksEvent {}

class BookAddedEvent extends BooksEvent {
  final Book book;

  const BookAddedEvent(this.book);

  @override
  List<Object> get props => [book];
}

class BookUpdatedEvent extends BooksEvent {}

class BookDeletedEvent extends BooksEvent {
  final Book book;

  const BookDeletedEvent(this.book);

  @override
  List<Object> get props => [book];
}