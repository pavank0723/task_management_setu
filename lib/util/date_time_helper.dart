import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management_setu/res/res.dart';

class DateTimeHelper {
  static String formatAnyDateTimeRes(String time, String oFormat) {
    final format = DateFormat(oFormat);

    return format.format(DateTime.parse(time));
  }

  static String formatAnyDateTime(String time, String oFormat) {
    try {
      // Try to parse the string with the specified format.
      final format = DateFormat(oFormat);
      DateTime parsedDate;

      // If the date string is not in the expected format, handle it gracefully.
      if (time.contains('-')) {
        parsedDate = DateFormat("dd-MM-yyyy HH:mm").parse(time); // Adjust as needed
      } else {
        parsedDate = DateTime.parse(time); // Fallback for ISO format
      }

      return format.format(parsedDate);
    } catch (e) {
      // If there's an error in parsing, return a default value or an error string.
      print('Error parsing date: $e');
      return time;  // or you can return a default value like '01-01-0001'
    }
  }


  static String formatAnyDateTimeReq(String time, String oFormat) {
    if (time.isEmpty) {
      // Return an empty string or handle the error as needed
      return '';
    }
    try {
      final format = DateFormat(oFormat);
      final parsedDate = DateFormat('dd-MM-yyyy HH:mm').parse(time);
      return format.format(parsedDate);
    } catch (e) {
      debugPrint("Error parsing date: $e");
      return '';
    }
  }

  static List<Widget> buildDatedSections<T>(
    List<T> dataList,
    String Function(T) getDate,
    Widget Function(T) buildItemWidget,
  ) {
    final List<Widget> sectionWidgets = [];

    String currentHeader = '';

    for (final data in dataList) {
      final String taskInTimeString = getDate(data);
      final List<String> dateTimeComponents = taskInTimeString.split('T');
      final String dateString = dateTimeComponents[0];

      final DateTime taskInTime = DateTime.parse(taskInTimeString);

      if (isToday(taskInTime)) {
        if (currentHeader != 'Today') {
          currentHeader = 'Today';
          sectionWidgets.add(_buildHeader(currentHeader));
        }
      } else if (isYesterday(taskInTime)) {
        if (currentHeader != 'Yesterday') {
          currentHeader = 'Yesterday';
          sectionWidgets.add(_buildHeader(currentHeader));
        }
      } else {
        final String header = _getHeaderForDate(taskInTime);
        if (currentHeader != header) {
          currentHeader = header;
          sectionWidgets.add(_buildHeader(currentHeader));
        }
      }

      sectionWidgets.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: buildItemWidget(data),
      ));
    }

    return sectionWidgets;
  }

  static String _getHeaderForDate(DateTime date) {
    final int daysDifference = DateTime.now().difference(date).inDays;
    if (daysDifference <= 3) {
      return 'Previous $daysDifference days';
    } else if (daysDifference <= 7) {
      return 'Previous 7 days';
    } else if (daysDifference <= 10) {
      return 'Previous 10 days';
    } else if (daysDifference <= 30) {
      return 'Previous 30 days';
    } else {
      return 'Older Data';
    }
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isYesterday(DateTime date) {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  static Widget _buildHeader(String title) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
      child: Text(title,
          style: AppTextStyle.subTitle2M()), // Replace with your text style
    );
  }
}
