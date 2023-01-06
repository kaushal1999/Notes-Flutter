import 'package:flutter/material.dart';
import 'package:utility_manager_flutter/utils/styles.dart';

import '../models/note.dart';

/// A single item (preview of a Note) in the Notes list.
class NoteItem extends StatelessWidget {
  const NoteItem({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) => Hero(
        tag: 'NoteItem${note.id}',
        child: DefaultTextStyle(
          style: kNoteTextLight,
          child: Container(
            decoration: BoxDecoration(
              color: Color(int.parse(note.color)),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: (note.color) == "0xFFFFFFFF" ? Border.all() : null,
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (note.title.isNotEmpty == true)
                  Text(
                    note.title,
                    style: kCardTitleLight,
                    maxLines: 1,
                  ),
                if (note.title.isNotEmpty == true) const SizedBox(height: 14),
                Flexible(
                  flex: 1,
                  child: Text(note
                      .content), // wrapping using a Flexible to avoid overflow
                ),
              ],
            ),
          ),
        ),
      );
}
