import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:utility_manager_flutter/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initUser() {
    if (supabase.auth.currentSession != null) {
      // supabase.auth.refreshSession();
      // print(supabase.auth.currentUser);
      // _user = supabase.auth.currentUser;
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  _redirect() {
    // await for for the widget to mount

    // await Future.delayed(Duration.zero);
    print('fun');

    final session = supabase.auth.currentSession;
    if (session == null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    }
  }

  @override
  void initState() {
    // Timer(Duration(seconds: 3), () {
    //   // dart
    //   final Session? session = supabase.auth.currentSession;
    //   if (session == null) {
    //   } else {
    //   }
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      _redirect();
    });
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // });
    // Timer(Duration(seconds: 6), (() => initUser()));
// ;
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: ListView(
        children: [
          Lottie.asset('assets/splash.json'),
          Center(
            child: Text(
              "Utility Manager",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Center(
            child: SizedBox(
              width: 300.0,
              child: LinearProgressIndicator(
                backgroundColor: Color(0XFFBAAAB9),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0XFFAD6C98),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
