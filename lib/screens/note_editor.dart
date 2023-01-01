import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:utility_manager_flutter/models/note.dart';
import 'package:utility_manager_flutter/utils/constants.dart';
import 'package:utility_manager_flutter/widgets/styles.dart';

import '../widgets/color_picker.dart';
import '../widgets/note_actions.dart';

/// The editor of a [Note], also shows every detail about a single note.
class NoteEditor extends StatefulWidget {
  /// Create a [NoteEditor],
  /// provides an existed [note] in edit mode, or `null` to create a new one.
  const NoteEditor({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  State<StatefulWidget> createState() => _NoteEditorState(note);
}

/// [State] of [NoteEditor].
class _NoteEditorState extends State<NoteEditor> {
  /// Create a state for [NoteEditor], with an optional [note] being edited,
  /// otherwise a new one will be created.
  _NoteEditorState(Note note)
      : this._note = note,
        _originNote = note,
        this._titleTextController = TextEditingController(text: note.title),
        this._contentTextController = TextEditingController(text: note.content);

  /// The note in editing
  final Note _note;

  /// The origin copy before editing
  final Note _originNote;
  String get _noteColor => _note.color;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // StreamSubscription<Note> _noteSubscription;
  final TextEditingController _titleTextController;
  final TextEditingController _contentTextController;

  /// If the note is modified.
  bool get _isDirty => _note != _originNote;

  @override
  void initState() {
    super.initState();

    // _contentTextController
    // .addListener(() => _note.content = _contentTextController.text);
  }

  @override
  void dispose() {
    // _noteSubscription?.cancel();
    _titleTextController.dispose();
    _contentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = supabase.auth.currentUser!.id;
    // _watchNoteDocument(uid);
    return ChangeNotifierProvider.value(
      value: _note,
      child: Consumer<Note>(
        builder: (_, __, ___) => Hero(
          tag: 'NoteItem${_note.id}',
          child: Theme(
            data: Theme.of(context).copyWith(
              primaryColor: Color(int.parse(_noteColor)),
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                    elevation: 0,
                  ),
              scaffoldBackgroundColor: Color(int.parse(_noteColor)),
              bottomAppBarColor: Color(int.parse(_noteColor)),
            ),
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Color(int.parse(_noteColor)),
                systemNavigationBarColor: Color(int.parse(_noteColor)),
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
              child: Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  actions: [
                    IconButton(onPressed: _save, icon: Icon(Icons.save))
                  ],
                  bottom: const PreferredSize(
                    preferredSize: Size(0, 24),
                    child: SizedBox(),
                  ),
                ),
                body: _buildBody(context, uid),
                bottomNavigationBar: _buildBottomAppBar(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, String uid) => DefaultTextStyle(
        style: kNoteTextLargeLight,
        child: WillPopScope(
          onWillPop: () => _onPop(uid),
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: _buildNoteDetail(),
            ),
          ),
        ),
      );

  Widget _buildNoteDetail() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: _titleTextController,
            style: kNoteTitleLight,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: InputBorder.none,
              counter: const SizedBox(),
            ),
            maxLines: null,
            maxLength: 1024,
            textCapitalization: TextCapitalization.sentences,
            readOnly: false,
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _contentTextController,
            style: kNoteTextLargeLight,
            decoration: const InputDecoration.collapsed(hintText: 'Note'),
            maxLines: null,
            textCapitalization: TextCapitalization.sentences,
            readOnly: false,
          ),
        ],
      );

  // List<Widget> _buildTopActions(BuildContext context, String uid) => [
  // if (_note.state != NoteState.deleted)
  //   IconButton(
  //     icon: Icon(
  //         _note.pinned == true ? AppIcons.pin : AppIcons.pin_outlined),
  //     tooltip: _note.pinned == true ? 'Unpin' : 'Pin',
  //     onPressed: () => _updateNoteState(
  //         uid, _note.pinned ? NoteState.unspecified : NoteState.pinned),
  //   ),
  // if (_note.id != null && _note.state < NoteState.archived)
  //   IconButton(
  //     icon: const Icon(AppIcons.archive_outlined),
  //     tooltip: 'Archive',
  //     onPressed: () => Navigator.pop(
  //         context,
  //         NoteStateUpdateCommand(
  //           id: _note.id,
  //           uid: uid,
  //           from: _note.state,
  //           to: NoteState.archived,
  //         )),
  //   ),
  //   if (_note.state == NoteState.archived)
  //     IconButton(
  //       icon: const Icon(AppIcons.unarchive_outlined),
  //       tooltip: 'Unarchive',
  //       onPressed: () => _updateNoteState(uid, NoteState.unspecified),
  //     ),
  // ];

  Widget _buildBottomAppBar(BuildContext context) => BottomAppBar(
        child: Container(
          height: kBottomBarSize,
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // IconButton(
              //   icon: const Icon(AppIcons.add_box),
              //   color: kIconTintLight,
              //   onPressed: _note.state.canEdit ? () {} : null,
              // ),
              // Text('Edited ${_note.da}'),
              IconButton(
                icon: const Icon(Icons.more_vert),
                color: kIconTintLight,
                onPressed: () => _showNoteBottomSheet(context),
              ),
            ],
          ),
        ),
      );

  void _showNoteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(int.parse(_noteColor)),
      builder: (context) => ChangeNotifierProvider.value(
        value: _note,
        child: Consumer<Note>(
          builder: (_, note, __) => Container(
            color: Color(int.parse(note.color)),
            padding: const EdgeInsets.symmetric(vertical: 19),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                NoteActions(
                  contxt: context,
                ),
                const SizedBox(height: 16),
                LinearColorPicker(),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _save() async {
    // print(_note.id);
    _note.title = _titleTextController.text;
    print(_note.title);
    _note.content = _contentTextController.text;
    print(_contentTextController.text);
    try {
      await supabase
          .from('notes')
          .update({'title': _note.title, 'content': _note.content}).match(
              {'id': _note.id});

      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Successful'),
              actions: [
                TextButton(
                    onPressed: (() => Navigator.pop(context)),
                    child: Text("OK"))
              ],
            );
          });
    } catch (e) {
      context.showSnackBar(message: e.toString());
    }
  }

  /// Callback before the user leave the editor.
  Future<bool> _onPop(String uid) async {
    return Future.value(true);
  }

  // void _watchNoteDocument(String uid) {
  //   if (_noteSubscription == null && uid != null && _note.id != null) {
  //     _noteSubscription = noteDocument(_note.id, uid)
  //         .snapshots()
  //         .map((snapshot) => snapshot.exists ? snapshot.toNote() : null)
  //         .listen(_onCloudNoteUpdated);
  //   }
  // }

  /// Callback when the FireStore copy of this note updated.
  // void _onCloudNoteUpdated(Note note) {
  //   if (!mounted || note?.isNotEmpty != true || _note == note) {
  //     return;
  //   }

  //   final refresh = () {
  //     _titleTextController.text = _note.title ?? '';
  //     _contentTextController.text = _note.content ?? '';
  //     _originNote.update(note, updateTimestamp: false);
  //     _note.update(note, updateTimestamp: false);
  //   };

  //   if (_isDirty) {
  //     _scaffoldKey.currentState?.showSnackBar(SnackBar(
  //       content: const Text('The note is updated on cloud.'),
  //       action: SnackBarAction(
  //         label: 'Refresh',
  //         onPressed: refresh,
  //       ),
  //       duration: const Duration(days: 1),
  //     ));
  //   } else {
  //     refresh();
  //   }
  // }

  /// Update this note to the given [state]
  // void _updateNoteState(uid, NoteState state) {
  //   // new note, update locally
  //   if (_note.id == null) {
  //     _note.updateWith(state: state);
  //     return;
  //   }

  //   // otherwise, handles it in a undoable manner
  //   processNoteCommand(
  //       _scaffoldKey.currentState,
  //       NoteStateUpdateCommand(
  //         id: _note.id,
  //         uid: uid,
  //         from: _note.state,
  //         to: state,
  //       ));
  // }
}
