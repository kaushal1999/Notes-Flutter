import 'package:flutter/material.dart';
import 'package:utility_manager_flutter/screens/account_page.dart';
import 'package:utility_manager_flutter/screens/notes.dart';
// import 'package:utility_manager_flutter/screens/url_manager.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  // List<Widget> _screens = [
  //   TodoPage(),
  //   // UrlManager(),
  //   AccountPage(),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: index == 0 ? NotesPage() : AccountPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int val) {
          setState(() {
            index = val;
          });
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'Notes',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.link_rounded),
          //   label: 'URL Manager',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
