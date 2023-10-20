import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Routefly.navigate(routePaths.rift.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Flutterando',
                style: TextStyle(color: Colors.white, fontSize: 64),
              ),
              Text(
                'MatchMaker',
                style: TextStyle(color: Colors.white, fontSize: 64),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
