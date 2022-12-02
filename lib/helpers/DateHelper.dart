

import 'dart:math';

abstract class DateHelper {

  static String generateCurrentDate(){
    DateTime date = DateTime.now();
    return "${date.year}-${date.month}-${date.day}T${date.hour}:${date.minute}:${date.second}.${Random().nextInt(1000)}Z";
  }

}