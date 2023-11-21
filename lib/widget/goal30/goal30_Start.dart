import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ta_rides/models/location_info.dart';
import 'package:ta_rides/screen/auth/logInPage.dart';
import 'package:ta_rides/widget/goal30/goal30_Route.dart';
import 'package:ta_rides/widget/pedal/route.dart';
import 'package:ta_rides/widget/pedal/saved_route.dart';

class Goal30Start extends StatefulWidget {
  const Goal30Start(
      {Key? key, this.locationData, required this.goal30PinController})
      : super(key: key);

  final LocationData? locationData;
  final String goal30PinController;
  @override
  State<Goal30Start> createState() => _Goal30StartState();
}

class _Goal30StartState extends State<Goal30Start> {
  TextEditingController pinPoint1stController = TextEditingController();
  TextEditingController pinPoint2ndController = TextEditingController();

  bool startNavigation = false;
  late Timer _timer;
  Duration _duration = Duration();
  Stopwatch _stopwatch = Stopwatch();
  bool focusCameraCurrenLocation = false;
  bool _isRunning = false;

  List<double> _speeds = [];
  double _totalSpeed = 0;

  LocationData? previousLocation;
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
  Location _locationController = new Location();

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

  double calculateSpeed(double distance) {
    final elapsedMinutes = _stopwatch.elapsedMilliseconds ~/ 60000;
    final elapsedHours = elapsedMinutes / 60;
    double doubleDistance = distance;

    print(['second', elapsedHours.toDouble().toStringAsFixed(10)]);
    print(['distance', doubleDistance]);
    return doubleDistance.toDouble() / elapsedHours.toDouble();
  }

  void updateUserMovement(double distance) {
    setState(() {
      avgSpeed = calculateSpeed(distance);
      print(['avgSpeed', avgSpeed]);

      // final speed = calculateSpeed(distance);
      // if (speed > maxSpeed) {
      //   maxSpeed = speed;
      // }
      // Update your UI based on the speed
    });
  }

  @override
  void initState() {
    super.initState();
    _currentLocation.add(
      Marker(
        markerId: MarkerId('initial_position'),
        position: LatLng(widget.locationData?.latitude ?? 10.2899758,
            widget.locationData?.longitude ?? 123.861891),
      ),
    );

    _startTimer();
    pinPoint1stController.text = widget.goal30PinController;
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

  double toRadians(double degree) {
    return degree * pi / 180;
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_id_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
    );
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
            'GOAL 30',
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
                onTap: (point) {
                  setState(() {
                    polygonLatLngs.add(point);
                    _setPolygon();
                  });
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.locationData?.latitude ?? 10.2899758,
                      widget.locationData?.longitude ?? 123.861891),
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
                  padding: EdgeInsets.fromLTRB(220, 430, 0, 0),
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      focusCameraCurrenLocation = true;
                      setState(() {});
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
                  padding: EdgeInsets.fromLTRB(220, 468, 5, 0),
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
                padding: const EdgeInsets.fromLTRB(5, 528, 5, 5),
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
                                          width: 70,
                                        ),
                                        Text(
                                          'Time',
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
                                          width: 140,
                                        ),
                                        Text(
                                          'DISTANCE(km)',
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
                                          width: 50,
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
                                          width: 130,
                                        ),
                                        Text(
                                          '${distance.toStringAsFixed(2)}',
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
                                            width: 130,
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
                                            width: 85,
                                          ),
                                          // Text(
                                          //   'MAX SPEED',
                                          //   style: Theme.of(context)
                                          //       .textTheme
                                          //       .bodyLarge!
                                          //       .copyWith(
                                          //         color:
                                          //             const Color(0x3ffE8AA0A),
                                          //         fontWeight: FontWeight.w900,
                                          //         fontSize: 12,
                                          //       ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 140,
                                        ),
                                        Text(
                                          avgSpeed == double.infinity
                                              ? 'Calculating...'
                                              : '${avgSpeed.toStringAsFixed(2)}',
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
                                    onPressed: () {
                                      // Stop the timer
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
                  padding: const EdgeInsets.fromLTRB(10, 490, 10, 10),
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
                          length: 2,
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
                                  Tab(
                                    text: "Save Route",
                                  ),
                                ],
                              ),
                              if (startNavigation == false)
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      Goal30Route(
                                        goal30PinController:
                                            widget.goal30PinController,
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
                                      ),
                                      SavedRoute(),
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
                                  widget.goal30PinController.isEmpty
                                      ? 'Search your Destination...'
                                      : widget.goal30PinController,
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
  double _threshold = 0.1;

  Future<void> getLocationUpdates() async {
    LocationData? _previousLocation;
    LatLng _finalDestination = LatLng(0, 0);
    // if (!mounted) {
    //   return;
    // }
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
    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
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

            double distanceToDestination =
                calculateDistance(currentLocation, _finalDestination);
            if (distanceToDestination < _threshold) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Arrived at Destination'),
                    content:
                        Text('You have arrived at your final destination.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }

            DateTime currentTime = DateTime.now();

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

  double calculateDistance(
      LocationData currentLocation, LatLng finalDestination) {
    double earthRadius = 6371; // radius of the earth in km
    double latDistance =
        toRadians(finalDestination.latitude - currentLocation.latitude!);
    double lonDistance =
        toRadians(finalDestination.longitude - currentLocation.longitude!);
    double a = sin(latDistance / 2) * sin(latDistance / 2) +
        cos(toRadians(currentLocation.latitude!)) *
            cos(toRadians(finalDestination.latitude)) *
            sin(lonDistance / 2) *
            sin(lonDistance / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c; // distance in km

    return distance;
  }

  double calculateMaxSpeed() {
    if (_speeds.isEmpty) {
      return 0;
    }
    return _speeds
        .reduce((value, element) => value > element ? value : element);
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
