import 'package:shared_preferences/shared_preferences.dart';

import '../../initialize_dependencies.dart';

class LocalService {
  final String keyAuth = 'key_auth';

  final _sharedPref = sl.get<SharedPreferences>();

  bool isAuthorized() {
    return _sharedPref.containsKey(keyAuth);
  }
}
