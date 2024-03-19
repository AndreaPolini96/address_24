import 'package:address_24/models/person.dart';
import 'package:address_24/services/people_service.dart';
import 'package:address_24/services/services.dart';
import 'package:address_24/widgets/like_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'screens/home_screen.dart';
import 'widgets/contact_list_item.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
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
          ? ContactListView(
              people: people,
              onTileTapped: (p) {},
              onPressed: (p) {
                setState(() {
                  if (_favorite.contains(p.id)) {
                    _favorite.remove(p.id);
                    return;
                  }

                  _favorite.add(p.id);
                  _favoritePeople =
                      people.where((e) => _favorite.contains(e.id)).toList();
                });
              },
              isFavorite: (id) {
                return _favorite.contains(id);
              })
          : ContactListView(
              people: _favoritePeople,
              onTileTapped: (p) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return PersonDetailsScreen(person: p);
                  },
                ));
              },
              onPressed: (p) {
                setState(() {
                  if (_favorite.contains(p.id)) {
                    _favorite.remove(p.id);
                    return;
                  }

                  _favorite.add(p.id);
                  _favoritePeople =
                      people.where((e) => _favorite.contains(e.id)).toList();
                });
              },
              isFavorite: (id) {
                return _favorite.contains(id);
              }),
    );
  }
}

class ContactListView extends StatelessWidget {
  const ContactListView({
    super.key,
    required this.people,
    required this.onPressed,
    required this.isFavorite,
    required this.onTileTapped,
  });

  final void Function(Person p) onPressed;
  final bool Function(String? id) isFavorite;
  final void Function(Person p) onTileTapped;

  final List<Person> people;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final p = people[index];
          return ContactListItem(
              p: p,
              onTap: () => onTileTapped(p),
              trailing: LikeButton(
                  favorite: isFavorite(p.id), onPressed: () => onPressed(p)));
        });
  }
}

class PersonDetailsScreen extends StatefulWidget {
  const PersonDetailsScreen({
    super.key,
    required this.person,
  });

  final Person person;

  @override
  State<PersonDetailsScreen> createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.person.firstName!),
        ),
        body: Column(
          children: [
            Hero(
              tag: widget.person.id!,
              child: Image.network(
                widget.person.picture!.large!,
              ),
            ),
            Center(
              child: Text(
                widget.person.email!,
                style: TextStyle(fontSize: 42),
              ),
            )
          ],
        ),
      ),
    );
  }
}
