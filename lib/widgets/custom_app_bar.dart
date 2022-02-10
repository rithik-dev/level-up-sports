import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  static const id = 'CustomAppBar';

  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late final ScaffoldState scaffoldState;

  @override
  void initState() {
    scaffoldState = context.findRootAncestorStateOfType<ScaffoldState>()!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Navigator.canPop(context)
          ? const BackButton()
          : const SizedBox.shrink(),
      centerTitle: true,
      title: Image.asset(
        'assets/images/app-bar-logo.png',
        height: 50,
      ),
      actions: [
        if (scaffoldState.hasEndDrawer)
          IconButton(
            onPressed: scaffoldState.openEndDrawer,
            icon: const Icon(Icons.menu),
          ),
      ],
    );
  }
}
