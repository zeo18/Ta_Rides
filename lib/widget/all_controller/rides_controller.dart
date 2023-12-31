import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ta_rides/models/rides_info.dart';

class RidesController extends ChangeNotifier {
  late List<Rides> rides = <Rides>[];
  late List<Rides> finishRides = <Rides>[];
  late List<Rides> allFinishRides = <Rides>[];
  late List<Rides> userFinishRides = <Rides>[];
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
        .where('enemyFinished', isEqualTo: false)
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

  void getAllFinishedRides() async {
    isLoading = true;
    notifyListeners();

    final rulesQuerySnapshot = await FirebaseFirestore.instance
        .collection('rides')
        .where('enemyFinished', isEqualTo: true)
        .get();

    if (rulesQuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('No rides found');
    }

    allFinishRides = rulesQuerySnapshot.docs.map((snapshot) {
      return Rides.fromDocument(snapshot);
    }).toList();

    allFinishRides.sort((a, b) => b.timePost.compareTo(a.timePost));

    isLoading = false;
    notifyListeners();
  }

  void getFinishedRides(String communityId) async {
    isLoading = true;
    notifyListeners();

    final rulesQuerySnapshot = await FirebaseFirestore.instance
        .collection('rides')
        .where('communityId', isEqualTo: communityId)
        .where('enemyFinished', isEqualTo: true)
        .get();

    if (rulesQuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('No rides found');
    }

    finishRides = rulesQuerySnapshot.docs.map((snapshot) {
      return Rides.fromDocument(snapshot);
    }).toList();

    finishRides.sort((a, b) => b.timePost.compareTo(a.timePost));

    isLoading = false;
    notifyListeners();
  }

  void getUserFinishedRides(String username) async {
    isLoading = true;
    notifyListeners();

    final rulesQuerySnapshot = await FirebaseFirestore.instance
        .collection('rides')
        .where('userUsername', isEqualTo: username)
        .where('enemyFinished', isEqualTo: true)
        .get();

    if (rulesQuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('No rides found');
    }

    userFinishRides = rulesQuerySnapshot.docs.map((snapshot) {
      return Rides.fromDocument(snapshot);
    }).toList();

    finishRides.sort((a, b) => b.timePost.compareTo(a.timePost));

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
        .where('enemyFinished', isEqualTo: false)
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
