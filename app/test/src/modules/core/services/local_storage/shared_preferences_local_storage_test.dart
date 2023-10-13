import 'package:app/src/modules/core/services/local_storage/shared_preferences_local_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Local Storage:', () {
    const instance = SharedPreferencesLocalStorage();

    SharedPreferences.setMockInitialValues({
      'string': 'string input saved on local storage',
      'bool': true,
      'int': 0,
    });

    test('get String', () async {
      final stringValue = await instance.getString('string');
      expect(stringValue, 'string input saved on local storage');
    });

    test('get bool', () async {
      final boolValue = await instance.getBool('bool');
      expect(boolValue, true);
    });

    test('get int', () async {
      final intValue = await instance.getInt('int');
      expect(intValue, 0);
    });

    test('set String', () async {
      await instance.setString('setString', value: 'string input');
      expect(await instance.getString('setString'), 'string input');
    });

    test('set bool', () async {
      await instance.setBool('setBool', value: false);
      expect(await instance.getBool('setBool'), false);
    });

    test('set int', () async {
      await instance.setInt('setInt', value: 2);
      expect(await instance.getInt('setInt'), 2);
    });

    test('remove data', () async {
      await instance.setInt('needCleanData', value: 9999);
      expect(await instance.getInt('needCleanData'), 9999);

      await instance.clean('needCleanData');
      expect(await instance.getInt('needCleanData'), null);
    });

    test('get null data', () async {
      expect(await instance.getString('nullData'), null);
    });
  });
}
