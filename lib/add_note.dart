import 'package:flutter/material.dart';
import 'package:my_first_project/note.dart';

class AddNote extends StatefulWidget {
  final Note note;

  const AddNote({Key key, this.note}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AddNoteState();
  }
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController;
  TextEditingController descController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.note?.title);
    descController = TextEditingController(text: widget.note?.subtitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.toc),
              onPressed: () {
                setState(() {});
              })
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title'),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: 'Title', labelStyle: TextStyle(fontSize: 22)),
                autocorrect: false,
                style: TextStyle(fontSize: 22),
              ),
              Text('Description'),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(fontSize: 22)),
                maxLines: 5,
                autocorrect: false,
                style: TextStyle(fontSize: 22),
              ),
              Center(
                child: MaterialButton(
                  onPressed: () {
                    String title = titleController.text;
                    String desc = descController.text;
                    DateTime date = DateTime.now();

                    Note note = Note(
                      title: title,
                      subtitle: desc,
                      date: date,
                    );

                    Navigator.of(context).pop<Note>(note);
                  },
                  child: Text('SAVE'),
                  color: Colors.redAccent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
