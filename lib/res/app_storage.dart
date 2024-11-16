import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppStorage {
  final _storage = const FlutterSecureStorage();

  final _isDarkTheme = "isDarkTheme";

  // Permission Allowed
  final _isNotificationAllowed = "isNotificationAllowed";

  final mTrue = "1";
  final mFalse = "0";

  Future updateDarkTheme(bool theme) async {
    await _storage.write(key: _isDarkTheme, value: theme ? "1" : "0");
  }

  Future<bool> getDarkTheme() async {
    var readData = await _storage.read(key: _isDarkTheme);
    return readData != null ? readData == mTrue : false;
  }

  Future updateNotificationPermission(bool notification) async {
    await _storage.write(
        key: _isNotificationAllowed, value: notification ? "1" : "0");
  }

  Future<bool> getNotificationPermission() async {
    var readData = await _storage.read(key: _isNotificationAllowed);
    return readData != null ? readData == mTrue : false;
  }
}
