import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_books/models/models.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Book book = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/book.png',
                    ),
                    fit: BoxFit.fill
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}