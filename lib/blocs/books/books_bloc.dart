import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_books/blocs/books/books_event.dart';
import 'package:free_books/blocs/books/books_state.dart';
import 'package:free_books/models/book.dart';
import 'package:free_books/repositories/books_repository.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BooksRepository repository;
  String _defaultLogo = "assets/images/book.png";

  List<Book> books;

  BooksBloc({@required this.repository}) : super(BooksLoadingState());

  @override
  Stream<BooksState> mapEventToState(BooksEvent event) async* {
    if (event is BooksLoadSuccessEvent)
      yield* _loadSuccess(event);
    else if(event is BooksLoadingEvent)
      yield* _load(event);
    else if(event is BookAddedEvent)
      yield* _bookAdded(event);
  }

  Stream<BooksState> _loadSuccess(BooksEvent event) async* {
    yield BooksLoadedState(this.books);
  }

  Stream<BooksState> _load(BooksEvent event) async* {

    try {
      List<Book> list = new List();

      QuerySnapshot snapshot = await repository.books;
      snapshot.docs.forEach((element) {
        list.add(Book.fromSnapshot(element));
      });

      this.books = list;
      add(BooksLoadSuccessEvent());
    }
    catch(err) {
      yield BooksLoadFailure();
    }
  }

  Stream<BooksState> _bookAdded(BookAddedEvent event) async* {
    if(state is BooksLoadedState) {
      List<Book> books = List.from((state as BooksLoadedState).books)..add(event.book);
      yield BooksLoadedState(books);
    }
  }

  bool get isLoggedIn {
   User user = FirebaseAuth.instance.currentUser;
   return user != null;
  }

  Future<bool> addBook(Book book) async {

    if(book.logo == _defaultLogo) {
      final Map<String, dynamic> data = Map();
      data['name'] = book.name;
      data['department'] = book.department;
      data['logo'] = '';
      data['user'] = FirebaseAuth.instance.currentUser.email;

      DocumentReference reference = await FirebaseFirestore.instance.collection('books').add(data);
      print(reference);
      return reference != null;
    }
    else {
      return false;
    }
  }
}