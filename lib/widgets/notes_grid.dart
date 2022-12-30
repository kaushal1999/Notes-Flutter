import 'package:flutter/material.dart';

import '../models/note.dart';
import 'note_item.dart';

/// Grid view of [Note]s.
class NotesGrid extends StatelessWidget {
  final List<Note> notes;
  final void Function(Note) onTap;

  NotesGrid({
    Key? key,
    required this.notes,
    required this.onTap,
  }) : super(key: key);

  // static NotesGrid create({
  //   Key? key,
  //   required List<Note> notes,
  //   required void Function(Note) onTap,
  // }) =>
  //     NotesGrid(
  //       key: key,
  //       notes: notes,
  //       // onTap: onTap,
  //     );

  @override
  Widget build(BuildContext context) => CustomScrollView(slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1 / 1.2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                  _noteItem(context, notes[index]),
              childCount: notes.length,
            ),
          ),
        ),
      ]);

  Widget _noteItem(BuildContext context, Note note) => InkWell(
        onTap: () {
          // Navigator.pushNamed(context, '/edit');
          onTap.call(note);
        },
        child: NoteItem(note: note),
      );
}
