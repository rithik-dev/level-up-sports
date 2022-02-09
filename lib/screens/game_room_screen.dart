import 'package:flutter/material.dart';
import 'package:level_up_sports/l10n/l10n.dart';
import 'package:level_up_sports/utils/helpers.dart';

class GameRoomScreen extends StatefulWidget {
  static const id = 'GameRoomScreen';

  const GameRoomScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GameRoomScreen> createState() => _GameRoomScreenState();
}

class _GameRoomScreenState extends State<GameRoomScreen>
    with SingleTickerProviderStateMixin {

  int? winner;
  int? removed;

  final chairs = List.generate(100, (idx) => idx + 1);

  Stream<int> _getRemovedPlayers() async* {
    int chairIdx = 0;
    int difference = 1;
    while (chairs.length > 1) {
      final removed = chairs.removeAt(chairIdx);
      yield removed;
      if (chairs.length == 1) {
        _controller.reset();
        setState(() => winner = chairs[0]);
        showSnackBar(context, text: L10n.dictionary.winnerIs('$winner'));
      } else {
        _controller.forward(from: 0);
      }
      chairIdx += difference;
      difference++;
      chairIdx %= chairs.length;
      await Future.delayed(_duration);
    }
  }

  static const _duration = Duration(milliseconds: 250);

  late final AnimationController _controller;
  late final Animation<double> _slideAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _duration);

    _slideAnimation = Tween<double>(begin: 0, end: 100).animate(_controller);
    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(_controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: winner == null
              ? StreamBuilder<int>(
                  stream: _getRemovedPlayers(),
                  builder: (context, snapshot) {
                    return AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) => Opacity(
                        opacity: _opacityAnimation.value,
                        child: _buildCard('${snapshot.data}'),
                      ),
                    );
                  },
                )
              : _buildCard('$winner', isWinner: true),
        ),
      ),
    );
  }

  Widget _buildCard(String numberText, {bool isWinner = false}) {
    return Padding(
      padding: EdgeInsets.only(left: _slideAnimation.value),
      child: Container(
        alignment: Alignment.center,
        width: 150 * (isWinner ? 1.5 : 1),
        height: 300 * (isWinner ? 1.5 : 1),
        decoration: BoxDecoration(
          color: isWinner ? Colors.black : Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          numberText,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: isWinner ? Colors.amberAccent : Colors.white,
          ),
        ),
      ),
    );
  }
}
