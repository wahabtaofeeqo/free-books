import 'dart:collection';

class Chat {
  String from;
  String to;
  String message;
  int type;
  String media;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = HashMap();
    map['from'] = from;
    map['to'] = to;
    map['message'] = message;
    map['type'] = type;
    map['media'] = media;

    return map;
  }
}