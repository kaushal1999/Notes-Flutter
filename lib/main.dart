import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utility_manager_flutter/screens/account_page.dart';
import 'package:utility_manager_flutter/screens/home.dart';
import 'package:utility_manager_flutter/screens/login.dart';
import 'package:utility_manager_flutter/screens/signUp.dart';
import 'package:utility_manager_flutter/screens/splash_screen.dart';
import 'package:utility_manager_flutter/utils/constants.dart';
import 'package:utility_manager_flutter/utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  Supabase.initialize(
    url: "https://bkfabkumvffuytgitkim.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJrZmFia3VtdmZmdXl0Z2l0a2ltIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzE2MTg1MTYsImV4cCI6MTk4NzE5NDUxNn0.cApDro0p40ERHf_qHcqlO_e53LtuIYCWueETyjS0ckQ",
    // authCallbackUrlHostname: dote"SUPABASE_CALLBACK_URL"],
  );

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  User? user;

  initUser() async {
    final session = supabase.auth.currentSession;
    if (session != null) {
      await supabase.auth.refreshSession();
      user = supabase.auth.currentSession!.user;
    }
  }

  @override
  void initState() {
    // initUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Color(0XFFAD6C98),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (_) => SplashScreen(),
        '/account': (_) => AccountPage(),
        '/home': (_) => Home(),
        '/signup': (_) => Signup(),
        '/login': (_) => Login(),
      },
    );
  }
}
