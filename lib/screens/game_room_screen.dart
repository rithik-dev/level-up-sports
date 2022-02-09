import 'package:flutter/material.dart';

class GameRoomScreen extends StatelessWidget {
  static const id = 'GameRoomScreen';

  const GameRoomScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            'GameRoomScreen',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
    );
  }
}
