class Users {
  const Users({
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
  });

  final int id;
  final String userImage;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime birthdate; //DateTime
  final String gender;
  final String location;
  final String phoneNumber;
  final int followers;
  final int following;
  final bool isCommunity;
  final int communityId;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userImage': userImage,
      'username': username,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'birthdate': birthdate.toIso8601String(),
      'gender': gender,
      'location': location,
      'phoneNumber': phoneNumber,
      'followers': followers,
      'following': following,
      'isCommunity': isCommunity,
      'communityId': communityId,
    };
  }
}

class Achievements {
  Achievements({
    required this.isMedal1,
    required this.isMedal2,
    required this.isMedal3,
    required this.isMedal4,
    required this.isMedal5,
    required this.isMedal6,
  });
  final bool isMedal1;
  final bool isMedal2;
  final bool isMedal3;
  final bool isMedal4;
  final bool isMedal5;
  final bool isMedal6;
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
