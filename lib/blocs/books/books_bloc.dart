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

  BooksBloc({@required this.repository}) : super(BooksLoadingState());

  @override
  Stream<BooksState> mapEventToState(BooksEvent event) async* {
    if (event is BooksLoadSuccessEvent)
      yield* _loadSuccess();
  }

  Stream<BooksState> _loadSuccess() async* {

    try {
      List<Book> list = new List();
      repository.books.forEach((snapshot) {
        snapshot.docs.forEach((element) {
          print(element);
          list.add(Book.fromSnapshot(element));
        });
      });

      yield BooksLoadedState(list);
    }
    catch(err) {
      yield BooksLoadFailure();
    }
  }

  bool get isLoggedIn {
   User user = FirebaseAuth.instance.currentUser;
   return user != null;
  }
}