import 'package:cloud_firestore/cloud_firestore.dart';

class RequestMember {
  final String requestId;
  final String lastName;
  final String firstName;
  final String userImage;
  final String userName;
  final String communityId;

  RequestMember({
    required this.requestId,
    required this.lastName,
    required this.firstName,
    required this.userImage,
    required this.userName,
    required this.communityId,
  });

  factory RequestMember.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;
    return RequestMember(
      requestId: data['requestId'] as String,
      lastName: data['lastName'] as String,
      firstName: data['firstName'] as String,
      communityId: data['communityId'] as String,
      userImage: data['userImage'] as String,
      userName: data['userName'] as String,
    );
  }
}
