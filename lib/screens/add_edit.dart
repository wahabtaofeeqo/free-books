import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_books/blocs/blocs.dart';
import 'package:free_books/models/book.dart';

class AddEditScreen extends StatefulWidget {

  final bool isEditing;
  final Book book;

  AddEditScreen({Key key, @required this.isEditing, this.book}): super(key: key);

  @override
  State<StatefulWidget> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {

  static final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Book' : 'Add Book'),
      ),
    );
  }
}