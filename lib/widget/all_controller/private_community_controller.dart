import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ta_rides/models/community_info.dart';

class PrivateCommunityController extends ChangeNotifier {
  late List<IfPrivate> private = <IfPrivate>[];
  bool isLoading = false;

  void getPrivate(String communityId) async {
    isLoading = true;
    notifyListeners();

    final rulesQuerySnapshot = await FirebaseFirestore.instance
        .collection('private_AddQuestion')
        .where('privateCommunityId', isEqualTo: communityId)
        .get();

    if (rulesQuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('No private found');
    }

    private = rulesQuerySnapshot.docs.map((snapshot) {
      return IfPrivate.fromDocument(snapshot);
    }).toList();

    isLoading = false;
    notifyListeners();
  }
}
