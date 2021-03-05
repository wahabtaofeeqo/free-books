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
                icon: Icon(Icons.search),
                onPressed: () {
                  print('Searching');
                },
                splashColor: Colors.blue[900],
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.file_upload),
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
                },
                splashColor: Colors.blue[900],
              ),
            ),

            Container(
              color: Colors.black12,
              child: IconButton(
                icon: Icon(Icons.person),
                iconSize: 30,
                onPressed: () {
                  Navigator.pushNamed(context, ProfileScreen.routeName);
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