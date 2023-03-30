import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Util {
  static String fancyDateString(DateTime? date) {
    if (date == null) {
      return "";
    } else {
      return "${date.day}.${date.month}.${date.year}";
    }
  }

  static showDatePicker({required BuildContext context, DateTime? initialDateTime, required Function(DateTime) onDateChange}) {
    showCupertinoModalPopup(
      context: context,
      semanticsDismissible: true,
      builder: (context) {
        return Container(
          height: 250,
          color: Colors.white,
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              onDateTimeChanged: onDateChange,
              use24hFormat: true,
              initialDateTime: initialDateTime,
              mode: CupertinoDatePickerMode.date,
            ),
          ),
        );
      },
    );
  }
}
