import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _preferences;

  static const String _keyFavoriteTeam = 'preferredTeamId';

  static Future<void> initPreferences() async {
    await _initPreferences();
  }

  static Future<void> _initPreferences() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static int? getPreferredTeamId() {
    // Make sure preferences are initialized before accessing
    assert(_preferences != null, 'Call initPreferences before accessing preferences');
    return _preferences?.getInt(_keyFavoriteTeam);
  }

  static void setPreferredTeamId(int teamId) {
    // Make sure preferences are initialized before accessing
    assert(_preferences != null, 'Call initPreferences before accessing preferences');
    _preferences?.setInt(_keyFavoriteTeam, teamId);
  }

  static bool isTeamFavorite(int teamId) {
    // Make sure preferences are initialized before accessing
    assert(_preferences != null, 'Call initPreferences before accessing preferences');
    final int? favoriteTeamId = _preferences?.getInt(_keyFavoriteTeam);
    return favoriteTeamId == teamId;
  }

   static void toggleTeamFavorite(int teamId) {
    // Make sure preferences are initialized before accessing
    assert(_preferences != null, 'Call initPreferences before accessing preferences');
    final int? favoriteTeamId = _preferences?.getInt(_keyFavoriteTeam);
    print("favoriteTeamId");
    print(favoriteTeamId);
    print("teamId");
    print(teamId);
    if (favoriteTeamId == teamId) {
      // The team is already the favorite, remove it
      _preferences?.remove(_keyFavoriteTeam);
      print(_preferences);
    } else {
      // Set the new favorite team
      _preferences?.setInt(_keyFavoriteTeam, teamId);
      print("_preferences");
      print(_preferences);
    }
  }
}
