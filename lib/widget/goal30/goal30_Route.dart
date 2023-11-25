import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ta_rides/models/location_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'dart:async';

import 'package:ta_rides/widget/all_controller/location_controller.dart';

class Goal30Route extends StatefulWidget {
  Goal30Route({
    super.key,
    required this.selectPinPoint,
    required this.selectPinPoint2,
    required this.pinPoint1st,
    required this.pinPoint2nd,
    required this.setPlace,
    required this.setPolyline,
    required this.polylines,
    required this.startNavigation,
    required this.stopwatch,
    required this.startOrStop,
    required this.distance,
    required this.getLocationUpdate,
    required this.orginToUser,
    required this.currentLocation,
    required this.startLocation,
    required this.user,
  });
  final Function() selectPinPoint2;

  final Function() selectPinPoint;
  final Future<void> Function(
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) setPlace;
  final void Function(List<PointLatLng> points) setPolyline;
  LocationData currentLocation;
  LocationData startLocation;
  final Set<Polyline> polylines;
  final String pinPoint1st;
  final String pinPoint2nd;
  final void Function() startNavigation;
  final void Function() startOrStop;
  final Stopwatch stopwatch;
  final Future<void> Function() getLocationUpdate;
  final void Function(double distance) distance;
  final void Function(double orginToUserDistance) orginToUser;
  final Users user;

  @override
  State<Goal30Route> createState() => _Goal30RouteState();
}

class _Goal30RouteState extends State<Goal30Route> {
  LocationServicer locationServicer = LocationServicer();
  bool selectPoint = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'Pin point your Destination',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: const Color(0x3ff454545),
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
              color: Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.hardEdge,
              elevation: 10,
              child: InkWell(
                onTap: () {
                  widget.selectPinPoint();
                },
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Image.asset('assets/images/pedal/icon.png'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.pinPoint1st.isEmpty
                            ? 'Final Destination'
                            : widget.pinPoint1st,
                        style: GoogleFonts.inter(
                          color: Color(0x3FF989898),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0x3ffFF0000),
                minimumSize: const Size(
                  375,
                  45,
                ),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                // FirebaseFirestore.instance.collection('pedal').add({
                //   'pedalId': widget.pedalId,
                //   'username': widget.user.username,
                //   'time': DateTime.now(),
                //   'stopwatch:': 0,
                //   'totalDistance:': null,
                //   'avgSpeed': null,
                //   'distance': '',
                // });

                widget.polylines.clear();
                locationServicer.initLocation();
                setState(() {});

                var direction = await LocationService()
                    .getDirections(widget.pinPoint1st, widget.pinPoint2nd);

                var originToUser = await LocationService()
                    .getDirectionOriginUser(
                        widget.currentLocation.latitude!,
                        widget.currentLocation.longitude!,
                        widget.startLocation.latitude!,
                        widget.startLocation.longitude!);

                widget.setPlace(
                  direction!['start_location']['lat'],
                  direction['start_location']['lng'],
                  direction['bounds_ne'],
                  direction['bounds_sw'],
                );

                widget.setPolyline(direction['polyline_decoded']);
                widget.distance(
                  double.parse(direction['distance'].split(' ')[0]),
                );
                widget.orginToUser(
                  double.parse(originToUser!['distance'].split(' ')[0]),
                );
                widget.startNavigation();
                widget.getLocationUpdate();
                widget.stopwatch.start();

                // Start a periodic timer to update the UI every second
                Timer.periodic(Duration(seconds: 1), (timer) {
                  if (!widget.stopwatch.isRunning) {
                    timer.cancel();
                  }
                  setState(() {});
                });
              },
              child: Text(
                'Continue',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
