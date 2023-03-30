import 'package:flutter/foundation.dart';

enum Gender {
  male,
  female,
  other,
  unknown,
}

String translateGender(Gender gender) {
  switch (gender) {
    case Gender.male: return "Männlich";
    case Gender.female: return "Weiblich";
    case Gender.other: return "Divers";
    case Gender.unknown: return "Unbekannt";
  }
}

class EnumParser {
  static T? parse<T extends Enum>(Iterable<T> values, String encoded) {
    try {
      return values.firstWhere((ele) => describeEnum(ele) == encoded);
    } catch(e) {
      return null;
    }
  }

  static String encode<T extends Enum>(T value) {
    return describeEnum(value);
  }
}
