import 'package:flutter/material.dart';

import '../model/note.dart';

class ViewPage extends StatelessWidget {
  final Note note;

  const ViewPage({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      title: Text(note.title,

      style: TextStyle(color: Colors.black),

      ),
      ),
      ),
    );

  }
}
