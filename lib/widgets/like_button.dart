import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  const LikeButton(
      {super.key, required this.favorite, required this.onPressed});

  final void Function() onPressed;
  final bool favorite;

  _getColor() {
    return favorite ? Colors.red : Colors.blueGrey;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.favorite,
          color: _getColor(),
        ));
  }
}
