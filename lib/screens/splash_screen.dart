import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utility_manager_flutter/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final session = prefs.getString('user');

    if (session == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      final response = await supabase.auth.recoverSession(session);

      prefs.setString('user', response.session!.persistSessionString);

      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void initState() {
    super.initState();
    _restoreSession();
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
              "Notes",
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
