import 'package:cloud_firestore/cloud_firestore.dart';

class Goal30 {
  Goal30({
    required this.userName,
    required this.timestamp,
    required this.goal30Id,
    required this.userData,
    required this.goalLenght,
    required this.bmiCategory,
    required this.category,
    required this.day1,
    required this.day2,
    required this.day3,
    required this.day4,
    required this.day5,
    required this.day6,
    required this.day7,
    required this.day8,
    required this.day9,
    required this.day10,
    required this.day11,
    required this.day12,
    required this.day13,
    required this.day14,
    required this.day15,
    required this.day16,
    required this.day17,
    required this.day18,
    required this.day19,
    required this.day20,
    required this.day21,
    required this.day22,
    required this.day23,
    required this.day24,
    required this.day25,
    required this.day26,
    required this.day27,
    required this.day28,
    required this.day29,
    required this.day30,
    required this.day31,
    required this.day32,
    required this.day33,
    required this.day34,
    required this.day35,
    required this.day36,
    required this.day37,
    required this.day38,
    required this.day39,
    required this.day40,
    required this.day41,
    required this.day42,
    required this.day43,
    required this.day44,
    required this.day45,
    required this.day46,
    required this.day47,
    required this.day48,
    required this.day49,
    required this.day50,
    required this.day51,
    required this.day52,
    required this.day53,
    required this.day54,
    required this.day55,
    required this.day56,
    required this.day57,
    required this.day58,
    required this.day59,
    required this.day60,
    required this.day61,
    required this.day62,
    required this.day63,
    required this.day64,
    required this.day65,
    required this.day66,
    required this.day67,
    required this.day68,
    required this.day69,
    required this.day70,
    required this.day71,
    required this.day72,
    required this.day73,
    required this.day74,
    required this.day75,
    required this.day76,
    required this.day77,
    required this.day78,
    required this.day79,
    required this.day80,
    required this.day81,
    required this.day82,
    required this.day83,
    required this.day84,
    required this.day85,
    required this.day86,
    required this.day87,
    required this.day88,
    required this.day89,
    required this.day90,
  });
  final String userName;
  final String category;
  final Timestamp timestamp;
  final String bmiCategory;
  final int goalLenght;
  final String goal30Id;
  final bool userData;
  final bool day1;
  final bool day2;
  final bool day3;
  final bool day4;
  final bool day5;
  final bool day6;
  final bool day7;
  final bool day8;
  final bool day9;
  final bool day10;
  final bool day11;
  final bool day12;
  final bool day13;
  final bool day14;
  final bool day15;
  final bool day16;
  final bool day17;
  final bool day18;
  final bool day19;
  final bool day20;
  final bool day21;
  final bool day22;
  final bool day23;
  final bool day24;
  final bool day25;
  final bool day26;
  final bool day27;
  final bool day28;
  final bool day29;
  final bool day30;
  final bool day31;
  final bool day32;
  final bool day33;
  final bool day34;
  final bool day35;
  final bool day36;
  final bool day37;
  final bool day38;
  final bool day39;
  final bool day40;
  final bool day41;
  final bool day42;
  final bool day43;
  final bool day44;
  final bool day45;
  final bool day46;
  final bool day47;
  final bool day48;
  final bool day49;
  final bool day50;
  final bool day51;
  final bool day52;
  final bool day53;
  final bool day54;
  final bool day55;
  final bool day56;
  final bool day57;
  final bool day58;
  final bool day59;
  final bool day60;
  final bool day61;
  final bool day62;
  final bool day63;
  final bool day64;
  final bool day65;
  final bool day66;
  final bool day67;
  final bool day68;
  final bool day69;
  final bool day70;
  final bool day71;
  final bool day72;
  final bool day73;
  final bool day74;
  final bool day75;
  final bool day76;
  final bool day77;
  final bool day78;
  final bool day79;
  final bool day80;
  final bool day81;
  final bool day82;
  final bool day83;
  final bool day84;
  final bool day85;
  final bool day86;
  final bool day87;
  final bool day88;
  final bool day89;
  final bool day90;

  factory Goal30.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;

    return Goal30(
      userName: data['userName'] as String,
      timestamp: data['timestamp'] as Timestamp,
      goal30Id: data['goal30Id'] as String,
      bmiCategory: data['bmiCategory'] as String,
      goalLenght: data['goalLenght'] as int,
      userData: data['userData'] as bool,
      category: data['category'] as String,
      day1: data['day1'] as bool,
      day2: data['day2'] as bool,
      day3: data['day3'] as bool,
      day4: data['day4'] as bool,
      day5: data['day5'] as bool,
      day6: data['day6'] as bool,
      day7: data['day7'] as bool,
      day8: data['day8'] as bool,
      day9: data['day9'] as bool,
      day10: data['day10'] as bool,
      day11: data['day11'] as bool,
      day12: data['day12'] as bool,
      day13: data['day13'] as bool,
      day14: data['day14'] as bool,
      day15: data['day15'] as bool,
      day16: data['day16'] as bool,
      day17: data['day17'] as bool,
      day18: data['day18'] as bool,
      day19: data['day19'] as bool,
      day20: data['day20'] as bool,
      day21: data['day21'] as bool,
      day22: data['day22'] as bool,
      day23: data['day23'] as bool,
      day24: data['day24'] as bool,
      day25: data['day25'] as bool,
      day26: data['day26'] as bool,
      day27: data['day27'] as bool,
      day28: data['day28'] as bool,
      day29: data['day29'] as bool,
      day30: data['day30'] as bool,
      day31: data['day31'] as bool,
      day32: data['day32'] as bool,
      day33: data['day33'] as bool,
      day34: data['day34'] as bool,
      day35: data['day35'] as bool,
      day36: data['day36'] as bool,
      day37: data['day37'] as bool,
      day38: data['day38'] as bool,
      day39: data['day39'] as bool,
      day40: data['day40'] as bool,
      day41: data['day41'] as bool,
      day42: data['day42'] as bool,
      day43: data['day43'] as bool,
      day44: data['day44'] as bool,
      day45: data['day45'] as bool,
      day46: data['day46'] as bool,
      day47: data['day47'] as bool,
      day48: data['day48'] as bool,
      day49: data['day49'] as bool,
      day50: data['day50'] as bool,
      day51: data['day51'] as bool,
      day52: data['day52'] as bool,
      day53: data['day53'] as bool,
      day54: data['day54'] as bool,
      day55: data['day55'] as bool,
      day56: data['day56'] as bool,
      day57: data['day57'] as bool,
      day58: data['day58'] as bool,
      day59: data['day59'] as bool,
      day60: data['day60'] as bool,
      day61: data['day61'] as bool,
      day62: data['day62'] as bool,
      day63: data['day63'] as bool,
      day64: data['day64'] as bool,
      day65: data['day65'] as bool,
      day66: data['day66'] as bool,
      day67: data['day67'] as bool,
      day68: data['day68'] as bool,
      day69: data['day69'] as bool,
      day70: data['day70'] as bool,
      day71: data['day71'] as bool,
      day72: data['day72'] as bool,
      day73: data['day73'] as bool,
      day74: data['day74'] as bool,
      day75: data['day75'] as bool,
      day76: data['day76'] as bool,
      day77: data['day77'] as bool,
      day78: data['day78'] as bool,
      day79: data['day79'] as bool,
      day80: data['day80'] as bool,
      day81: data['day81'] as bool,
      day82: data['day82'] as bool,
      day83: data['day83'] as bool,
      day84: data['day84'] as bool,
      day85: data['day85'] as bool,
      day86: data['day86'] as bool,
      day87: data['day87'] as bool,
      day88: data['day88'] as bool,
      day89: data['day89'] as bool,
      day90: data['day90'] as bool,
    );
  }
}

class goal30History {
  goal30History({
    required this.goalHistoryId,
    required this.day,
    required this.bmi,
    required this.username,
    required this.lenght,
    required this.endTime,
    required this.startTime,
    required this.location,
    required this.timer,
    required this.totalDistance,
    required this.avgSpeed,
    required this.travelDistance,
  });
  final String goalHistoryId;
  final int day;
  final int lenght;
  final String bmi;
  final String username;
  final Timestamp endTime;
  final Timestamp startTime;
  final String location;
  final String timer;
  final String totalDistance;
  final double avgSpeed;
  final String travelDistance;

  factory goal30History.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;

    return goal30History(
      goalHistoryId: data['goalHistoryId'] as String,
      day: data['day'] as int,
      username: data['username'] as String,
      lenght: data['lenght'] as int,
      bmi: data['bmi'] as String,
      startTime: data['startTime'] as Timestamp,
      endTime: data['endTime'] as Timestamp,
      location: data['location'] as String,
      timer: data['timer'] as String,
      totalDistance: data['totalDistance'] as String,
      avgSpeed: data['avgSpeed'] as double,
      travelDistance: data['travelDistance'] as String,
    );
  }
}

class BMI {
  final int day;
  final String yourCategory;
  final double kmGoal;

  BMI({
    required this.day,
    required this.yourCategory,
    required this.kmGoal,
  });
}
