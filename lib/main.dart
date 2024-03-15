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

class HomeListViewScreen extends StatelessWidget {
  HomeListViewScreen({super.key});

  final people = PeopleService().getPeople().toList();

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
      body: ListView(
        children: people.map(_buildListTile).toList(),
      ),
    );
  }

  // ListTile newMethod(e) => _buildListTile(p: e);
}
