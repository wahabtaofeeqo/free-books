import 'package:equatable/equatable.dart';
import 'package:free_books/models/book.dart';

abstract class BooksState extends Equatable {
  const BooksState();

  @override
  List<Object> get props => [];
}

class BooksLoadingState extends BooksState {}

class BooksLoadedState extends BooksState {
  final List<Book> books;

  const BooksLoadedState([this.books = const []]);

  @override
  List<Object> get props => [books];
}

class BooksLoadFailure extends BooksState {}