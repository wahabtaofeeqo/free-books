import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:free_books/blocs/filtered_books/filtered_books.dart';
import 'package:free_books/models/models.dart';
import 'package:free_books/widgets/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class FilteredBooks extends StatelessWidget {

  FilteredBooks({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredBooksBloc, FilteredBooksState>(
      builder: (context, state) {
        if(state is FilteredBooksLoadingState) {
          return LoadingIndicator();
        }
        else if(state is FilteredBooksLoadSuccessState) {
          final books = state.books;
          return Container(
            margin: EdgeInsets.all(4.0),
            child: (books.isEmpty) ? _buildEmptyWidget() : _buildBooksWidget(books)
          );
        }
        else {
          return Container();
        }
      },
    );
    }

    Widget _buildEmptyWidget() => Center(
      child: Text('No Books Yet!'),
    );

    Widget _buildBooksWidget(List<Book> books) {
      return StaggeredGridView.countBuilder(
        itemCount: books.length,
        crossAxisCount: 4,
        itemBuilder: (BuildContext context, int index) {
          final book = books[index];
          return GestureDetector(
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(
                        Radius.circular(15))
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(15)
                    ),
                    child: (book.logo == null || book.logo.isEmpty) ? Image.asset('assets/images/book.png') : FadeInImage.memoryNetwork(
                      image: book.logo,
                      placeholder: kTransparentImage,
                      fit: BoxFit.fill,
                    )
                )
            ),
            onTap: () {
              showBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      height: 200,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      child: Text('Title: ${book.name}'),
                                      padding: EdgeInsets.only(bottom: 5),
                                    ),
                                    Padding(
                                      child: Text('Department: ${book.department}'),
                                      padding: EdgeInsets.only(bottom: 5),
                                    ),
                                    Padding(
                                      child: Text('Views: ${book.views}'),
                                      padding: EdgeInsets.only(bottom: 5),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  width: double.infinity,
                                  child: (book.logo == null || book.logo.isEmpty) ? Image.asset('assets/images/book.png', height: 100,) : FadeInImage.memoryNetwork(
                                    image: book.logo,
                                    placeholder: kTransparentImage,
                                    height: 100,
                                  ),
                                ),
                              )
                            ],
                          ),

                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, 'details', arguments: book);
                                      },
                                      child: Text('Check', style: TextStyle(color: Colors.red),)
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, 'chat', arguments: book);
                                    },
                                    child: Text('Chat with owner'),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
              );
            },
          );
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 3 : 2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      );
    }
}