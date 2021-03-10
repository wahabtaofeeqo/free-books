import 'package:flutter/material.dart';
import 'package:free_books/models/book.dart';
import 'package:transparent_image/transparent_image.dart';

class MyBookCard extends StatelessWidget {

  final Book book;
  const MyBookCard(this.book);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 200,
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.black12,
            image: DecorationImage(
                image: (book.logo == null || book.logo.isEmpty) ? Image.asset('assets/images/book.png', fit: BoxFit.fill,).image : FadeInImage.memoryNetwork(
                  image: book.logo,
                  placeholder: kTransparentImage,
                  fit: BoxFit.fill,
                ).image
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5)
        ),
      ),

      onTap: () {
        showBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container();
          }
        );
      },
    );
  }
}