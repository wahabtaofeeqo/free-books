import 'package:equatable/equatable.dart';
import 'package:free_books/models/book.dart';
import 'package:free_books/models/visibility_filter.dart';

class FilteredBooksEvent extends Equatable {

  const FilteredBooksEvent();

  @override
  List<Object> get props => [];
}

class FilterUpdated extends FilteredBooksEvent {
  final VisibilityFilter filter;

  const FilterUpdated(this.filter);

  @override
  List<Object> get props => [filter];
}

class BooksUpdated extends FilteredBooksEvent {
  final List<Book> books;

  const BooksUpdated(this.books);

  @override
  List<Object> get props => [books];
}