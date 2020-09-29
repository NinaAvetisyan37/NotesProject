import 'package:flutter/material.dart';
import 'package:my_first_project/add_note.dart';
import 'package:my_first_project/note.dart';

class SingleNote extends StatefulWidget {
  final Note note;
  final Function onDelete;
  final OnSelect onSelect;
  final OnEdit onEdit;
  final bool selected;

  const SingleNote(
      {Key key,
      this.note,
      this.onDelete,
      this.onSelect,
      this.onEdit,
      this.selected})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SingleNoteState();
  }
}

class _SingleNoteState extends State<SingleNote> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        widget.onSelect(widget.selected);
      },
      onTap: () {
        widget.onEdit();
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                widget.selected
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: Colors.blue,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.note.title,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.note.subtitle,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      widget.note.date.toIso8601String(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
              if (!widget.selected)
                GestureDetector(
                  child: Column(children: [
                    Icon(Icons.delete),
                    Text('Delete'),
                  ]),
                  onTap: () {
                    widget.onDelete();
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}

typedef OnSelect = void Function(bool isSelected);
typedef OnEdit = void Function();
