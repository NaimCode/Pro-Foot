import 'package:flutter/services.dart';

class Convertion {
  static Future<String> stringToJson(String source) {
    return rootBundle.loadString(source);
  }
}
