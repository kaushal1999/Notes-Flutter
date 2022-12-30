import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:utility_manager_flutter/widgets/notes_grid.dart';

import '../models/note.dart';

Widget todoBody(List<Note> notes, void Function(Note) onTap) {
  if (notes.isEmpty) {
    return Lottie.asset("assets/empty.json");
  } else {
    return NotesGrid(
      notes: notes,
      onTap: onTap,
    );
  }
}
