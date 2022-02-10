import 'package:flutter/material.dart';
import 'package:level_up_sports/l10n/l10n.dart';
import 'package:level_up_sports/widgets/custom_app_bar.dart';

class GameRoomScreen extends StatefulWidget {
  static const id = 'GameRoomScreen';

  const GameRoomScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GameRoomScreen> createState() => _GameRoomScreenState();
}

class _GameRoomScreenState extends State<GameRoomScreen> {
  bool _lookingForPlayer = false;
  int? _winner;

  static const _chairsLen = 100;

  final chairs = List.generate(_chairsLen, (idx) => idx + 1);

  void _removePlayers() async {
    int chairIdx = 0;
    int difference = 1;
    setState(() => _lookingForPlayer = true);
    while (chairs.length > 1) {
      chairs.removeAt(chairIdx);
      if (chairs.length == 1) {
        _lookingForPlayer = false;
        _winner = chairs[0];
        // showSnackBar(context, text: L10n.dictionary.winnerIs('$_winner'));
      }
      setState(() {});
      chairIdx += difference;
      difference++;
      chairIdx %= chairs.length;
      await Future.delayed(_duration);
    }
  }

  static const _duration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(25),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  mainAxisSpacing: 2.5,
                  crossAxisSpacing: 2.5,
                ),
                itemBuilder: (_, index) => _buildCard(index),
                itemCount: _chairsLen,
              ),
              if (_lookingForPlayer)
                const SizedBox.shrink()
              else if (_winner == null)
                TextButton(
                  onPressed: _removePlayers,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.play_arrow, color: Colors.white),
                      const SizedBox(width: 5),
                      Text(
                        L10n.dictionary.play,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: [
                    Text(
                      L10n.dictionary.winner,
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: _buildCard(_winner! - 1, padding: 25),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(int index, {double? padding}) {
    return Card(
      margin: EdgeInsets.zero,
      color: (_winner == null || _winner == index + 1)
          ? null
          : Theme.of(context).cardColor.withOpacity(0.25),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding ?? (index == 99 ? 5 : 7.5)),
        child: FittedBox(
          child: Center(
            child: Text(
              chairs.contains(index + 1) ? '${index + 1}' : '',
            ),
          ),
        ),
      ),
    );
  }
}
