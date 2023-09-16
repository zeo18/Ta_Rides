import 'package:flutter/foundation.dart';
import 'package:ta_rides/models/user_info.dart';

class Community {
  Community({
    required this.title,
    required this.coverImage,
    required this.private,
    required this.description,
    required this.membersIndex,
    required this.members,
    required this.image,
    required this.id,
    required this.ifItsImage,
  });
  final int id;
  final String coverImage;
  final bool private;
  final String title;
  final String description;
  final int membersIndex;
  final List<Users> members;
  late final Uint8List ifItsImage;
  final String image;
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
    required this.commentNumber,
    required this.heart,
    required this.ifImage,
  });
  final int postId;
  final int communityId;
  final int userId;
  final bool isImage;
  final String imagePost;
  final String usersName;
  final String caption;
  late int heart;
  final int commentNumber;
  final List<String> commment;
  late final Uint8List ifImage;
}

class Comment {
  Comment({
    required this.postId,
    required this.comment,
    required this.usersName,
    required this.userImage,
  });
  final int postId;
  final String comment;
  final String usersName;
  final String userImage;
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
  });
  final int privateCommunityId;
  final String choiceQuestion;
  final List<String> choices;
  final String cheboxesQuestion;
  final List<String> cheboxes;
  final String writtenQuestion;
  final String writtenAnswer;
  final String writeRules;
  final String detailsRules;
}
