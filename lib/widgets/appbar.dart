import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final title;

  AppBarWidget({Key key, @required this.title}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: this.title,);
  }
}