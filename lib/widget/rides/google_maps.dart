import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ta_rides/models/rides_info.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({
    super.key,
    required this.locationData,
    required this.ride,
    required this.isUser,
  });

  final Rides ride;
  final LocationData? locationData;
  final bool isUser;

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  Location location = Location();
  Location enemy = Location();
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    location = Location();
    enemy = Location();

    if (widget.isUser) {
      location.onLocationChanged.listen((LocationData currentLocation) {
        print(
            'Current location: ${currentLocation.latitude}, ${currentLocation.longitude}');
        FirebaseFirestore.instance
            .collection('rides')
            .where('ridesID', isEqualTo: widget.ride.ridesID)
            .get()
            .then((value) {
          value.docs.forEach(
            (element) {
              element.reference.update({
                'userLat': currentLocation.latitude,
                'userLng': currentLocation.longitude,
              });
            },
          );
        });

        markers.add(
          Marker(
            markerId: MarkerId('currentLocation'),
            position:
                LatLng(currentLocation.latitude!, currentLocation.longitude!),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
      });
    } else {
      location.onLocationChanged.listen((LocationData enemyLocation) {
        print(
            'Current location: ${enemyLocation.latitude}, ${enemyLocation.longitude}');
        FirebaseFirestore.instance
            .collection('rides')
            .where('ridesID', isEqualTo: widget.ride.ridesID)
            .get()
            .then((value) {
          value.docs.forEach(
            (element) {
              element.reference.update({
                'enemyLat': enemyLocation.latitude,
                'enemyLng': enemyLocation.longitude,
              });
            },
          );
        });

        markers.add(
          Marker(
            markerId: MarkerId('enemyLocation'),
            position: LatLng(enemyLocation.latitude!, enemyLocation.longitude!),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('rides')
            .where('ridesID', isEqualTo: widget.ride.ridesID)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Stack(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              LatLng position = LatLng(
                  data['userLat'] ?? 10.2899758, data['userLng'] ?? 123.861891);
              Set<Marker> markers = {};
              markers.add(
                Marker(
                  markerId: MarkerId('userLocation'),
                  position: position,
                ),
              );
              LatLng enemy = LatLng(data['enemyLat'] ?? 10.2899758,
                  data['enemyLng'] ?? 123.861891);

              markers.add(
                Marker(
                  markerId: MarkerId('enemyLocation'),
                  position: enemy,
                ),
              );
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: position,
                  zoom: 14.4746,
                ),
                markers: markers,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
