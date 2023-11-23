import 'package:cloud_firestore/cloud_firestore.dart';

class Pedal {
  Pedal({
    required this.pedalId,
    required this.username,
    required this.time,
    required this.stopwatch,
    required this.totalDistance,
    required this.avgSpeed,
    required this.distance,
  });

  final String pedalId;
  final String username;
  final Timestamp time;
  final Stopwatch stopwatch;
  final double totalDistance;
  final double avgSpeed;
  final String distance;

  factory Pedal.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;
    return Pedal(
      pedalId: data['pedalId'] as String,
      username: data['username'] as String,
      time: data['time'] as Timestamp,
      stopwatch: data['stopwatch'] as Stopwatch,
      totalDistance: data['totalDistance'] as double,
      avgSpeed: data['avgSpeed'] as double,
      distance: data['distance'] as String,
    );
  }
}
