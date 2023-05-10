import 'package:ovavue/domain.dart';

class PreferencesMockImpl implements PreferencesRepository {
  @override
  Future<String> fetchDatabaseLocation() async => 'db.sqlite';
}
