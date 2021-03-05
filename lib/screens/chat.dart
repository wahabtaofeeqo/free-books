import 'package:flutter/material.dart';
import 'package:free_books/models/models.dart';

class ChatScreen extends StatefulWidget {

  static const routeName = 'chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final Book book = ModalRoute.of(context).settings.arguments;
    return Center(
      child: Text('Hello ${book.name}'),
    );
  }
}