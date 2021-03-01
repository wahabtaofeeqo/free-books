import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_books/blocs/blocs.dart';
import 'package:free_books/blocs/filtered_books/filtered_books.dart';
import 'package:free_books/models/book.dart';
import 'package:free_books/models/visibility_filter.dart';

class FilteredBooksBloc extends Bloc<FilteredBooksEvent, FilteredBooksState> {

  final BooksBloc booksBloc;
  StreamSubscription subscription;

  FilteredBooksBloc({@required this.booksBloc}): super(booksBloc.state is BooksLoadedState ?
  FilteredBooksLoadSuccessState((booksBloc.state as BooksLoadedState).books, VisibilityFilter.All) :
  FilteredBooksLoadingState()) {
    subscription = booksBloc.listen((state) {
      if (state is BooksLoadedState) {
        add(BooksUpdated((booksBloc.state as BooksLoadedState).books));
      }
    });
  }

  @override
  Stream<FilteredBooksState> mapEventToState(FilteredBooksEvent event) async* {

    if(event is FilterUpdated) {
      yield* _updateFilter(event);
    }
    else if(event is BooksUpdated) {
      yield* _updateBooks(event);
    }
  }

  Stream<FilteredBooksState> _updateFilter(FilterUpdated event) async* {
    if(booksBloc.state is BooksLoadedState) {
      yield FilteredBooksLoadSuccessState(_mapBooksToFiltered((booksBloc.state as BooksLoadedState).books, event.filter), event.filter);
    }
  }

  Stream<FilteredBooksState> _updateBooks(BooksUpdated event) async* {
    final filter = state is FilteredBooksLoadSuccessState ? (state as FilteredBooksLoadSuccessState).visibilityFilter : VisibilityFilter.All;
    yield FilteredBooksLoadSuccessState(_mapBooksToFiltered((booksBloc.state as BooksLoadedState).books, filter), filter);
  }

  List<Book> _mapBooksToFiltered(List<Book> books, VisibilityFilter filter) {
    return books;
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}