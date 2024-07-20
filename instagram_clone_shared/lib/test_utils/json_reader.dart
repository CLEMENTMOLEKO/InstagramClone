import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

final class JsonReader {
  // static String readAsStringFrom({required String path}) {
  //   return File("assets/json/$path").readAsStringSync();
  // }

  static Future<String> readAsStringFrom({required String path}) async {
    return await rootBundle
        .loadString('packages/instagram_clone_shared/assets/json/$path');
  }
}
