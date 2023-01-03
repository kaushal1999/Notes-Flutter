// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:utility_manager_flutter/utils/constants.dart';
import 'package:utility_manager_flutter/widgets/notes_grid.dart';

import '../models/note.dart';

class NotesPageBody extends StatefulWidget {
  const NotesPageBody({
    Key? key,
    required this.onNoteTap,
  }) : super(key: key);

  final void Function(Note) onNoteTap;
  @override
  State<NotesPageBody> createState() => _NotesPageBodyState();
}

class _NotesPageBodyState extends State<NotesPageBody> {
  late Stream<List<Note>> stream;

  @override
  void initState() {
    final email = supabase.auth.currentUser?.email;
    // print(email);
    stream = supabase
        .from('notes')
        .stream(primaryKey: ['id'])
        .eq('email', email)
        .asyncMap((maps) => maps.map((map) => Note.fromMap(map)).toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (_, snap) {
          if (snap.hasError) {
            return Center(
              child: Text(
                snap.error.toString(),
              ),
            );
          } else if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snap.connectionState == ConnectionState.done) {
            final notes = snap.data as List<Note>;
            if (notes.length == 0) {
              return Center(
                child: Lottie.asset('assets/empty.json'),
              );
            } else {
              return NotesGrid(notes: notes, onTap: widget.onNoteTap);
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
