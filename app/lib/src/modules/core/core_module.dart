import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'services/local_storage/local_storage.dart';
import 'services/local_storage/shared_preferences_local_storage.dart';

class CoreModule extends Module {
  @override
  void binds(Injector i) {
    i.addInstance<FirebaseFirestore>(FirebaseFirestore.instance);
    i.addSingleton<LocalStorage>(SharedPreferencesLocalStorage.new);
  }
}
