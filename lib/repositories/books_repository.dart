import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_books/models/models.dart';
import 'package:free_books/utils/constants.dart';

class BooksRepository {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> get users {
    return _firestore.collection("users").where('hasBook', isEqualTo: true).snapshots();
  }

  Future<QuerySnapshot> get books async {
     return await _firestore.collection("books").get();
  }
  
  Future sendChat(Chat chat, String node) async {
    await _firestore.collection(Constants.messages)
        .doc(node)
        .collection(Constants.chats)
        .doc(Timestamp.now().microsecondsSinceEpoch.toString()).set(chat.toMap());

    return Future.value(true);
  }

  Future<QuerySnapshot> loadChats(String node) async {
    return await _firestore.collection(Constants.messages).doc(node).collection(Constants.chats).get();
  }
}