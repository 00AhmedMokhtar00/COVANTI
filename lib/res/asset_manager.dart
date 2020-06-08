import 'dart:convert';

import 'package:flutter/services.dart';

class AssetManager{



  static Future<Map> loadJsonData(String assetPath) async {
    final ByteData jsonData = await rootBundle.load(assetPath);
    final String jsonString = utf8.decode(jsonData.buffer.asUint8List());
    final body = json.decode(jsonString);
    return body;
  }

}