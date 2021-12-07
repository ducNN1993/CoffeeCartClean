import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppLocalizations {
  static AppLocalizations shared = AppLocalizations._();
  Map<dynamic, dynamic> _localisedValues = {};

  AppLocalizations._() {}

  static AppLocalizations of(BuildContext context) {
    return shared;
  }

  String text(String key) {
    return _localisedValues[key] ?? "$key not found";
  }

  // defined text
  String get connectionError => text('connection_error');
  String get total => text('total');
  String get addItemToCart => text('add_item_to_cart');
  String get required =>
      text('required');
  String get selectItem =>
      text('select_item');

  Future<void> reloadLanguageBundle({required String languageCode}) async {
    String path =
        "assets/json/localization_${languageCode.toLowerCase()}.json";
    String jsonContent = "";
    try {
      jsonContent = await rootBundle.loadString(path);
    } catch (_) {
      //use default Vietnamese
      jsonContent =
          await rootBundle.loadString("assets/json/localization_en.json");
    }
    _localisedValues = json.decode(jsonContent);
  }
}
