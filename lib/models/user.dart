import 'dart:convert';
import 'dart:math';

import 'package:codestatsapp/models/language.dart';
import 'package:codestatsapp/models/machine.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PROFILE_URL = "https://codestats.net/api/users/";
const double LEVEL_FACTOR = 0.025;

class User extends ChangeNotifier {

  List<Language> languages = [];
  List<Machine> machines = [];

  int daily_xps = 0;
  int total_xps = 0;
  String username = "change me";

  User(context) {
    update(context);
  }

  void build() {
    notifyListeners();
  }

  void update(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.username = prefs.getString("username");
    Response response = await get("$PROFILE_URL$username");
    Map<String, dynamic> user = jsonDecode(response.body);
    var error = user['error'];
    if (error != null) {
      print("ERROR ! BAD USERNAME !");
      notifyListeners();
      return;
    }
    languages.clear();
    total_xps = user['total_xp'];
    daily_xps = user['new_xp'];
    var jsonLanguages = user['languages'];
    Map<String, dynamic> tmp = jsonLanguages;
    tmp.forEach((key, value) {
      languages.add(Language(key, jsonLanguages[key]['xps'], jsonLanguages[key]['new_xps']));
    });
    notifyListeners();
  }

  int getLevel() {
    double level = (LEVEL_FACTOR * sqrt(this.total_xps));
    return level.toInt();
  }

}