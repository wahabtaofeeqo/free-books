import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String from;
  String to;
  String message;
  int type;
  String media;

  Chat();
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = HashMap();
    map['from'] = from;
    map['to'] = to;
    map['message'] = message;
    map['type'] = type;
    map['media'] = media;

    return map;
  }

  Chat.fromMap(Map<String, dynamic> map):
        this.from = map['from'],
        this.to = map['to'],
        this.message = map['message'],
        this.type = map['type'],
        this.media = map['media'];

  Chat.fromSnapshot(DocumentSnapshot snapshot): this.fromMap(snapshot.data());
}