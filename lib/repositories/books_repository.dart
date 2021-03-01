import 'package:cloud_firestore/cloud_firestore.dart';

class BooksRepository {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> get users {
    return _firestore.collection("users").where('hasBook', isEqualTo: true).snapshots();
  }

  Stream<QuerySnapshot> get books {
    return _firestore.collection("books").snapshots();
  }
}