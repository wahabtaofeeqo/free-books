import 'package:cloud_firestore/cloud_firestore.dart';

class Book {

  final String name;
  final String department;
  String logo;

  Book(this.name, this.department, [this.logo]);

  Book.fromMap(Map<String, dynamic> map):
      this.name = map['name'],
      this.department = map['department'],
      this.logo = map['logo'];

  Book.fromSnapshot(DocumentSnapshot snapshot): this.fromMap(snapshot.data());
}