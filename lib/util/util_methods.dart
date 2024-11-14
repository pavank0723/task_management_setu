import 'dart:math';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_management_setu/res/app_color.dart';

class UtilMethods {
  static showToast(String msg, ToastType type) {
    Color bgColor = Colors.grey;
    var txtColor = Colors.black;

    switch (type) {
      case ToastType.success:
        bgColor = Colors.green;
        txtColor = Colors.white;
        break;
      case ToastType.error:
        bgColor = Colors.red;
        txtColor = Colors.white;
        break;
      case ToastType.warning:
        bgColor = Colors.orange;
        txtColor = Colors.white;
        break;
      case ToastType.info:
        bgColor = AppColor.grey;
        txtColor = AppColor.greyDark;
        break;
    }

    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: txtColor,
        fontSize: 16.0);
  }

  static int generateRandomNo(int noOfDigits) {
    var rng = Random();
    var code = rng.nextInt(9 * pow(10, noOfDigits - 1).toInt()) +
        pow(10, noOfDigits).toInt();

    return code;
  }

  static String getCombinedFirstLetters(String text) {
    List<String> words = text.split(" "); // Split into individual words
    List<String> firstLetters = words.take(2).map((word) {
      if (word.isNotEmpty) {
        return word.substring(0, 1); // Extract first letter of each word
      } else {
        return ''; // Empty string for empty words
      }
    }).toList();
    return firstLetters.join(); // Join the first letters together
  }

  static Color getStatusColor(String statusTitle) {
    // Customize the colors based on the statusTitle
    if (statusTitle == 'In Progress') {
      return AppColor.warning;
    } else if (statusTitle == 'Completed' || statusTitle == 'Done') {
      return AppColor.successDark;
    } else if (statusTitle == 'Pending' || statusTitle == '') {
      return AppColor.error;
    } else {
      return AppColor.error;
    }
  }

  static Color getStatusTextColor(String statusTitle) {
    // Customize the text colors based on the statusTitle
    if (statusTitle == 'In Progress') {
      return AppColor.greyLightest;
    } else if (statusTitle == 'Completed' || statusTitle == 'Done') {
      return AppColor.greyLightest;
    } else if (statusTitle == 'Pending') {
      return AppColor.errorLightest;
    } else {
      return AppColor.errorLightest;
    }
  }


  static String formatDateTimeToDate(String dateTimeString) {
    DateFormat inputFormat = DateFormat('M/d/yyyy h:mm:ss a');
    DateTime dateTime = inputFormat.parse(dateTimeString);
    DateFormat outputFormat = DateFormat('MM/dd/yyyy');
    String formattedDate = outputFormat.format(dateTime);
    return formattedDate;
  }

  static String formatAddedOnDateToDateWithoutTime(String dateTimeString) {
    // ISO 8601 format
    DateFormat inputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    DateTime dateTime = inputFormat.parse(dateTimeString);

    // Desired output format
    DateFormat outputFormat = DateFormat('MM/dd/yyyy');
    String formattedDate = outputFormat.format(dateTime);

    return formattedDate;
  }


  String getTimeDifference(String dateString) {
    // Parse the date string
    DateTime date = DateTime.parse(dateString);
    final Duration difference = DateTime.now().difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes == 1) {
      return '1 minute ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours == 1) {
      return '1 hour ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return '1 day ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 365) {
      final int months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final int years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }


}


enum ToastType { success, error, warning, info }
