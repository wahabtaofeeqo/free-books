import 'dart:collection';

class User {
  String name;
  String email;
  String password;
  String phone;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = HashMap();
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    return map;
  }
}