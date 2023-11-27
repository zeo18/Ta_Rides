import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ta_rides/data/goal30_data.dart';
import 'package:ta_rides/models/goal30_info.dart';
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
    required this.goal30,
    required this.day,
    required this.distanceGoal,
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
  final Goal30 goal30;
  final int day;
  final double distanceGoal;

  @override
  State<Goal30Route> createState() => _Goal30RouteState();
}

class _Goal30RouteState extends State<Goal30Route> {
  LocationServicer locationServicer = LocationServicer();
  bool selectPoint = true;
  double yourGoal = 0.0;

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < widget.goal30.goalLenght; i++) {
      if (widget.goal30.goalLenght == goal30.length) {
        if (widget.day == goal30[i].day) {
          yourGoal = goal30[i].kmGoal;
        }
      }
    }
    for (var i = 0; i < widget.goal30.goalLenght; i++) {
      if (widget.goal30.goalLenght == goal60.length) {
        if (widget.day == goal60[i].day) {
          yourGoal = goal60[i].kmGoal;
        }
      }
    }
    for (var i = 0; i < widget.goal30.goalLenght; i++) {
      if (widget.goal30.goalLenght == goal90.length) {
        if (widget.day == goal90[i].day) {
          yourGoal = goal90[i].kmGoal;
        }
      }
    }
    print(yourGoal);

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      "TODAY'S GOAL",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: const Color(0x3ff454545),
                            fontSize: 15,
                          ),
                    ),
                    for (var i = 0; i < widget.goal30.goalLenght; i++)
                      if (widget.goal30.goalLenght == goal30.length)
                        if (widget.day == goal30[i].day)
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              '${goal30[i].kmGoal} km',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: const Color(0x3ff454545),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 23,
                                  ),
                            ),
                          ),
                    for (var i = 0; i < widget.goal30.goalLenght; i++)
                      if (widget.goal30.goalLenght == goal60.length)
                        if (widget.day == goal60[i].day)
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              '${goal60[i].kmGoal} km',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: const Color(0x3ff454545),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 23,
                                  ),
                            ),
                          ),
                    for (var i = 0; i < widget.goal30.goalLenght; i++)
                      if (widget.goal30.goalLenght == goal90.length)
                        if (widget.day == goal90[i].day)
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              '${goal90[i].kmGoal} km',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: const Color(0x3ff454545),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 23,
                                  ),
                            ),
                          ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "TOTAL DISTANCE",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: const Color(0x3ff454545),
                            fontSize: 15,
                          ),
                    ),
                    Text(
                      '${widget.distanceGoal} km',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: const Color(0x3ff454545),
                            fontWeight: FontWeight.w900,
                            fontSize: 23,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
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
                if (widget.distanceGoal >= yourGoal) {
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

                  Timer.periodic(Duration(seconds: 1), (timer) {
                    if (!widget.stopwatch.isRunning) {
                      timer.cancel();
                    }

                    setState(() {});
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('It should be higher with Todays goal'),
                    ),
                  );
                }
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
