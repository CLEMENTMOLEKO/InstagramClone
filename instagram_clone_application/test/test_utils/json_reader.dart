import 'dart:io';

final class JsonReader {
  static String readAsStringFrom({required String path}) {
    return File(path).readAsStringSync();
  }
}
