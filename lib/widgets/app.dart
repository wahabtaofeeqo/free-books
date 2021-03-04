import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:free_books/blocs/blocs.dart';
import 'package:free_books/blocs/filtered_books/filtered_books.dart';
import 'package:free_books/blocs/users/users.dart';
import 'package:free_books/models/models.dart';
import 'package:free_books/screens/home.dart';
import 'package:free_books/screens/screens.dart';

class FreeBooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Free Books',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      builder: EasyLoading.init(),

      routes: {
        '/': (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<FilteredBooksBloc>(
                create: (context) => FilteredBooksBloc(booksBloc: BlocProvider.of<BooksBloc>(context)),
              )
            ],

            child: HomeScreen(),
          );
        },

        'addBook': (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<BooksBloc>(
                create: (context) => BlocProvider.of<BooksBloc>(context),
              )
            ],

            child: AddEditScreen(isEditing: false, onSave: (Book book) {},),
          );
        },

        'login': (context) {
              return MultiBlocProvider(
                  providers: [
                    BlocProvider<UsersBloc>(
                      create: (context) => UsersBloc(),
                    )
                  ],

                  child: LoginScreen(),
              );
        },

        'register': (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<UsersBloc>(
                create: (context) => UsersBloc(),
              )
            ],

            child: RegisterScreen(),
          );
        },
      },
    );
  }
}