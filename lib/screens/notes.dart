import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:utility_manager_flutter/screens/note_editor.dart';
import 'package:utility_manager_flutter/utils/constants.dart';
import 'package:utility_manager_flutter/widgets/rounded_button.dart';
import 'package:utility_manager_flutter/widgets/Notes_body.dart';

import '../models/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late final Stream<List<Note>> notesStream;
  TextEditingController titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String dateTime = DateTime.now().toLocal().toString();
  String selectColor = "0XFFe63946";
  late int year, month, date, hr, mins;

  // bool isLoading = false;

  // Future<List<Map<String,dynamic>>> fetchNotes() {
  //   final res = supabase
  //       .from('notes')
  //       .select()
  //       .eq('email', supabase.auth.currentUser?.email);
  //   return res;
  // }

  void initUser() {
    if (supabase.auth.currentUser != null) {
      supabase.auth.refreshSession();
      // print(supabase.auth.currentUser);
      // _user = supabase.auth.currentUser;
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  // il': supabase.auth.currentUser?.email);

  @override
  void initState() {
    // initUser();
    supabase.auth.refreshSession();
    final email = supabase.auth.currentUser?.email;
    print(email);
    notesStream = supabase
        .from('notes')
        .stream(primaryKey: ['id'])
        .eq('email', email)
        .map((maps) => maps.map((map) => Note.fromMap(map)).toList());
    // fetchNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // fetchNotes();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
            child: Text(
          "Notes",
          style: TextStyle(color: Colors.black),
        )),
      ),
      body: StreamBuilder(
          stream: notesStream,
          builder: (context, snap) {
            if (snap.hasData) {
              final notes = snap.data;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: SlidingUpPanel(
                  parallaxEnabled: true,
                  isDraggable: true,
                  borderRadius: BorderRadius.circular(15),
                  panel: GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Icon(
                            Icons.maximize_rounded,
                            size: 50,
                          ),
                        ),
                        Text(
                          "Swipe me up",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 25.0,
                            left: 10,
                          ),
                          child: TextFormField(
                            controller: titleController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              hintText: 'title',
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 25.0,
                            left: 10,
                          ),
                          child: TextFormField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              hintText: 'description',
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 25.0,
                            left: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    selectColor = "0XFFe63946";
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(0XFFe63946),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    selectColor = "0XFFfb8500";
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(0XFFfb8500),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    selectColor = "0XFFa8dadc";
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(0XFFa8dadc),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    selectColor = "0XFF457b9d";
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(0XFF457b9d),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    selectColor = "0XFF1d3557";
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(0XFF1d3557),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    selectColor = "0XFFbc6c25";
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(0XFFbc6c25),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          width: 50,
                          child: Divider(
                            thickness: 5,
                            color: Color(
                              int.parse(selectColor),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 25.0,
                            left: 10,
                          ),
                          child: RoundedButtonWidget(
                            buttonText: 'Add Note',
                            width: MediaQuery.of(context).size.width * 0.90,
                            onpressed: () async {
                              await supabase.from('notes').insert([
                                {
                                  'email': supabase.auth.currentUser?.email,
                                  'title': titleController.text,
                                  'content': _descriptionController.text,
                                  'date_time': dateTime,
                                  'color': selectColor,
                                  // 'year': year,
                                  // 'month': month,
                                  // 'date': date,
                                  // 'hr': hr,
                                  // 'mins': mins,
                                }
                              ]);

                              _descriptionController.text = "";
                              titleController.text = "";
                              context.showSnackBar(
                                  message: "Successfully inserted!");
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/home', (route) => false);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  body: todoBody(notes as List<Note>, _onNoteTap),
                ),
              );
            }
            if (snap.hasError) {
              return Center(
                child: Text("error"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  void _onNoteTap(Note note) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NoteEditor(note: note)));
    // processNoteCommand(_scaffoldKey.currentState, command);
  }
}
