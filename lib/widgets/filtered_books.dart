import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:free_books/blocs/blocs.dart';
import 'package:free_books/blocs/filtered_books/filtered_books.dart';
import 'package:free_books/widgets/widgets.dart';

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
          if(books.isEmpty != false) {
            return StaggeredGridView.countBuilder(
                itemCount: books.length,
                crossAxisCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      color: Colors.green,
                      child: new Center(
                        child: new CircleAvatar(
                          backgroundColor: Colors.white,
                          child: new Text('$index'),
                        ),
                      )
                  );
                },
                staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 1),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
            );
          }
          else {
            return Center(child: RaisedButton(child: Text('Upload Books',), onPressed: () {
              if(BlocProvider.of<BooksBloc>(context).isLoggedIn) {
                Navigator.pushNamed(context, 'addBook');
              }
              else {
                Navigator.pushNamed(context, 'login');
              }
            },),);
          }
        }
        else {
          return Container();
        }
      },
    );
    }
}