import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_it/model/note.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_it/pages/viewPage.dart';
import 'package:note_it/widgets/drawer.dart';

import '../boxes.dart';
import '../widgets/noteDialog.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.92),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0.92),
          iconTheme: IconThemeData(color: Colors.grey),
          title: Text(
            'Note',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        drawer: DrawerWidget(),
        body: ValueListenableBuilder<Box<Note>>(
          valueListenable: Boxes.getNotes().listenable(),
          builder: (context, box, _) {
            final notes = box.values.toList().cast<Note>();
            return buildContent(notes);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
              context: context,
              builder: (context) => NoteDialog(
                    onClickedDone: addNote,
                  )),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildContent(List<Note> notes) {
    if (notes.isEmpty) {
      return Center(
        child: Text(
          'No Notes yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return ListView(children: [
        SizedBox(
          height: 5,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: notes.length,
            itemBuilder: (context, int index) {
              final note = notes[index];
              return buildNote(context, note);
            })
      ]);
    }
  }

  Widget buildNote(BuildContext context, Note note) {
    return Card(
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          note.title,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          note.description,
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16),
        ),
        children: [buildButtons(context, note)],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Note note) {
    return Row(
      children: [

        Expanded(
            child: TextButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return NoteDialog(
                      note: note,
                      onClickedDone: (title, description) {
                        return editNote(note, title, description);
                      },
                    );
                  }));
                },
                icon: Icon(Icons.edit),
                label: Text('View'))),
        Expanded(
            child: TextButton.icon(
                onPressed: () {
                  deleteNote(note);
                },
                icon: Icon(Icons.delete),
                label: Text('Delete')))
      ],
    );
  }

  Future addNote(String title, String description) async {
    final note = Note(title: title, description: description);

    final box = Boxes.getNotes();
    box.add(note);
  }

  void editNote(Note note, String title, String description) {
    note.title = title;
    note.description = description;
    note.save();
  }

  void deleteNote(Note note) {
    note.delete();
  }
}
