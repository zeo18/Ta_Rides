import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ta_rides/models/rides_info.dart';

class RidesController extends ChangeNotifier {
  late List<Rides> rides = <Rides>[];
  late Rides ride;
  bool isLoading = false;

  void getRides(String communityId) async {
    isLoading = true;
    notifyListeners();

    final rulesQuerySnapshot = await FirebaseFirestore.instance
        .collection('rides')
        .where('communityId', isEqualTo: communityId)
        .get();

    if (rulesQuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('No rides found');
    }

    rides = rulesQuerySnapshot.docs.map((snapshot) {
      return Rides.fromDocument(snapshot);
    }).toList();

    isLoading = false;
    notifyListeners();
  }

  void getUserRide(String username) async {
    isLoading = true;
    notifyListeners();

    final rideQuerySnapshot = await FirebaseFirestore.instance
        .collection('rides')
        .where('userUsername', isEqualTo: username)
        .get();

    if (rideQuerySnapshot.docs.isEmpty) {
      // isLoading = false;
      // notifyListeners();
      // throw Exception('No ride found');

      final rideQuerySnapshot = await FirebaseFirestore.instance
          .collection('rides')
          .where('enemyUsername', isEqualTo: username)
          .get();

      final documentSnapshot = rideQuerySnapshot.docs.first;
      ride = Rides.fromDocument(documentSnapshot);
      isLoading = false;
      notifyListeners();
    } else {
      if (rideQuerySnapshot.docs.isNotEmpty) {
        final documentSnapshot = rideQuerySnapshot.docs.first;
        ride = Rides.fromDocument(documentSnapshot);
        isLoading = false;
        notifyListeners();
      }
    }
    isLoading = false;
    notifyListeners();
  }
}
