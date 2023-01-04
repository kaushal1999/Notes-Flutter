import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:utility_manager_flutter/screens/note_editor.dart';
import 'package:utility_manager_flutter/utils/constants.dart';
import 'package:utility_manager_flutter/widgets/notes_grid.dart';
import 'package:utility_manager_flutter/widgets/rounded_button.dart';

import '../models/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<Note> fNotes = [];

  // bool isLoading = false;

  // Future<List<Map<String,dynamic>>> fetchNotes() {
  //   final res = supabase
  //       .from('notes')
  //       .select()
  //       .eq('email', supabase.auth.currentUser?.email);
  //   return res;
  // }

  @override
  void initState() {
    // initUser();
    // supabase.auth.refreshSession();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final email = supabase.auth.currentUser!.email;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // backgroundColor: Color(0XFFAD6C98),
          title: Center(
              child: Text(
            "Your Notes",
          )),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addNote');
            },
            icon: Icon(
              Icons.add_circle,
              size: 35,
            ),
          ),
        ),
        body: StreamBuilder(
            stream: supabase
                .from('notes')
                .stream(primaryKey: ['id']).eq('email', email),
            builder: (_, AsyncSnapshot<List<Map<String, dynamic>>> snap) {
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
              } else if (snap.hasData) {
                // if(snap.hasData){
                final notes = snap.data!.map((e) => Note.fromMap(e)).toList();
                // fNotes.addAll(notes);
                return NotesGrid(notes: notes, onTap: _onNoteTap);
              } else {
                return Center(
                  child: Lottie.asset('/assets/empty.json'),
                );
              }
            })

        //
        );
  }

  void _onNoteTap(Note note) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NoteEditor(note: note)));
    // processNoteCommand(_scaffoldKey.currentState, command);
  }
}
