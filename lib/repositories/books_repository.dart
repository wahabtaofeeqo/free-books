import 'package:cloud_firestore/cloud_firestore.dart';

class BooksRepository {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> get users {
    return _firestore.collection("users").where('hasBook', isEqualTo: true).snapshots();
  }

   Future<QuerySnapshot> get books async {
     return await _firestore.collection("books").get();
  }
}