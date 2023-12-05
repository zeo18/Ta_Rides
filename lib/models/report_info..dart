import 'package:cloud_firestore/cloud_firestore.dart';

class Reports {
  Reports({
    required this.reportId,
    required this.postId,
    required this.userNameReport,
    required this.userfirstnameReport,
    required this.userlastnameReport,
    required this.userImageReported,
    required this.userfirstnameReported,
    required this.userlastnameReported,
    required this.userUsernameReported,
    required this.caption,
    required this.time,
    required this.timeReported,
  });

  final String reportId;
  final String postId;
  final String userNameReport;
  final String userfirstnameReport;
  final String userlastnameReport;
  final String userImageReported;
  final String userfirstnameReported;
  final String userlastnameReported;
  final String userUsernameReported;
  final String caption;
  final Timestamp time;
  final Timestamp timeReported;

  factory Reports.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;
    return Reports(
      reportId: data['reportId'] as String? ?? '',
      userNameReport: data['userNameReport'] as String? ?? '',
      postId: data['postId'] as String? ?? '',
      userfirstnameReport: data['userfirstnameReport'] as String? ?? '',
      userlastnameReport: data['userlastnameReport'] as String? ?? '',
      userImageReported: data['userImageReported'] as String? ?? '',
      userfirstnameReported: data['userfirstnameReported'] as String? ?? '',
      userlastnameReported: data['userlastnameReported'] as String? ?? '',
      userUsernameReported: data['userUsernameReported'] as String? ?? '',
      caption: data['caption'] as String? ?? '',
      time: data['time'] as Timestamp? ?? Timestamp.now(),
      timeReported: data['timeReported'] as Timestamp? ?? Timestamp.now(),
    );
  }
}
