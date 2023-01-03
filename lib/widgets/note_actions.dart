// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:utility_manager_flutter/utils/constants.dart';
import 'package:utility_manager_flutter/utils/styles.dart';

import '../models/note.dart';

/// Provide actions for a single [Note], used in a [BottomSheet].
class NoteActions extends StatelessWidget {
  final BuildContext contxt;
  const NoteActions({
    Key? key,
    required this.contxt,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final note = Provider.of<Note>(context);
    // final state = note?.state;
    final id = note.id;
    // final uid = supabase.auth.currentUser!.id;

    final textStyle = TextStyle(
      color: kHintTextColorLight,
      fontSize: 16,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // if (id != null )
        //   ListTile(
        //     leading: const Icon(AppIcons.archive_outlined),
        //     title: Text('Archive', style: textStyle),
        //     onTap: () => Navigator.pop(
        //         context,
        //         NoteStateUpdateCommand(
        //           id: id,
        //           uid: uid,
        //           from: state,
        //           to: NoteState.archived,
        //           dismiss: true,
        //         )),
        //   ),
        // if (state == NoteState.archived)
        //   ListTile(
        //     leading: const Icon(AppIcons.unarchive_outlined),
        //     title: Text('Unarchive', style: textStyle),
        //     onTap: () => Navigator.pop(
        //         context,
        //         NoteStateUpdateCommand(
        //           id: id,
        //           uid: uid,
        //           from: state,
        //           to: NoteState.unspecified,
        //         )),
        //   ),

        ListTile(
          leading: const Icon(Icons.delete_outline),
          title: Text('Delete', style: textStyle),
          onTap: () async {
            Navigator.pop(context);
            await supabase.from('notes').delete().match({'id': id});
            Navigator.pushNamedAndRemoveUntil(
                contxt, '/home', (route) => false);
          },
        ),
//        if (id != null) ListTile(
//          leading: const Icon(AppIcons.copy),
//          title: Text('Make a copy', style: textStyle),
//        ),
        // if (state == NoteState.deleted)
        //   ListTile(
        //     leading: const Icon(Icons.restore),
        //     title: Text('Restore', style: textStyle),
        //     onTap: () => Navigator.pop(
        //         context,
        //         NoteStateUpdateCommand(
        //           id: id,
        //           uid: uid,
        //           from: state,
        //           to: NoteState.unspecified,
        //         )),
        //   ),
        ListTile(
          leading: const Icon(Icons.share),
          title: Text('Send', style: textStyle),
        ),
      ],
    );
  }
}
