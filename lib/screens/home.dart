import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_books/blocs/blocs.dart';
import 'package:free_books/models/book.dart';
import 'package:free_books/screens/screens.dart';
import 'package:free_books/widgets/filtered_books.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksBloc, BooksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Free Books'),
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(Icons.book),
          ),
          actions: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.file_upload),
                iconSize: 30,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) {
                        if(BlocProvider.of<BooksBloc>(context).isLoggedIn) {
                          return AddEditScreen(isEditing: false, onSave: (Book book) {},);
                        }
                        else {
                          return WelcomeScreen();
                        }
                      }
                  ));

                  print('hello');
                },
                splashColor: Colors.blue[900],
              ),
            ),

          ],),
          body: FilteredBooks(),
        );
      },
    );
  }
}