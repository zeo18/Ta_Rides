import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ta_rides/models/pedal_info.dart';
import 'package:ta_rides/models/user_info.dart';

class PedalController extends ChangeNotifier {
  bool isLoading = false;
  late List<Pedal> pedal = <Pedal>[];
  late Users user;

  void getPedal(String email) async {
    isLoading = true;
    notifyListeners();

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('User not found');
    }

    final documentSnapshot = querySnapshot.docs.first;
    user = Users.fromDocument(documentSnapshot);

    isLoading = false;
    notifyListeners();

    final pedalQuerySnapshot = await FirebaseFirestore.instance
        .collection('pedal')
        .where('username', isEqualTo: user.username)
        .get();

    if (pedalQuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('No pedal found');
    }

    pedal = pedalQuerySnapshot.docs.map((snapshot) {
      return Pedal.fromDocument(snapshot);
    }).toList();

    isLoading = false;
    notifyListeners();
  }
}
