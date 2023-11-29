import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Rides {
  Rides({
    required this.ridesID,
    required this.caption,
    required this.distance,
    required this.userCommunityId,
    required this.communityId,
    required this.communityImage,
    required this.communitytitle,
    required this.userFirstname,
    required this.userLastname,
    required this.userImage,
    required this.userUsername,
    required this.isUser,
    required this.timePost,
    required this.userWinner,
    required this.enemyWinner,
    required this.enemyJoined,
    required this.isEnemy,
    required this.enemyFirstname,
    required this.enemyLastname,
    required this.enemyImage,
    required this.enemyUsername,
    required this.enemyCommunityId,
    required this.enemyCommunityTitle,
    required this.enemyCommunityImage,
    required this.userStart,
    required this.userFinished,
    required this.enemyStart,
    required this.enemyFinished,
    required this.userLat,
    required this.userLng,
    required this.enemyLat,
    required this.enemyLng,
    required this.startLat,
    required this.startLng,
    required this.midLat,
    required this.midLng,
    required this.endLat,
    required this.endLng,
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

  final bool userStart;
  final bool userFinished;
  final bool enemyStart;
  final bool enemyFinished;

  final double userLat;
  final double userLng;
  final double enemyLat;
  final double enemyLng;

  final double startLat;
  final double startLng;
  final double midLat;
  final double midLng;
  final double endLat;
  final double endLng;

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
      enemyWinner: data['enemyWinner'] as bool,
      enemyJoined: data['enemyJoined'] as Timestamp,
      userStart: data['userStart'] as bool,
      userFinished: data['userFinished'] as bool,
      enemyStart: data['enemyStart'] as bool,
      enemyFinished: data['enemyFinished'] as bool,
      userLat: data['userLat'] as double,
      userLng: data['userLng'] as double,
      enemyLat: data['enemyLat'] as double,
      enemyLng: data['enemyLng'] as double,
      startLat: data['startLat'] as double,
      startLng: data['startLng'] as double,
      midLat: data['midLat'] as double,
      midLng: data['midLng'] as double,
      endLat: data['endLat'] as double,
      endLng: data['endLng'] as double,
    );
  }
}
