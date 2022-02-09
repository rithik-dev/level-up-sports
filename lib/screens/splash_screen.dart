import 'package:flutter/material.dart';
import 'package:level_up_sports/screens/home_screen.dart';
import 'package:level_up_sports/widgets/custom_loader.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'SplashScreen';

  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    (() async {
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    })();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: Image.asset('assets/images/logo.png'),
            ),
            const CustomLoader(),
          ],
        ),
      ),
    );
  }
}
