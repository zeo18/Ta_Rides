import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ta_rides/models/rides_info.dart';

class RidesController extends ChangeNotifier {
  late List<Rides> rides = <Rides>[];
  late List<Rides> rider = <Rides>[];
  late List<Rides> allRides = <Rides>[];
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

    rides.sort((a, b) => a.timePost.compareTo(b.timePost));

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

  void getAllRides() async {
    isLoading = true;
    notifyListeners();

    final ridesQuerySnapshot = await FirebaseFirestore.instance
        .collection('rides')
        .where('isEnemy', isEqualTo: true)
        .get();

    if (ridesQuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('No rides found');
    }

    allRides = ridesQuerySnapshot.docs.map((snapshot) {
      return Rides.fromDocument(snapshot);
    }).toList();

    isLoading = false;
    notifyListeners();
  }
}
