import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ta_rides/models/report_info..dart';

class ReportController extends ChangeNotifier {
  bool isLoading = false;
  List<Reports>? reports;

  void getReport() async {
    print('naka sud bas user post?');
    isLoading = true;
    notifyListeners();

    final reportsQuerySnapshot = await FirebaseFirestore.instance
        .collection('report')
        .orderBy('timeReported', descending: true)
        .get();

    if (reportsQuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('No report found');
    }

    reports = reportsQuerySnapshot.docs.map((snapshot) {
      return Reports.fromDocument(snapshot);
    }).toList();

    isLoading = false;
    notifyListeners();
  }
}
