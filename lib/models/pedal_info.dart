import 'package:cloud_firestore/cloud_firestore.dart';

class Pedal {
  Pedal({
    required this.pedalId,
    required this.username,
    required this.endTime,
    required this.totalDistance,
    required this.avgSpeed,
    required this.travelDistance,
    required this.startTime,
    required this.location,
    required this.timer,
  });

  final String pedalId;
  final String username;
  final Timestamp endTime;
  final Timestamp startTime;
  final String location;
  final String timer;
  final String totalDistance;
  final double avgSpeed;
  final String travelDistance;

  factory Pedal.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() as Map<String, dynamic>;
    return Pedal(
      pedalId: data['pedalId'] as String,
      username: data['username'] as String,
      startTime: data['startTime'] as Timestamp,
      endTime: data['endTime'] as Timestamp,
      location: data['location'] as String,
      timer: data['timer'] as String,
      totalDistance: data['totalDistance'] as String,
      avgSpeed: data['avgSpeed'] as double,
      travelDistance: data['travelDistance'] as String,
    );
  }
}
