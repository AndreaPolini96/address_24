import 'package:address_24/services/people_service.dart';
import 'package:address_24/widgets/contact_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  final people = PeopleService().getPeople(results: 15).toList();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: SingleChildScrollView(
          child: Column(
            children: people.map((e) => ContactItem(p: e)).toList(),
          ),
        ));
  }
}
