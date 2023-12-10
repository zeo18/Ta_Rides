import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ta_rides/models/directions_model.dart';
import 'package:ta_rides/models/real_location.dart';
import 'package:ta_rides/models/rides_info.dart';

class RealGoalRides extends StatefulWidget {
  const RealGoalRides({
    super.key,
    required this.ride,
    required this.email,
    required this.locationData,
    required this.isUser,
    required this.originIcon,
    required this.enemyIcon,
  });

  final Rides ride;
  final String email;
  final LocationData? locationData;
  final bool isUser;
  final Uint8List originIcon;
  final Uint8List enemyIcon;

  @override
  State<RealGoalRides> createState() => _RealGoalRidesState();
}

class _RealGoalRidesState extends State<RealGoalRides> {
  late GoogleMapController _googleController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Location location = Location();
  Location enemy = Location();
  Directions? _info;
  Directions? _info1;
  Marker? _origin;
  Marker? _enemy;
  Marker? _fistPoint;
  Marker? _secondPoint;
  Marker? _thirdPoint;

  @override
  void initState() {
    super.initState();

    location = Location();
    enemy = Location();
    try {
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

          _origin = Marker(
            markerId: const MarkerId('currentLocation'),
            position:
                LatLng(currentLocation.latitude!, currentLocation.longitude!),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          );
        });
      } else {
        location.onLocationChanged.listen((LocationData enemyLocation) {
          print(
              'Enemy location: ${enemyLocation.latitude}, ${enemyLocation.longitude}');
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

          _enemy = Marker(
            markerId: const MarkerId('enemyLocation'),
            position: LatLng(enemyLocation.latitude!, enemyLocation.longitude!),
          );
        });
      }
    } catch (e) {
      print(e);
    }
  }

  LatLngBounds _calculateBounds() {
    final LatLngBounds bounds;
    if (_info != null && _info1 != null) {
      // Both _info and _info1 are not null
      bounds = LatLngBounds(
        southwest: LatLng(
          min(_info!.bounds.southwest.latitude,
              _info1!.bounds.southwest.latitude),
          min(_info!.bounds.southwest.longitude,
              _info1!.bounds.southwest.longitude),
        ),
        northeast: LatLng(
          max(_info!.bounds.northeast.latitude,
              _info1!.bounds.northeast.latitude),
          max(_info!.bounds.northeast.longitude,
              _info1!.bounds.northeast.longitude),
        ),
      );
    } else if (_info != null) {
      // Only _info is not null
      bounds = _info!.bounds;
    } else if (_info1 != null) {
      // Only _info1 is not null
      bounds = _info1!.bounds;
    } else {
      // Both _info and _info1 are null
      bounds = LatLngBounds(
        southwest: LatLng(
          widget.locationData!.latitude ?? 10.2899758,
          widget.locationData!.longitude ?? 123.861891,
        ),
        northeast: LatLng(
          widget.locationData!.latitude ?? 10.2899758,
          widget.locationData!.longitude ?? 123.861891,
        ),
      );
    }
    return bounds;
  }

  void _addMarker(LatLng position) async {
    if (_fistPoint == null ||
        (_fistPoint != null && _secondPoint != null && _thirdPoint != null)) {
      _fistPoint = Marker(
        markerId: const MarkerId('fistPoint'),
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );

      _info = null;
      _secondPoint = null;
      _thirdPoint = null;
    } else if (_secondPoint == null) {
      _secondPoint = Marker(
        markerId: const MarkerId('secondPoint'),
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
      final directions = await DirectionsRespository()
          .getDirection(orgin: _fistPoint!.position, destination: position);
      setState(() => _info = directions);
      _info1 = null;
      _thirdPoint = null;
    } else {
      _thirdPoint = Marker(
        markerId: const MarkerId('thirdPoint'),
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
      final direction2 = await DirectionsRespository()
          .getDirection(orgin: _secondPoint!.position, destination: position);
      setState(() => _info1 = direction2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x3fff0C0D11),
      appBar: AppBar(
        backgroundColor: Color(0x3fff0C0D11),
        actions: [
          const Icon(Icons.place, color: Colors.lightGreen),
          TextButton(
            onPressed: () {
              _googleController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _fistPoint!.position,
                    zoom: 14.4746,
                    tilt: 0.0,
                  ),
                ),
              );
            },
            onLongPress: () {
              _googleController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _fistPoint!.position,
                    zoom: 18.4746,
                    tilt: 50.0,
                  ),
                ),
              );
            },
            child: Text(
              'START POINT',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
            ),
          ),
          const Icon(Icons.place, color: Colors.lightBlue),
          if (_secondPoint != null)
            TextButton(
              onPressed: () {
                _googleController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _secondPoint!.position,
                      zoom: 14.4746,
                      tilt: 0.0,
                    ),
                  ),
                );
              },
              onLongPress: () {
                _googleController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _secondPoint!.position,
                      zoom: 18.4746,
                      tilt: 50.0,
                    ),
                  ),
                );
              },
              child: Text(
                'SECOND POINT',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
              ),
            )
          else
            TextButton(
              onPressed: () {},
              child: Text(
                'SECOND POINT',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
              ),
            ),
          const Icon(Icons.place, color: Colors.redAccent),
          if (_secondPoint != null)
            TextButton(
              onPressed: () {
                _googleController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _thirdPoint!.position,
                      zoom: 14.4746,
                      tilt: 0.0,
                    ),
                  ),
                );
              },
              onLongPress: () {
                _googleController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _thirdPoint!.position,
                      zoom: 18.4746,
                      tilt: 50.0,
                    ),
                  ),
                );
              },
              child: Text(
                'END POINT',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
              ),
            )
          else
            TextButton(
              onPressed: () {},
              child: Text(
                'END POINT',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
              ),
            ),
        ],
      ),
      floatingActionButton: Padding(
        padding:
            const EdgeInsets.only(bottom: 90.0, right: 0.0), // adjust as needed
        child: Container(
          height: 40.0,
          width: 40.0,
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(181, 255, 255, 255),
            onPressed: () {
              final bounds = _calculateBounds();
              _googleController.animateCamera(bounds != null
                  ? CameraUpdate.newLatLngBounds(bounds, 100.0)
                  : CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(
                            widget.locationData!.latitude ?? 10.2899758,
                            widget.locationData!.longitude ?? 123.861891),
                        zoom: 20.4746,
                      ),
                    ));
            },
            child: const Icon(Icons.location_searching,
                size: 20.0), // adjust icon size as needed
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('rides')
            .where('ridesID', isEqualTo: widget.ride.ridesID)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          Set<Marker> markers = {};

          for (var doc in snapshot.data!.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            LatLng position = LatLng(
                data['userLat'] ?? 10.2899758, data['userLng'] ?? 123.861891);
            LatLng enemy = LatLng(
                data['enemyLat'] ?? 10.2899758, data['enemyLng'] ?? 123.861891);

            markers.add(Marker(
                markerId: const MarkerId('currentLocation'),
                position: position,
                icon: BitmapDescriptor.fromBytes(widget.originIcon)));

            markers.add(Marker(
                markerId: const MarkerId('enemyLocation'),
                position: enemy,
                icon: BitmapDescriptor.fromBytes(widget.enemyIcon)));
          }

          return Stack(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              LatLng position = LatLng(
                  data['userLat'] ?? 10.2899758, data['userLng'] ?? 123.861891);
              LatLng enemy = LatLng(data['enemyLat'] ?? 10.2899758,
                  data['enemyLng'] ?? 123.861891);

              _origin = Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: position,
                  icon: BitmapDescriptor.fromBytes(widget.originIcon));

              _enemy = Marker(
                  markerId: const MarkerId('enemyLocation'),
                  position: enemy,
                  icon: BitmapDescriptor.fromBytes(widget.enemyIcon));

              return Stack(
                children: [
                  GoogleMap(
                    myLocationEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _googleController = controller;
                      // _controller.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                      target: position,
                      zoom: 14.4746,
                    ),
                    markers: {
                      if (_origin != null) _origin!,
                      if (_enemy != null) _enemy!,
                      if (_fistPoint != null) _fistPoint!,
                      if (_secondPoint != null) _secondPoint!,
                      if (_thirdPoint != null) _thirdPoint!,
                    },
                    onLongPress: _addMarker,
                  ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Container(
                      height: 100,
                      width: 200,
                      color: Color(0x3fff0C0D11),
                      child: Column(
                        children: [
                          if (_info != null)
                            Text(
                              '${_info!.totalDistance}, ${_info!.totalDuration}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                            ),
                          if (_info1 != null)
                            Text(
                              '${_info1!.totalDistance}, ${_info1!.totalDuration}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
