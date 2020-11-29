import 'dart:convert';

import 'package:flutter/services.dart';

class Config {
  static const String _CONFIG_PATH = 'assets/config.json';
  static const String _CONFIG_API_KEY = 'sport_radar_api_key';

  static final Config _instance = Config._internal();

  String _apiKey;

  factory Config() => _instance;

  Config._internal();

  Future<String> getApiKey() {
    if (_apiKey == null) {
      return _loadApiKeyFromJson();
    } else {
      return Future.value(_apiKey);
    }
  }

  Future<String> _loadApiKeyFromJson() async {
    final String content = await rootBundle.loadString(_CONFIG_PATH);
    final json = jsonDecode(content);
    return json[_CONFIG_API_KEY];
  }
}
