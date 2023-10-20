import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import 'app/rift/home_page.dart' as a2;
import 'app/rift/room/[id]/match/match_page.dart' as a0;
import 'app/rift/room/[id]/room_page.dart' as a1;
import 'app/splash_page.dart' as a3;

List<RouteEntity> get routes => [
  RouteEntity(
    key: '/',
    uri: Uri.parse('/'),
    routeBuilder: (ctx, settings) => MaterialPageRoute(
      settings: settings,
      builder: (context) => const a3.SplashPage(),
    ),
  ),
  RouteEntity(
    key: '/rift',
    uri: Uri.parse('/rift'),
    routeBuilder: (ctx, settings) => MaterialPageRoute(
      settings: settings,
      builder: (context) => const a2.HomePage(),
    ),
  ),
  RouteEntity(
    key: '/rift/room/[id]',
    uri: Uri.parse('/rift/room/[id]'),
    routeBuilder: (ctx, settings) => MaterialPageRoute(
      settings: settings,
      builder: (context) => const a1.RoomPage(),
    ),
  ),
  RouteEntity(
    key: '/rift/room/[id]/match',
    uri: Uri.parse('/rift/room/[id]/match'),
    routeBuilder: (ctx, settings) => MaterialPageRoute(
      settings: settings,
      builder: (context) => const a0.MatchPage(),
    ),
  ),
];

const routePaths = (
  path: '/',
  rift: (
    path: '/rift',
    room: (
      path: '/rift/room',
      $id: (
        path: '/rift/room/[id]',
        match: '/rift/room/[id]/match',
      ),
    ),
  ),
);
