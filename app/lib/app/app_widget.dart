import 'package:app/app/core/middlewares/route_guard.dart';
import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      routerConfig: Routefly.routerConfig(
        middlewares: [routeGuardRoom, routeGuardMatch],
        routes: routes,
      ),
    );
  }
}
