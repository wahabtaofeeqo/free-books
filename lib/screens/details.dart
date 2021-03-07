import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_books/models/models.dart';
import 'package:free_books/screens/screens.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Book book = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('${book.name} Details'),
      ),
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
              ),

              ListTile(
                title: Text('Book Name'),
                subtitle: Text(book.name),
              ),

              ListTile(
                title: Text('Department'),
                subtitle: Text(book.department),
              ),

              ListTile(
                title: Text('Views'),
                subtitle: Text(book.views.toString()),
              ),

              ListTile(
                title: Text('Owner'),
                subtitle: Text('Taofeek'),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: RaisedButton(
                        child: Text('Chat Owner',),
                        onPressed: () {
                          Navigator.of(context).pushNamed(ChatScreen.routeName, arguments: book);
                        },
                      ),
                    )
                  ),

                  SizedBox(
                    width: 10,
                  ),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: RaisedButton(
                          child: Text('Call Owner',),
                          onPressed: () {
                            print('Chatting');
                            print(FirebaseAuth.instance.currentUser.uid.hashCode);
                          },
                      )
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}