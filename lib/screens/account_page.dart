import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utility_manager_flutter/utils/constants.dart';
import 'package:utility_manager_flutter/widgets/rounded_button.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Future<void> _signOut() async {
    final response = await supabase.auth.signOut();
    // final error = response
    // if (error != null) {
    //   context.showErrorSnackBar(message: error.message);
    //   return;
    // }
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Center(
            child: Container(
                child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://robohash.org/${supabase.auth.currentUser?.email}"),
                backgroundColor: Theme.of(context).accentColor,
                minRadius: 50,
                maxRadius: 75,
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                (supabase.auth.currentUser?.email)!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RoundedButtonWidget(
                buttonText: "Logout",
                width: MediaQuery.of(context).size.width * 0.80,
                onpressed: _signOut,
              ),
            ],
          ),
        ))));
    // loading: (_) => SizedBox(
    // width: 300.0,
  }
}
