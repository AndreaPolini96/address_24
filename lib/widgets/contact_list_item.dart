import 'package:address_24/models/person.dart';
import 'package:flutter/material.dart';

class ContactListItem extends StatelessWidget {
  const ContactListItem(
      {super.key,
      required this.p,
      required this.trailing,
      required this.onTap});

  final Person p;
  final Function() onTap;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Hero(
        tag: p.id!,
        child: CircleAvatar(
          backgroundImage: NetworkImage(p.picture!.thumbnail!),
        ),
      ),
      title: Text(p.firstName!),
      subtitle: Text(p.cell!),
      trailing: trailing,
    );
  }
}
