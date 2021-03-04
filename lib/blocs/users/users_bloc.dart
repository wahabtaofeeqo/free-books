import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_books/blocs/users/users.dart';
import 'package:free_books/models/models.dart';

class UsersBloc extends Bloc<UserEvent, UsersState> {

  UsersBloc(): super(AddUserState());

  @override
  Stream<UsersState> mapEventToState(UserEvent event) async* {
    if(event is AddUserEvent)
      yield* _addUser(event);
  }

  Stream<UsersState> _addUser(AddUserEvent event) async* {
    try {

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: event.user.email, password: event.user.password);
      if(userCredential != null) {
        FirebaseFirestore.instance.collection("users").doc(userCredential.user.uid).set(event.user.toMap())
            .then((value) {
              print('Done');
        });
      }
      else {
        print('Unable to');
      }
    }
    catch(err) {
      print(err);
    }
  }
}