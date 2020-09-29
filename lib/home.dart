import 'package:flutter/material.dart';
import 'package:my_first_project/add_note.dart';
import 'package:my_first_project/note.dart';
import 'package:my_first_project/widgets/single_note.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool selectedAll = false;

  static DateTime now = DateTime.now();

  List<Note> notes = [
    Note(
      title: '1 Some Title',
      subtitle: 'Looong subtitle subtitle subtitle subtitle subtitle',
      date: now,
    ),
    Note(
      title: '2 Some Title',
      subtitle: 'Looong subtitle',
      date: now,
    ),
    Note(
      title: '3 Some Title',
      subtitle: 'Looong subtitle',
      date: now,
    ),
    Note(
      title: '4 Some Title',
      subtitle: 'Looong subtitle',
      date: now,
    ),
    Note(
      title: '5 Some Title',
      subtitle: 'Looong subtitle',
      date: now,
    ),
    Note(
      title: '6 Some Title',
      subtitle: 'Looong subtitle',
      date: now,
    ),
    Note(
      title: '7 Some Title',
      subtitle: 'Looong subtitle',
      date: now,
    ),
    Note(
      title: '8 Some Title',
      subtitle: 'Looong subtitle',
      date: now,
    ),
  ];

  Map<int, bool> selectedNotes = {};

  @override
  void initState() {
    super.initState();

    sortData();
  }

  void sortData() {
    notes.sort((one, other) {
      return -1 * (one.date.compareTo(other.date));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasSelectedNotes = selectedNotes.values.any((element) => element);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Notes'),
        centerTitle: true,
        leading: selectedAll || hasSelectedNotes
            ? IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  if (selectedAll) {
                    setState(() {
                      notes = [];
                    });
                  } else {
                    List<int> selectedIndexes = selectedNotes.keys
                        .where((element) => selectedNotes[element])
                        .toList()
                        .reversed
                        .toList();

                    for (int i = 0; i < selectedIndexes.length; i++) {
                      notes.removeAt(selectedIndexes[i]);
                    }

                    selectedNotes = {};

                    setState(() {});
                  }
                })
            : null,
        actions: [
          IconButton(
              icon: Icon(Icons.select_all),
              onPressed: () {
                setState(() {
                  this.selectedAll = !selectedAll;
                });
              }),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push<Note>(
                  MaterialPageRoute(
                    builder: (context) {
                      return AddNote();
                    },
                  ),
                ).then((value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    notes.add(value);
                    sortData();
                  });
                });
              }),
        ],
      ),
      backgroundColor: Colors.indigo.shade200,
      body: body(),
    );
  }

  Widget body() {
      return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return SingleNote(
          note: notes[index],
          selected: selectedAll || (selectedNotes[index] ?? false),
          onDelete: () {
            setState(() {
              notes.removeAt(index);
            });
          },
          onSelect: (selected) {
            setState(() {
              selectedNotes[index] = !selected;
            });
          },
          onEdit: () {
            Navigator.of(context)
                .push<Note>(MaterialPageRoute(builder: (context) {
              return AddNote(
                note: notes[index],
              );
            })).then((value) {
              if (value == null) {
                return null;
              }
              setState(() {
                notes[index] = value;
                sortData();
              });
            });
          },
        );
      },
    );
  }
}
