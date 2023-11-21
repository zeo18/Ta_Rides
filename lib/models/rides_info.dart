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
  });
  final String ridesID;
  final String caption;
  final String userCommunityId;
  final String communityId;
  final String communityImage;
  final String communitytitle;
  final Timestamp timePost;
  final String userFirstname;
  final String userLastname;
  final String userImage;
  final String userUsername;

  final bool userWinner;

  final bool isEnemy;
  final String enemyFirstname;
  final String enemyLastname;

  final String enemyImage;
  final String enemyUsername;
  final String enemyCommunityId;
  final String enemyCommunityTitle;
  final String enemyCommunityImage;

  // final Location enemyCurrent;
  // final Location userCurrent;

  // final Location enemyStart;
  // final Location userStart;
  // final Location finalEnd;

  factory Rides.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;
    return Rides(
      ridesID: data['ridesID'] as String,
      caption: data['caption'] as String,
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
    );
  }
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });
  final double lat;
  final double lng;
}
