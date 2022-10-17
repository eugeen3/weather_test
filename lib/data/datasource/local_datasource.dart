import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  LocalDataSource({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;
}
