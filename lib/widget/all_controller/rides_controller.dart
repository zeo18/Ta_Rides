import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ta_rides/models/rides_info.dart';

class RidesController extends ChangeNotifier {
  late List<Rides> rides = <Rides>[];
  late List<Rides> rider = <Rides>[];
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

  void getUserRide(String ridesID) async {
    isLoading = true;
    notifyListeners();

    final rideQuerySnapshot = await FirebaseFirestore.instance
        .collection('rides')
        .where('ridesID', isEqualTo: ridesID)
        .get();

    if (rideQuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('No ride found');
    }

    final documentSnapshot = rideQuerySnapshot.docs.first;
    ride = Rides.fromDocument(documentSnapshot);
    isLoading = false;
    notifyListeners();
  }

  void getUserChallenge(String username) async {
    isLoading = true;
    notifyListeners();

    final rideQuerySnapshot = await FirebaseFirestore.instance
        .collection('rides')
        .where('userUsername', isEqualTo: username)
        .where('isEnemy', isEqualTo: true)
        .get();

    if (rideQuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('No ride found');
    }

    rider = rideQuerySnapshot.docs.map((snapshot) {
      return Rides.fromDocument(snapshot);
    }).toList();

    isLoading = false;
    notifyListeners();
  }
}