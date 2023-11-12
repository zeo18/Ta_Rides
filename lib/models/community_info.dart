import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ta_rides/models/user_info.dart';

class Community {
  Community({
    required this.title,
    required this.coverImage,
    required this.private,
    required this.description,
    required this.members,
    required this.id,
  });
  final String id; //
  final String coverImage; //
  final bool private; //
  final String title; //
  final String description; //
  final List<String> members; //

  factory Community.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;
    final List<dynamic> membersData = data['members'] ?? [];
    final List<String> members = membersData.map((memberData) {
      return memberData as String;
    }).toList();
    return Community(
      id: data['id'] as String,
      coverImage: data['coverImage'] as String,
      private: data['private'] as bool,
      title: data['title'] as String,
      description: data['description'] as String,
      members: members,
    );
  }
}

class Post {
  Post({
    required this.postId,
    required this.communityId,
    required this.userId,
    required this.isImage,
    required this.imagePost,
    required this.usersName,
    required this.caption,
    required this.commment,
    required this.heart,
    required this.isHeart,
    required this.timestamp,
  });
  final String postId;
  final String communityId;
  final String userId;
  final bool isImage;
  final String imagePost;
  final String usersName;
  final String caption;
  late List<String> heart;
  final List<String> commment;
  final Timestamp timestamp;
  late bool isHeart;

  factory Post.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;
    final List<dynamic> commentData = data['comment'] ?? [];
    final List<String> comments = commentData.map((comment) {
      return comment as String;
    }).toList();
    final List<dynamic> heartData = data['heart'] ?? [];
    final List<String> hearts = heartData.map((heart) {
      return heart as String;
    }).toList();
    return Post(
      postId: data['postId'] as String,
      communityId: data['communityId'] as String,
      userId: data['userId'] as String,
      isImage: data['isImage'] as bool,
      imagePost: data['imagePost'] as String,
      usersName: data['usersName'] as String,
      caption: data['caption'] as String,
      commment: comments,
      heart: hearts,
      isHeart: data['isHeart'] as bool,
      timestamp: data['timestamp'] as Timestamp,
    );
  }
}

class Comment {
  Comment({
    required this.postId,
    required this.comment,
    required this.usersName,
    required this.userImage,
    required this.timestamp,
    required this.firstName,
    required this.lastName,
  });
  final String firstName;
  final String lastName;
  final String postId;
  final String comment;
  final String usersName;
  final String userImage;
  final Timestamp timestamp;

  factory Comment.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;
    return Comment(
      postId: data['postId'] as String,
      comment: data['comment'] as String,
      usersName: data['usersName'] as String,
      userImage: data['userImage'] as String,
      timestamp: data['timestamp'] as Timestamp,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
    );
  }
}

class IfPrivate {
  IfPrivate({
    required this.privateCommunityId,
    required this.choiceQuestion,
    required this.choices,
    required this.cheboxesQuestion,
    required this.cheboxes,
    required this.writtenQuestion,
    required this.writtenAnswer,
    required this.writeRules,
    required this.detailsRules,
    required this.cheboxesAnswer,
    required this.choicesAnswer,
  });

  final String privateCommunityId;
  final String choiceQuestion;
  final List<String> choices;
  final String choicesAnswer;
  final String cheboxesQuestion;
  final List<String> cheboxes;
  final List<String> cheboxesAnswer;
  final String writtenQuestion;
  final String writtenAnswer;
  final String writeRules;
  final String detailsRules;

  factory IfPrivate.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;
    final List<dynamic> choicesData = data['choices'] ?? [];
    final List<String> choices = choicesData.map((choice) {
      return choice as String;
    }).toList();

    final List<dynamic> cheboxesData = data['cheboxes'] ?? [];
    final List<String> cheboxes = cheboxesData.map((chebox) {
      return chebox as String;
    }).toList();

    final List<dynamic> cheboxesAnswerData = data['cheboxesAnswer'] ?? [];
    final List<String> cheboxesAnswer = cheboxesAnswerData.map((answer) {
      return answer as String;
    }).toList();

    return IfPrivate(
      privateCommunityId: data['privateCommunityId'] as String,
      choiceQuestion: data['choiceQuestion'] as String,
      choices: choices,
      choicesAnswer: data['choicesAnswer'] as String,
      cheboxesQuestion: data['cheboxesQuestion'] as String,
      cheboxes: cheboxes,
      cheboxesAnswer: cheboxesAnswer,
      writtenQuestion: data['writtenQuestion'] as String,
      writtenAnswer: data['writtenAnswer'] as String,
      writeRules: data['writeRules'] as String,
      detailsRules: data['detailsRules'] as String,
    );
  }
}
