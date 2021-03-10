import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_books/blocs/books/books_event.dart';
import 'package:free_books/blocs/books/books_state.dart';
import 'package:free_books/models/book.dart';
import 'package:free_books/models/chat.dart';
import 'package:free_books/repositories/books_repository.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {

  final BooksRepository repository;
  List<Book> _books;
  List<Book> myBooks = [];

  BooksBloc({@required this.repository}) : super(BooksLoadingState());

  @override
  Stream<BooksState> mapEventToState(BooksEvent event) async* {
    if (event is BooksLoadSuccessEvent)
      yield* _loadSuccess(event);
    else if(event is BooksLoadingEvent)
      yield* _load(event);
    else if(event is BookAddedEvent)
      yield* _bookAdded(event);
    else if(event is SendMessageEvent)
      _sendChat(event);
    else if(event is LoadChatEvent)
      yield* _loadChats(event);
  }

  Stream<BooksState> _loadSuccess(BooksEvent event) async* {
    yield BooksLoadedState(this._books);
  }

  Stream<BooksState> _load(BooksEvent event) async* {

    try {
      List<Book> list = new List();

      QuerySnapshot snapshot = await repository.books;
      snapshot.docs.forEach((element) {
        final Book book = Book.fromSnapshot(element);
        if(element.data()['userid'] == FirebaseAuth.instance.currentUser.uid)
          myBooks.add(book);
        else
          list.add(book);
      });

      print(myBooks.length);
      this._books = list;
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

    book.userid = FirebaseAuth.instance.currentUser.uid;

    File file = File(book.logo);
    var arr = book.logo.split("/");
    var image = "images/${arr.last}";

    try {
      Reference ref = FirebaseStorage.instance.ref().child(image);
      await ref.putFile(file);

      String url = await FirebaseStorage.instance.ref(image).getDownloadURL();
      print(url);
      book.logo = url;

      return _saveBook(book);
    }
    catch(err) {
      print(err);
    }

    return false;
  }

  Future<bool> _saveBook(Book book) async {
    await FirebaseFirestore.instance.collection('books').add(book.toMap());
    return true;
  }

  Stream<BooksState> _loadChats(LoadChatEvent event) async* {
    List<Chat> chats = new List();

    QuerySnapshot snapshot = await repository.loadChats(event.node);
    snapshot.docs.forEach((element) {
      chats.add(Chat.fromSnapshot(element));
    });

    yield ChatsLoadedState(chats);
  }

  _sendChat(SendMessageEvent event) {
    try {
      repository.sendChat(event.chat, event.node);
    }
    catch(err) {
      print(err);
    }
  }
}