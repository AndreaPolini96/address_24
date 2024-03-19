import 'dart:math';

import 'package:address_24/models/person.dart';
import 'package:address_24/services/people_service.dart';
import 'package:address_24/widgets/like_button.dart';
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
  final people = PeopleService()
      .getPeople(results: 100)
      .where((e) => e.id != null)
      .toList();

  List<Person> _favoritePeople = [];
  final _favorite = [];

  int _currentIndex = 0;

  ListTile _buildListTile(Person p) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(p.picture!.thumbnail!),
      ),
      title: Text(p.firstName!),
      subtitle: Text(p.cell!),
      trailing: LikeButton(
          favorite: _favorite.contains(p.id),
          onPressed: () {
            setState(() {
              if (_favorite.contains(p.id)) {
                _favorite.remove(p.id);
              } else {
                _favorite.add(p.id);
              }

              _favoritePeople =
                  people.where((e) => _favorite.contains(e.id)).toList();
            });
          }),
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
          ? ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                return _buildListTile(people[index]);
              })
          : ListView.builder(
              itemCount: _favoritePeople.length,
              itemBuilder: (context, index) {
                return _buildListTile(_favoritePeople[index]);
              },
            ),
    );
  }
}
