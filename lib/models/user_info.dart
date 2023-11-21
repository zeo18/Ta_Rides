import 'package:cloud_firestore/cloud_firestore.dart';
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
  });

  final String id;
  final String userImage;
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
  late String communityId;

  String get formattedDate {
    return formatter.format(birthdate);
  }

  static Gender setGender(String gender) {
    return gender == "Gender.male" ? Gender.male : Gender.female;
  }

  factory Users.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;
    return Users(
      id: document.id,
      userImage: data['userImage'] as String? ?? '',
      username: data['username'] as String? ?? '',
      password: data['password'] as String? ?? '',
      firstName: data['firstName'] as String? ?? '',
      lastName: data['lastName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      birthdate: data['birthdate'] != null
          ? (data['birthdate'] as Timestamp).toDate()
          : DateTime.now(),
      gender: setGender(data['gender'] as String? ?? ''),
      location: data['location'] as String? ?? '',
      phoneNumber: data['phoneNumber'] as String? ?? '',
      followers: data['followers'] as int? ?? 0,
      following: data['following'] as int? ?? 0,
      isCommunity: data['isCommunity'] as bool? ?? false,
      communityId: data['communityId'] as String? ?? '0',
      isAchievement: data['isAchievement'] as bool? ?? false,
    );
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

  factory Achievements.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;
    return Achievements(
      userName: data['userName'] as String? ?? '',
      legendary: data['legendary'] as bool? ?? false,
      newbie: data['newbie'] as bool? ?? false,
      noSweat: data['noSweat'] as bool? ?? false,
      challenger: data['challenger'] as bool? ?? false,
      calvesGoBrrr: data['calvesGoBrrr'] as bool? ?? false,
      roadMaster: data['roadMaster'] as bool? ?? false,
    );
  }
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

// class Goal30 {
//   Goal30({
//     required this.distance,
//     required this.time,
//     required this.elevationGain,
//   });
//   final int distance;
//   final int time;
//   final int elevationGain;

//   static Goal30 fromDocument(QueryDocumentSnapshot<Map<String, dynamic>> goal30documentSnapshot) {}
// }
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