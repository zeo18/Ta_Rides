import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

enum Gender {
  male,
  female,
}

final formatter = DateFormat.yMd('MM/dd/yyyy');

class Users {
  Users({
    required this.id,
    required this.userImage,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthdate,
    required this.gender,
    required this.location,
    required this.phoneNumber,
    required this.followers,
    required this.following,
    required this.isCommunity,
    required this.communityId,
    required this.isAchievement,
    required this.chooseUserImage,
  });

  final int id;
  final String userImage;
  late final Uint8List chooseUserImage;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime birthdate; //DateTime
  final Gender gender;
  final String location;
  final String phoneNumber;
  final int followers;
  final int following;
  late bool isCommunity;
  final bool isAchievement;
  late int communityId;

  String get formattedDate {
    return formatter.format(birthdate);
  }
}

class Achievements {
  Achievements({
    required this.userName,
    required this.legendary,
    required this.newbie,
    required this.noSweat,
    required this.challenger,
    required this.calvesGoBrrr,
    required this.roadMaster,
  });
  final String userName;
  final bool legendary;
  final bool newbie;
  final bool noSweat;
  final bool challenger;
  final bool calvesGoBrrr;
  final bool roadMaster;

  static Achievements? defaultAchievement() {}
}

class Statistic {
  Statistic({
    required this.distance,
    required this.time,
    required this.elevationGain,
  });
  final int distance;
  final int time;
  final int elevationGain;
}

class Goal30 {
  Goal30({
    required this.distance,
    required this.time,
    required this.elevationGain,
  });
  final int distance;
  final int time;
  final int elevationGain;
}
// Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'userImage': userImage,
//       'username': username,
//       'password': password,
//       'firstName': firstName,
//       'lastName': lastName,
//       'email': email,
//       'birthdate': birthdate.toIso8601String(),
//       'gender': gender,
//       'location': location,
//       'phoneNumber': phoneNumber,
//       'followers': followers,
//       'following': following,
//       'isCommunity': isCommunity,
//       'communityId': communityId,
//     };
//   }