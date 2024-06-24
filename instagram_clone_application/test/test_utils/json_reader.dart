import 'dart:io';

final class JsonReader {
  static String readAsStringFrom({required String path}) {
    return File("./test/test_utils/json/$path").readAsStringSync();
  }
}
