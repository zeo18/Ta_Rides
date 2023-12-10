import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ta_rides/models/request.dart';

class RequestController extends ChangeNotifier {
  late final String requestId;
  late final String email;
  bool isLoading = false;
  late List<RequestMember> request = <RequestMember>[];

  void setRequestId(String requestId) {
    this.requestId = requestId;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void getRequest(String communityId) async {
    print('naka sud bas request?');
    isLoading = true;
    notifyListeners();

    final querySnapshot = await FirebaseFirestore.instance
        .collection('request')
        .where('communityId', isEqualTo: communityId)
        .get();

    if (querySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('Request not found');
    }

    request = querySnapshot.docs.map((snapshot) {
      return RequestMember.fromDocument(snapshot);
    }).toList();

    isLoading = false;
    notifyListeners();
  }
}
