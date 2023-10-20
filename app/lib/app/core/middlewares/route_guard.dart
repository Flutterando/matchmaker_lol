import 'dart:async';

import 'package:app/app/app_module.dart';
import 'package:app/app/rift/domain/state/rift_state.dart';
import 'package:app/app/rift/domain/stores/rift_store.dart';
import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

FutureOr<RouteInformation> routeGuardRoom(RouteInformation information) async {
  final queryRoom = information.query(routePaths.rift.room.$id.path);

  if (queryRoom == null) {
    return information;
  }
  final roomId = queryRoom['id'];
  final store = appInjector.get<RiftStore>();

  await store.enterRoom(roomId);

  return information;
}

FutureOr<RouteInformation> routeGuardMatch(RouteInformation information) async {
  final queryMatch = information.query(routePaths.rift.room.$id.match);

  if (queryMatch == null) {
    return information;
  }
  final roomId = queryMatch['id'];
  final store = appInjector.get<RiftStore>();

  await store.enterRoom(roomId);

  if (store.value is ErrorRiftState) {
    return information.redirect(information.uri.resolve('../$roomId'));
  }

  return information;
}
