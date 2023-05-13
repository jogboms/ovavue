import 'package:ovavue/domain.dart';

class PreferencesMockImpl implements PreferencesRepository {
  @override
  Future<String> fetchDatabaseLocation() async => 'db.sqlite';

  @override
  Future<bool?> importDatabase() async => true;

  @override
  Future<bool?> exportDatabase() async => true;
}
