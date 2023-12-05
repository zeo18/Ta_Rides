// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as Loc;
import 'package:location/location.dart';
import 'package:ta_rides/data/goal30_data.dart';

import 'package:ta_rides/models/location_info.dart';
import 'package:ta_rides/models/rides_info.dart';

// import 'package:ta_rides/models/rides_info.dart';
import 'package:ta_rides/models/user_info.dart';

import 'package:ta_rides/widget/all_controller/location_controller.dart';

import 'package:ta_rides/widget/rides/rides_route.dart';

class UserGoogleMaps extends StatefulWidget {
  const UserGoogleMaps({
    Key? key,
    required this.locationData,
    required this.user,
    required this.rides,
  }) : super(key: key);

  final LocationData? locationData;
  final Users user;
  final Rides rides;

  @override
  State<UserGoogleMaps> createState() => _UserGoogleMapsState();
}

class _UserGoogleMapsState extends State<UserGoogleMaps> {
  TextEditingController pinPoint1stController = TextEditingController();
  TextEditingController pinPoint2ndController = TextEditingController();
  LocationServicer locationService1 = LocationServicer();

  bool startNavigation = false;
  late Timer _timer;
  Duration _duration = Duration();
  Stopwatch _stopwatch = Stopwatch();
  bool focusCameraCurrenLocation = false;
  bool _isRunning = false;
  late LocationData currentLocation;
  late LocationData startLocation;
  List<double> _speeds = [];
  double _totalSpeed = 0;

  LocationData? previousLocation;
  double originToUser = 0.0;
  double distance = 0.0;
  double avgSpeed = 0.0;
  double elevationGain = 0.0;
  double maxSpeed = 0.0;
  DateTime startTime = DateTime.now();
  double totalDistance = 0.0;
  int _start = 0;

  int selectTab = 0;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late GoogleMapController _googleController;
  final Loc.Location _locationController = new Loc.Location();

  List<Marker> _markers = [];

  Set<Marker> _currentLocation = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  void startOrStop() {
    setState(() {
      if (_isRunning) {
        _stopwatch.start();
      } else {
        _stopwatch.stop();
      }
      _isRunning = !_isRunning;
    });
  }

  void startNavigate() {
    setState(() {
      startNavigation = true;
    });
  }

  void selectedPage(int index) {
    setState(() {
      selectTab = index;
    });
    print(selectTab);
  }

  void setDistance(double distance) {
    setState(() {
      this.distance = distance;
    });
  }

  void setOriginToUserDistance(double orginToUserDistance) {
    setState(() {
      this.originToUser = orginToUserDistance;
    });
  }

  double calculateSpeed(double distance) {
    final elapsedMinutes = _stopwatch.elapsedMilliseconds ~/ 60000;
    final elapsedHours = elapsedMinutes / 60;
    double doubleDistance = locationService.distance1!;

    print(['second', elapsedHours.toDouble().toStringAsFixed(10)]);
    print(['distance', doubleDistance]);
    return doubleDistance.toDouble() / elapsedHours.toDouble();
  }

  void updateStartLocation() async {
    Loc.Location location = Loc.Location();
    LocationData currentLocationData = await location.getLocation();
    setState(() {
      startLocation = currentLocationData;
    });
  }

  void updateUserMovement(double distance) {
    setState(() {
      avgSpeed = calculateSpeed(distance);
    });
  }

  LocationService locationService = LocationService();
  @override
  void initState() {
    initialize();

    super.initState();

    locationService1.initLocation();
    locationService.initLocation();
    currentLocation = widget.locationData!;
    startLocation = currentLocation;

    _currentLocation.add(
      Marker(
        markerId: MarkerId('currentLocation'),
        position: LatLng(currentLocation.latitude ?? 10.2899758,
            currentLocation.longitude ?? 123.861891),
      ),
    );

    _startTimer();
  }

  void initialize() {
    setState(() {
      if (widget.locationData != null) {
        currentLocation = widget.locationData!;
      }
    });
  }

  void reloadDistance() {
    setState(() {
      locationService.initLocation();
      locationService.distance1;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration += Duration(seconds: 1);
      });
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    locationService.dispose();
    super.dispose();
  }

  void _setMarker(LatLng point) {
    if (pinPoint1stController.text.isNotEmpty) {
      Marker firstPoint = Marker(
        markerId: MarkerId('1st pin point'),
        position: point,
      );
      setState(() {
        _markers.add(firstPoint);
      });
    } else {
      Marker secondPoint = Marker(
        markerId: MarkerId('1st pin point'),
        position: point,
      );
      setState(() {
        _markers.add(secondPoint);
      });
    }
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
          polylineId: PolylineId(polylineIdVal),
          width: 2,
          color: Colors.red,
          points: points
              .map(
                (points) => LatLng(points.latitude, points.longitude),
              )
              .toList()),
    );
  }

  bool selectPoint = true;
  bool selectPoint2 = true;

  void selectPinPoint() {
    setState(() {
      selectPoint = false;
    });
  }

  void selectBack() {
    setState(() {
      selectPoint = true;
    });
  }

  void selectPinPoint2() {
    setState(() {
      selectPoint2 = false;
    });
  }

  void selectBack2() {
    setState(() {
      selectPoint2 = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    String _formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Goal30',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: const Color(0x3ff0c0d11),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: GoogleMap(
                mapType: MapType.normal,
                markers: {
                  ..._markers,
                  ..._currentLocation,
                },
                polygons: _polygons,
                polylines: _polylines,
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.locationData!.latitude ?? 10.2899758,
                      widget.locationData!.longitude ?? 123.861891),
                  zoom: 14.4746,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _googleController = controller;
                  _controller.complete(controller);
                },
              ),
            ),
            if (startNavigation == false)
              if (selectPoint)
                Padding(
                  padding: EdgeInsets.fromLTRB(220, 440, 0, 0),
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      focusCameraCurrenLocation = true;
                      setState(() {});
                      getLocationUpdates();
                      LocationData currentLocation =
                          await locationService.getLocation();
                      locationService.updateStartLocation(currentLocation);
                      getLocationUpdates();
                    },
                    label: Text('Current location'),
                    icon: Icon(Icons.location_history),
                    backgroundColor: Colors.white,
                  ),
                ),
            if (startNavigation)
              if (selectPoint)
                Padding(
                  padding: EdgeInsets.fromLTRB(220, 535, 5, 0),
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      focusCameraCurrenLocation = false;
                      setState(() {});
                      getLocationUpdates();
                    },
                    label: Text(
                      'Focus Your Location',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(Icons.location_history, color: Colors.white),
                    backgroundColor: Color(0x3FF0C0D11),
                  ),
                ),
            if (startNavigation)
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 595, 5, 5),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        width: 500,
                        decoration: BoxDecoration(
                          color: Color(0x3FF0C0D11),
                          borderRadius: BorderRadius.circular(
                              20.0), // Adjust the radius as needed
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 65,
                              width: 500,
                              margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                              child: Card(
                                color: Color(0x3ff181A20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                clipBehavior: Clip.hardEdge,
                                elevation: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 80,
                                        ),
                                        Text(
                                          'TIME',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: const Color(0x3ffE8AA0A),
                                                fontWeight: FontWeight.w900,
                                                fontSize: 12,
                                              ),
                                        ),
                                        SizedBox(
                                          width: 160,
                                        ),
                                        Text(
                                          'GOAL',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: const Color(0x3ffE8AA0A),
                                                fontWeight: FontWeight.w900,
                                                fontSize: 12,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 60,
                                        ),
                                        Text(
                                          _formatDuration(_stopwatch.elapsed),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20,
                                              ),
                                        ),
                                        SizedBox(
                                          width: 110,
                                        ),
                                        // Text(
                                        //   '${widget.rides.distance} km',
                                        //   style: Theme.of(context)
                                        //       .textTheme
                                        //       .bodyLarge!
                                        //       .copyWith(
                                        //         color: Colors.white,
                                        //         fontWeight: FontWeight.w900,
                                        //         fontSize: 20,
                                        //       ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 65,
                              width: 500,
                              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Card(
                                color: Color(0x3ff181A20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                clipBehavior: Clip.hardEdge,
                                elevation: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 35,
                                          ),
                                          Text(
                                            'AVG SPEED(km/h)',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color:
                                                      const Color(0x3ffE8AA0A),
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 12,
                                                ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          Text(
                                            'DISTANCE',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color:
                                                      const Color(0x3ffE8AA0A),
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 55,
                                        ),
                                        Text(
                                          avgSpeed == double.infinity
                                              ? 'Calculating...'
                                              : '${avgSpeed.toStringAsFixed(2)} km',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20,
                                              ),
                                        ),
                                        if (avgSpeed == double.infinity)
                                          SizedBox(
                                            width: 70,
                                          )
                                        else
                                          SizedBox(
                                            width: 110,
                                          ),
                                        Text(
                                          ' ${locationService.distance}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0x3FF0C0D11),
                                      minimumSize: const Size(178, 35),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    onPressed: startOrStop,
                                    child: Text(
                                      _isRunning ? 'Start' : 'Stop',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0x3ffFF0000),
                                      minimumSize: const Size(
                                        178,
                                        35,
                                      ),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {
                                      _timer.cancel();

                                      // Clear the polylines
                                      setState(() {
                                        focusCameraCurrenLocation = true;
                                        _markers.clear();
                                        _timer.cancel();
                                        _stopwatch.stop();
                                        _stopwatch.reset();
                                        _polylines.clear();
                                        pinPoint1stController.clear();
                                        distance = 0;
                                        startNavigation = false;
                                      });
                                    },
                                    child: Text(
                                      'Finish',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (startNavigation == false)
              if (selectPoint)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 505, 10, 10),
                  child: Stack(
                    children: [
                      Container(
                        height: 400,
                        width: 500,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              30.0), // Adjust the radius as needed
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DefaultTabController(
                          length: 1,
                          child: Column(
                            children: [
                              TabBar(
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: const Color(0x3ffff0000),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                indicatorSize: TabBarIndicatorSize.label,
                                unselectedLabelColor: const Color(0x3ff666666),
                                labelColor: const Color(0x3ffff0000),
                                indicatorWeight: 4,
                                indicatorColor: const Color(0x3ffff0000),
                                onTap: selectedPage,
                                tabs: const [
                                  Tab(
                                    text: 'Routes',
                                  ),
                                ],
                              ),
                              if (startNavigation == false)
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      RidesRoute(
                                        pinPoint1st: pinPoint1stController.text,
                                        pinPoint2nd: pinPoint2ndController.text,
                                        selectPinPoint: selectPinPoint,
                                        selectPinPoint2: selectPinPoint2,
                                        setPlace: ((lat, lng, boundsNe,
                                                boundsSw) =>
                                            _setPlace(
                                                lat, lng, boundsNe, boundsSw)),
                                        setPolyline: (points) =>
                                            _setPolyline(points),
                                        polylines: _polylines,
                                        startNavigation: startNavigate,
                                        stopwatch: _stopwatch,
                                        startOrStop: startOrStop,
                                        distance: setDistance,
                                        getLocationUpdate: getLocationUpdates,
                                        orginToUser: setOriginToUserDistance,
                                        currentLocation: currentLocation,
                                        startLocation: startLocation,
                                        user: widget.user,
                                        distanceGoal: distance,
                                        reloadDistance: reloadDistance,
                                        rides: widget.rides,
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            if (selectPoint == false)
              Stack(
                children: [
                  Container(
                    height: 145,
                    width: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(
                              20)), // Adjust the radius as needed
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: selectBack,
                          icon: Icon(Icons.arrow_back),
                        ),
                        Text(
                          'Destination',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: const Color(0x3ff454545),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                        ),
                        SizedBox(
                          width: 180,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Card(
                        color: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.hardEdge,
                        elevation: 10,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextFormField(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                              cursorColor: Colors.white,
                              controller: pinPoint1stController,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                label: Text(
                                  'Search your Destination...',
                                  style: GoogleFonts.inter(
                                    color: const Color(0x3ff454545),
                                    fontSize: 13,
                                  ),
                                ),
                                suffix: IconButton(
                                  onPressed: () async {
                                    var place = await LocationService()
                                        .getPlace(pinPoint1stController.text);
                                    _goToPlace(place);

                                    final direction = await LocationService()
                                        .getDirections(
                                            pinPoint1stController.text,
                                            pinPoint2ndController.text);

                                    setDistance(double.parse(
                                        direction!['distance'].split(' ')[0]));
                                  },
                                  icon: Icon(Icons.search),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (selectPoint2 == false)
              Stack(
                children: [
                  Container(
                    height: 145,
                    width: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(
                              20)), // Adjust the radius as needed
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  late bool _shouldUpdateCamera;
  DateTime? _previousTime;

  Future<void> getLocationUpdates() async {
    LocationData? _previousLocation;
    LatLng _finalDestination = LatLng(0, 0);

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }
    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _shouldUpdateCamera = true;
    _locationController.onLocationChanged.listen((currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        if (_shouldUpdateCamera) {
          Future.delayed(Duration(seconds: 1), () {
            _googleController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(
                        currentLocation.latitude!, currentLocation.longitude!),
                    zoom: 16.5),
              ),
            );

            DateTime currentTime = DateTime.now();

            // if (widget.rides.distance == locationService.distance1) {
            //   showDialog(
            //     context: context,
            //     builder: (BuildContext context) {
            //       return AlertDialog(
            //         title: Text('Congratulations!'),
            //         content: Text('You reached your goal today!'),
            //         actions: <Widget>[
            //           ElevatedButton(
            //             child: Text('OK'),
            //             onPressed: () async {
            //               setState(() {});

            //               // for (var i = 0; i < goal30.length; i++) {
            //               // if (widget.goalDay == i) {
            //               //   // if(widget.goalDay == i{
            //               //   //   return;
            //               //   // })
            //               //   setState(() {
            //               //     yourGoal = 0;
            //               //   });

            //               //   final goalDone = await FirebaseFirestore.instance
            //               //       .collection('goal30')
            //               //       .where('day$i', isEqualTo: false)
            //               //       .get();

            //               //   goalDone.docs.first.reference.update({
            //               //     'day$i': true,
            //               //   }).then((value) {
            //               //     Navigator.push(
            //               //       context,
            //               //       MaterialPageRoute(
            //               //         builder: (context) => TabsScreen(
            //               //           email: widget.user.email,
            //               //           tabsScreen: 3,
            //               //           communityTabs: 0,
            //               //         ),
            //               //       ),
            //               //     );
            //               //   });
            //               // }
            //               // }
            //             },
            //           ),
            //         ],
            //       );
            //     },
            //   );
            // }
            _previousLocation = currentLocation;
            _previousTime = currentTime;
          });
        }

        _currentLocation.add(Marker(
            markerId: MarkerId('currentLocation'),
            position:
                LatLng(currentLocation.latitude!, currentLocation.longitude!)));
        if (focusCameraCurrenLocation) {
          _shouldUpdateCamera = false;
        }

        // setState(() {
        updateUserMovement(distance);
        // });
      }
    });
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng), zoom: 15.5),
    ));

    _setMarker(LatLng(lat, lng));
  }

  Future<void> _setPlace(
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    // final double lat = place['geometry']['location']['lat'];
    // final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng), zoom: 15.5),
    ));

    controller.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng'])),
        25));

    _setMarker(LatLng(lat, lng));
  }
}
