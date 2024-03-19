import 'dart:math';

import 'package:address_24/models/person.dart';
import 'package:address_24/services/people_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(MaterialApp(
    home: SafeArea(child: HomeListViewScreen()),
  ));
}

class HomeListViewScreen extends StatefulWidget {
  HomeListViewScreen({super.key});

  @override
  State<HomeListViewScreen> createState() => _HomeListViewScreenState();
}

class _HomeListViewScreenState extends State<HomeListViewScreen> {
  final people = PeopleService().getPeople().toList();

  int _currentIndex = 0;

  ListTile _buildListTile(Person p) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(p.picture!.thumbnail!),
      ),
      title: Text(p.firstName!),
      subtitle: Text(p.cell!),
      trailing: Icon(Icons.favorite_border),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          selectedItemColor: Colors.green,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.list_rounded), label: "List"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded), label: "Favorite")
          ]),
      body: _currentIndex == 0
          ? ListView(
              children: people.map(_buildListTile).toList(),
            )
          : Center(
              child: Text("Hello"),
            ),
    );
  }
}
