import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:utility_manager_flutter/utils/styles.dart';

import '../models/note.dart';

/// Note color picker in a horizontal list style.
class LinearColorPicker extends StatelessWidget {
  /// Returns color of the note, fallbacks to the default color.
  String _currColor(Note note) => note.color;

  @override
  Widget build(BuildContext context) {
    Note note = Provider.of<Note>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: kNoteColors.map(
        (color) {
          // if (i == 0) const SizedBox(width: 17),
          return InkWell(
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Color(int.parse(color)),
                shape: BoxShape.circle,
                border: Border.all(),
              ),
              child: color == _currColor(note)
                  ? const Icon(Icons.check, color: kColorPickerBorderColor)
                  : null,
            ),
            onTap: () {
              if (color != _currColor(note)) {
                note.updateWith(color: color);
              }
            },
          );
        },
        // SizedBox(width: i == kNoteColors.length - 1 ? 17 : 20);},
      ).toList()),
    );
  }
}
