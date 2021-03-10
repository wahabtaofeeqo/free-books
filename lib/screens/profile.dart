import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_books/blocs/blocs.dart';
import 'package:free_books/models/models.dart';
import 'package:free_books/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {

  static const routeName = 'profile';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksBloc, BooksState>(
      builder: (context, state) {

        return DefaultTabController(
          length: 1,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'My Profile',
              ),
              actions: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Icon(Icons.settings),)
              ],
              centerTitle: true,

              elevation: 0,
              // give the app bar rounded corners
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
            ),
            body: Column(
              children: <Widget>[
                // construct the profile details widget here
                SizedBox(
                  height: 180,
                  child: Center(
                    child: Text(
                      'You have posted ${BlocProvider.of<BooksBloc>(context).myBooks.length} Book(s)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),

                // the tab bar with two items
                SizedBox(
                  height: 50,
                  child: AppBar(
                    backgroundColor: Colors.black12.withAlpha(2),
                    bottom: TabBar(
                      indicatorColor: Colors.blueAccent,
                      tabs: [
                        Tab(
                          child: Text('Books'),
                        ),
                        // Tab(
                        //   icon: Icon(
                        //     Icons.directions_car,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),

                // create widgets for each tab bar here
                Expanded(
                  child: TabBarView(
                    children: [
                      // first tab bar view widget
                      Container(
                        child: (BlocProvider.of<BooksBloc>(context).myBooks.length == 0) ? _buildEmpty() : _buildList(context, BlocProvider.of<BooksBloc>(context).myBooks),
                      ),

                      // second tab bar viiew widget
                      // Container(
                      //   color: Colors.pink,
                      //   child: Center(
                      //     child: Text(
                      //       'Car',
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmpty() => Container();

  Widget _buildList(BuildContext context, List<Book> books) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, int i) {
        final book = books[i];
        return MyBookCard(book);
      },
    );
  }
}