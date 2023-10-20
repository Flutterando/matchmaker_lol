import 'package:auto_injector/auto_injector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'services/local_storage/local_storage.dart';
import 'services/local_storage/shared_preferences_local_storage.dart';

final coreInjector = AutoInjector(
  on: (i) {
    i.addInstance<FirebaseFirestore>(FirebaseFirestore.instance);
    i.addSingleton<LocalStorage>(SharedPreferencesLocalStorage.new);
    i.commit();
  },
);
