import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Rides {
  Rides({
    required this.ridesID,
    required this.communityId,
    required this.communityImage,
    required this.communitytitle,
    required this.timePost,
    required this.userFirstname,
    required this.userLastname,
    required this.userImage,
    required this.userUsername,
    required this.caption,
    required this.userCommunityId,
    required this.userWinner,
    required this.isEnemy,
    required this.enemyFirstname,
    required this.enemyLastname,
    required this.enemyImage,
    required this.enemyUsername,
    required this.enemyCommunityId,
    required this.enemyCommunityTitle,
    required this.enemyCommunityImage,
    required this.distance,
    required this.userStopwatch,
    required this.userDistanceString,
    required this.userStartTime,
    required this.userEndTime,
    required this.enemyWinner,
    required this.enemyStopwatch,
    required this.enemyDistanceString,
    required this.enemyStartTime,
    required this.enemyEndTime,
    required this.userStart,
    required this.userFinished,
    required this.enemyStart,
    required this.enemyFinished,
    required this.isUser,
    required this.enemyJoined,
  });
  final String ridesID;
  final String caption;
  final double distance;
  final String userCommunityId;
  final String communityId;
  final String communityImage;
  final String communitytitle;

  final String userFirstname;
  final String userLastname;
  final String userImage;
  final String userUsername;

  final String userStopwatch;
  final String userDistanceString;
  final Timestamp userStartTime;
  final Timestamp userEndTime;

  final bool isUser;
  final Timestamp timePost;
  final bool userWinner;
  final bool enemyWinner;

  final Timestamp enemyJoined;
  final bool isEnemy;
  final String enemyFirstname;
  final String enemyLastname;
  final String enemyImage;
  final String enemyUsername;
  final String enemyCommunityId;
  final String enemyCommunityTitle;
  final String enemyCommunityImage;

  final String enemyStopwatch;
  final String enemyDistanceString;
  final Timestamp enemyStartTime;
  final Timestamp enemyEndTime;

  final bool userStart;
  final bool userFinished;
  final bool enemyStart;
  final bool enemyFinished;

  factory Rides.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;
    return Rides(
      ridesID: data['ridesID'] as String,
      caption: data['caption'] as String,
      distance: data['distance'] as double,
      isUser: data['isUser'] as bool,
      userCommunityId: data['userCommunityId'] as String,
      communityId: data['communityId'] as String,
      communityImage: data['communityImage'] as String,
      communitytitle: data['communitytitle'] as String,
      timePost: data['timePost'] as Timestamp,
      userFirstname: data['userFirstname'] as String,
      userLastname: data['userLastname'] as String,
      userImage: data['userImage'] as String,
      userUsername: data['userUsername'] as String,
      userWinner: data['userWinner'] as bool,
      isEnemy: data['isEnemy'] as bool,
      enemyFirstname: data['enemyFirstname'] as String,
      enemyLastname: data['enemyLastname'] as String,
      enemyImage: data['enemyImage'] as String,
      enemyUsername: data['enemyUsername'] as String,
      enemyCommunityId: data['enemyCommunityId'] as String,
      enemyCommunityTitle: data['enemyCommunityTitle'] as String,
      enemyCommunityImage: data['enemyCommunityImage'] as String,
      userStopwatch: data['userStopwatch'] as String,
      userDistanceString: data['userDistanceString'] as String,
      userStartTime: data['userStartTime'] as Timestamp,
      userEndTime: data['userEndTime'] as Timestamp,
      enemyWinner: data['enemyWinner'] as bool,
      enemyStopwatch: data['enemyStopwatch'] as String,
      enemyDistanceString: data['enemyDistanceString'] as String,
      enemyStartTime: data['enemyStartTime'] as Timestamp,
      enemyEndTime: data['enemyEndTime'] as Timestamp,
      enemyJoined: data['enemyJoined'] as Timestamp,
      userStart: data['userStart'] as bool,
      userFinished: data['userFinished'] as bool,
      enemyStart: data['enemyStart'] as bool,
      enemyFinished: data['enemyFinished'] as bool,
    );
  }
}
