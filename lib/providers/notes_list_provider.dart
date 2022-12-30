import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/constants.dart';

final todoListProvider = FutureProvider(
  (ref) async {
    // List<Map<String, dynamic>> notes = []

    final res = await supabase
        .from('notes')
        .select()
        .eq('email', supabase.auth.currentUser?.email);

    print("start");
    print(supabase.auth.currentUser?.email);
    return res;
    // return supabase.from('notes').select('*').eq('email', email).then((value) {
    //   print("start");
    //   // print(supabase.auth.refreshS);
    //   // print(user?.email);
    //   print(email);
    //   print(value);
    //   return value as List<dynamic>;
    // });
  },
);
