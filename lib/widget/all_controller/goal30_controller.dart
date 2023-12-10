import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ta_rides/models/goal30_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/goal30/goal_history.dart';

class Goal30Controller extends ChangeNotifier {
  bool isLoading = false;
  late Goal30 goal30;
  late List<goal30History> goal30Histories = <goal30History>[];

  getUserGoal30(String username) async {
    isLoading = true;
    notifyListeners();

    final goal30QuerySnapshot = await FirebaseFirestore.instance
        .collection('goal30')
        .where('userName', isEqualTo: username)
        .get();

    if (goal30QuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('No goal30 found');
    }

    final goal30DocumentSnapshot = goal30QuerySnapshot.docs.first;
    goal30 = Goal30.fromDocument(goal30DocumentSnapshot);
    isLoading = false;
    notifyListeners();
  }

  getGoal30History(String username, int day, int lenght) async {
    isLoading = true;
    notifyListeners();

    final goal30QuerySnapshot = await FirebaseFirestore.instance
        .collection('goal30History')
        .where('username', isEqualTo: username)
        .where('day', isEqualTo: day)
        .where('lenght', isEqualTo: lenght)
        .get();

    if (goal30QuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('No goal30 found');
    }

    goal30Histories = goal30QuerySnapshot.docs.map((snapshot) {
      return goal30History.fromDocument(snapshot);
    }).toList();

    isLoading = false;
    notifyListeners();
  }
}
