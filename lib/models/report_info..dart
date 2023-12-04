import 'package:cloud_firestore/cloud_firestore.dart';

class Reports {
  Reports({
    required this.reportId,
    required this.userNameReport,
    required this.userReported,
  });

  final String reportId;
  final String userNameReport;
  final String userReported;

  factory Reports.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;
    return Reports(
      reportId: data['reportId'] as String? ?? '',
      userNameReport: data['userNameReport'] as String? ?? '',
      userReported: data['userReported'] as String? ?? '',
    );
  }
}
