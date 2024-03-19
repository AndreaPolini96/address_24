import 'package:address_24/models/person.dart';
import 'package:address_24/services/people_service.dart';
import 'package:address_24/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'screens/home_screen.dart';
import 'widgets/contact_item.dart';
import 'widgets/contact_list_item.dart';

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

  Widget _buildListTile({required Person p}) {
    return ContactListItem(
        p: p,
        onTap: () {},
        trailing: LikeButton(
          favorite: _favorite.contains(p.id),
          onPressed: () {
            setState(() {
              if (_favorite.contains(p.id)) {
                _favorite.remove(p.id);
                _favoritePeople =
                    people.where((e) => _favorite.contains(e.id)).toList();
                return;
              } else {
                _favorite.add(p.id);
              }
              _favoritePeople =
                  people.where((e) => _favorite.contains(e.id)).toList();
            });
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          onTap: (index) => {setState(() => _currentIndex = index)},
          currentIndex: _currentIndex,
          selectedItemColor: Colors.amber,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.list_rounded), label: "List"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded), label: "Favorite")
          ]),
      body: _currentIndex == 0
          ? ContactListView(
              people: people,
              onTileTapped: (p) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return DetailsItem(p: p);
                }));
              },
              onPressed: (p) {
                setState(() {
                  if (_favorite.contains(p.id)) {
                    _favorite.remove(p.id);
                    _favoritePeople =
                        people.where((e) => _favorite.contains(e.id)).toList();
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return DetailsItem(p: p);
                }));
              },
              onPressed: (p) {
                setState(() {
                  if (_favorite.contains(p.id)) {
                    _favorite.remove(p.id);
                    _favoritePeople =
                        people.where((e) => _favorite.contains(e.id)).toList();
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

  final void Function(Person p) onTileTapped;
  final void Function(Person p) onPressed;
  final bool Function(String? id) isFavorite;
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
                  favorite: isFavorite(p.id),
                  onPressed: () {
                    onPressed(p);
                  }));
        });
  }
}

class DetailsItem extends StatelessWidget {
  const DetailsItem({super.key, required this.p});
  final Person p;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${p.firstName} ${p.lastName}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(p.picture!.thumbnail!),
              radius: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Name: ${p.firstName} ${p.lastName}', style: const TextStyle(fontSize: 20)),
            Text('Email: ${p.email}', style: const TextStyle(fontSize: 20)),
            Text('Phone: ${p.cell}', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
