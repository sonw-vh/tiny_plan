import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  ///get Visting Flag on first launch
  Future<bool> getVisitingFlag() async {
    var preferences = await SharedPreferences.getInstance();
    var alreadyVisited = preferences.getBool('alreadyVisited') ?? false;
    return alreadyVisited;
  }

  Future<bool> getAdventurerOrGuildMaster() async {
    var preferences = await SharedPreferences.getInstance();
    var isGuildMaster = preferences.getBool('isGuildMaster') ?? true;
    return isGuildMaster;
  }

  Future<bool> getDisplayShowCase() async {
    var preferences = await SharedPreferences.getInstance();
    var displayShowCase = preferences.getBool('displayShowCase') ?? false;
    return displayShowCase;
  }

  setVisitingFlag() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('alreadyVisited', true);
  }

  setGuildMasterDevice() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isGuildMaster', true);
  }

  setAdventurerDevice() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isAdventurer', false);
  }

  Future<bool> setDisplayShowCase() async {
    var preferences = await SharedPreferences.getInstance();
    var status = await preferences.setBool('displayShowCase', true);
    return status;
  }
}
