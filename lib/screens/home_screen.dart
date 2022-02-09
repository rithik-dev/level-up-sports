import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:level_up_sports/l10n/l10n.dart';
import 'package:level_up_sports/screens/game_room_screen.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'HomeScreen';

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: TabBar(
              labelStyle: const TextStyle(fontSize: 18),
              tabs: [
                Tab(text: L10n.dictionary.gameRooms),
                Tab(text: L10n.dictionary.credits),
              ],
            ),
          ),
          body: DoubleBackToCloseApp(
            snackBar: SnackBar(
              content: Text(L10n.dictionary.tapBackButtonAgainToExit),
            ),
            child: TabBarView(
              children: [
                _buildGameRoomsView(context),
                _buildCreditsView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameRoomsView(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text(L10n.dictionary.defaultGameRoom),
          onTap: () => Navigator.pushNamed(context, GameRoomScreen.id),
        ),
      ],
    );
  }

  Widget _buildCreditsView() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        L10n.dictionary.creditsText,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
