import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:level_up_sports/l10n/l10n.dart';

class CustomDrawer extends StatelessWidget {
  static const id = 'CustomDrawer';

  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  static const _iconSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Material(
            clipBehavior: Clip.hardEdge,
            color: Colors.white24,
            child: SizedBox.expand(),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: const BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 1,
                    blurRadius: 4,
                  )
                ],
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(50),
                ),
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    iconSize: _iconSize,
                    icon: const Icon(Icons.close),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildButton(
                          text: L10n.dictionary.account,
                          iconData: Icons.person,
                        ),
                        const SizedBox(height: 25),
                        _buildButton(
                          text: L10n.dictionary.settings,
                          iconData: Icons.settings,
                        ),
                        const SizedBox(height: 25),
                        _buildButton(
                          text: L10n.dictionary.language,
                          iconData: Icons.language,
                        ),
                        const SizedBox(height: 25),
                        _buildButton(
                          text: L10n.dictionary.themes,
                          iconData: Icons.brush,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    iconSize: _iconSize,
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required IconData iconData,
  }) {
    return Column(
      children: [
        Icon(iconData, size: _iconSize),
        const SizedBox(height: 2.5),
        FittedBox(
          child: Text(text.toUpperCase()),
        ),
      ],
    );
  }
}
