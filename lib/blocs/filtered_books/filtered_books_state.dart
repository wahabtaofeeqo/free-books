import 'package:equatable/equatable.dart';
import 'package:free_books/models/book.dart';
import 'package:free_books/models/visibility_filter.dart';

abstract class FilteredBooksState extends Equatable {

  const FilteredBooksState();

  @override
  List<Object> get props => [];
}

class FilteredBooksLoadingState extends FilteredBooksState {}

class FilteredBooksLoadSuccessState extends FilteredBooksState {
  final List<Book> books;
  final VisibilityFilter visibilityFilter;

  const FilteredBooksLoadSuccessState(this.books, this.visibilityFilter);

  @override
  List<Object> get props => [books, visibilityFilter];
}