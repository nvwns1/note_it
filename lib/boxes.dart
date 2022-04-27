import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_it/model/note.dart';


class Boxes{
  static Box<Note> getNotes() =>
      Hive.box<Note>('notes');
}

