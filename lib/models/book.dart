import 'package:cloud_firestore/cloud_firestore.dart';

class Book {

  final String name;
  final String department;

  Book.fromMap(Map<String, dynamic> map):
      this.name = map['name'],
      this.department = map['department'];

  Book.fromSnapshot(DocumentSnapshot snapshot): this.fromMap(snapshot.data());
}