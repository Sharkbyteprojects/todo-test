import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ConfigD {
  static Future<Map> loadAsset() async {
    WidgetsFlutterBinding.ensureInitialized();
    final config = jsonDecode(
      await rootBundle.loadString('assets/config.json'),
    );
    assert(config is Map);
    return config;
  }
}
