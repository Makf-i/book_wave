import 'package:book_wave/screens/tabs_screens/home.dart';
import 'package:book_wave/screens/tabs_screens/my_account.dart';
import 'package:book_wave/screens/tabs_screens/my_bookings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Wave'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.blue,
        selectedIndex: _selectedPage,
        backgroundColor: Colors.white,
        onDestinationSelected: (index) {
          setState(() {
            _selectedPage = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: "Home"),
          NavigationDestination(
              selectedIcon: Icon(Icons.format_list_numbered_sharp),
              icon: Icon(Icons.format_list_bulleted_sharp),
              label: "Bookings"),
          NavigationDestination(
              selectedIcon: Icon(Icons.account_circle_rounded),
              icon: Icon(Icons.account_circle_outlined),
              label: "My Account")
        ],
      ),
      body: const [
        HomeScreen(),
        MyBookings(),
        MyAccount(),
      ][_selectedPage],
    );
  }
}
