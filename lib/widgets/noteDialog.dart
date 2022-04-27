import 'package:flutter/material.dart';

import '../model/note.dart';

class NoteDialog extends StatefulWidget {
  final Note? note;
  final Function(String title, String description) onClickedDone;

  const NoteDialog({Key? key, this.note, required this.onClickedDone})
      : super(key: key);

  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final desController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      final note = widget.note;
      titleController.text = note!.title;
      desController.text = note.description;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    desController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;
    final title = isEditing ? 'Note' : 'Add Note';
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            title: Text(title, style: TextStyle(color: Colors.black),),
            actions: [
              buildAddButton(context, isEditing: isEditing)
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(

                children: [
                  SizedBox(
                    height: 5,
                  ),
                  buildTitle(),
                  buildDes(),
                ],
              ),
            ),
          )),
    );
  }

/*
  Widget action() => AlertDialog(
    title: Text(title),
    content: Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 8,
            ),
            buildTitle(),
            SizedBox(
              height: 8,
            ),
            buildDes(),
          ],
        ),
      ),
    ),
    actions: [
      buildCancelButton(context),
      buildAddButton(context, isEditing: isEditing),
    ],
  );
  */
  Widget buildTitle() => TextFormField(
        controller: titleController,

        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: 'Title',
        ),
        style: TextStyle(fontWeight: FontWeight.bold),
        validator: (title) =>
            title != null && title.isEmpty ? ' Enter a title' : null,
      );

  Widget buildDes() => TextFormField(
    textInputAction: TextInputAction.newline,
    keyboardType: TextInputType.multiline,
    maxLines: 50,
        controller: desController,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: 'Description',
        ),
        validator: (description) => description != null && description.isEmpty
            ? ' Enter a description'
            : null,
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text('Cancel'));

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';
    return TextButton(
        onPressed: () async {
          final isValid = formKey.currentState!.validate();
          if (isValid) {
            final title = titleController.text.trim();
            final description = desController.text.trim();

            widget.onClickedDone(title, description);
            FocusScope.of(context).unfocus();
            if(text == 'Add'){
              Navigator.of(context).pop();
            }

          }
        },
        child: Text(text));
  }
}
