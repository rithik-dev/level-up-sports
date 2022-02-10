import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:level_up_sports/l10n/l10n.dart';
import 'package:level_up_sports/screens/game_room_screen.dart';
import 'package:level_up_sports/widgets/custom_app_bar.dart';
import 'package:level_up_sports/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'HomeScreen';

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final _tabs = [
    L10n.dictionary.gameRooms,
    L10n.dictionary.credits,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        endDrawer: const CustomDrawer(),
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
            content: Text(L10n.dictionary.tapBackButtonAgainToExit),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RotatedBox(
                quarterTurns: 1,
                child: Row(
                  children: List.generate(
                    _tabs.length,
                    (index) => GestureDetector(
                      onTap: () => setState(() => _selectedIndex = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.5,
                          horizontal: 17.5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                          gradient: index == _selectedIndex
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFFFFAD1B),
                                    Color(0xFFFE440A),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                )
                              : null,
                        ),
                        child: Text(
                          _tabs[index].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: [
                    _buildGameRoomsView(context),
                    _buildCreditsView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameRoomsView(BuildContext context) {
    return ListView(
      children: [
        _buildGameRoom(
          title: L10n.dictionary.intPlayers('200'),
          imageUrl:
              'https://images.unsplash.com/photo-1586227740560-8cf2732c1531?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1561&q=80',
        ),
        _buildGameRoom(
          title: L10n.dictionary.intPlayers('100'),
          imageUrl:
              'https://images.unsplash.com/photo-1524758631624-e2822e304c36?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        ),
        _buildGameRoom(
          title: L10n.dictionary.intPlayers('50'),
          imageUrl:
              'https://images.unsplash.com/photo-1644333192086-60154e540a11?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80',
        ),
      ],
    );
  }

  Widget _buildGameRoom({
    required String title,
    required String imageUrl,
  }) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, GameRoomScreen.id),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            title: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
            trailing: const Icon(Icons.arrow_forward, color: Colors.white),
          )
        ],
      ),
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
