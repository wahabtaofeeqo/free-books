import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:free_books/blocs/blocs.dart';
import 'package:free_books/blocs/filtered_books/filtered_books.dart';
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
            child: StaggeredGridView.countBuilder(
              itemCount: books.length,
              crossAxisCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(
                              Radius.circular(15))
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(15)
                          ),
                          child: Image.asset('assets/images/book.png')
                      )
                  ),
                  onTap: () {
                    final book = books[index];
                    print(book.name);
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
                                              child: Text('Views: 100'),
                                              padding: EdgeInsets.only(bottom: 5),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          width: double.infinity,
                                          child: Image.asset('assets/images/book.png', height: 100,),),
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
                                             Navigator.pushNamed(context, 'details', arguments: book);
                                           },
                                           child: Text('Check', style: TextStyle(color: Colors.red),)
                                         ),
                                         flex: 1,
                                       ),
                                       Expanded(
                                         child: RaisedButton(
                                           onPressed: () {
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
            ),
          );
        }
        else {
          return Container();
        }
      },
    );
    }
}