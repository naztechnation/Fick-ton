import 'package:collection/collection.dart' show IterableExtension;

class EnumHandler{

  static T? enumFromString<T>(String value, {required Iterable<T> values}) {
    return values.firstWhereOrNull((type) => type.toString().split(".").last == value);
  }

  static String enumToString<T>(T? value) {
    return value.toString().split('.').last;
  }

}