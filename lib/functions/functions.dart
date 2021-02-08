/// Class that holds functions we use in this project
abstract class Funktionen {
  /// Checks whether a string holds a numeric value
  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    final sNeu = s.replaceAll(',', '.');
    try {
      // ignore: unused_local_variable
      final parseDouble = double.parse(sNeu);
    } catch (e) {
      return false;
    }
    return true;
  }
}
