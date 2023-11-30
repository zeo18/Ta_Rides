import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ta_rides/models/location_info.dart';
import 'package:ta_rides/models/rides_info.dart';
import 'package:geocoding/geocoding.dart' as Geo;
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({
    super.key,
    required this.locationData,
    required this.ride,
    required this.isUser,
    required this.email,
  });

  final Rides ride;
  final String email;
  final LocationData? locationData;
  final bool isUser;

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  LocationService locationService = LocationService();
  TextEditingController startingPoint = TextEditingController();
  TextEditingController midPoint = TextEditingController();
  TextEditingController endPoint = TextEditingController();
  bool isNavigating = false;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late GoogleMapController _googleController;
  late GoogleMapController mapController;
  Stopwatch _stopwatch = Stopwatch();
  Location location = Location();
  Location enemy = Location();
  double avgSpeed = 0.0;
  double distance = 0.0;
  Set<Marker> markers = {};
  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;
  Set<Polyline> _polylines = Set<Polyline>();
  bool focusCameraCurrenLocation = false;

  double calculateSpeed(double distance) {
    final elapsedMinutes = _stopwatch.elapsedMilliseconds ~/ 60000;
    final elapsedHours = elapsedMinutes / 60;
    double doubleDistance = locationService.distance1!;

    print(['second', elapsedHours.toDouble().toStringAsFixed(10)]);
    print(['distance', doubleDistance]);
    return doubleDistance.toDouble() / elapsedHours.toDouble();
  }

  void setDistance(double distance) {
    setState(() {
      this.distance = distance;
    });
  }

  void _setPolyline(List<PointLatLng> points, Color color) {
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
          polylineId: PolylineId(polylineIdVal),
          width: 2,
          color: color,
          points: points
              .map(
                (points) => LatLng(points.latitude, points.longitude),
              )
              .toList()),
    );
  }

  void updateUserMovement(double distance) {
    setState(() {
      avgSpeed = calculateSpeed(distance);

      // final speed = calculateSpeed(distance);
      // if (speed > maxSpeed) {
      //   maxSpeed = speed;
      // }
      // Update your UI based on the speed
    });
  }

  void reloadDistance() {
    setState(() {
      getLatLong(endPoint.text);
      locationService.endDistance;
    });
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
  }

  @override
  void initState() {
    super.initState();

    startingPoint.text = 'busay cebu';
    midPoint.text = 'swu cebu';
    endPoint.text = 'usjr main';

    locationService.initLocation();
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
    String _formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
        actions: <Widget>[
          Tooltip(
            message: 'Current Location',
            child: IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {
                // Handle the button press here
              },
            ),
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.delete),
      //   backgroundColor: Colors.red,
      //   elevation: 0.0,
      // ),
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
                  markerId: MarkerId('currentLocation'),
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
              return Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            _googleController = controller;
                            _controller.complete(controller);
                          },
                          initialCameraPosition: CameraPosition(
                            target: position,
                            zoom: 14.4746,
                          ),
                          markers: markers,
                          polylines: _polylines,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 350, 0, 0),
                          child: FloatingActionButton.extended(
                            onPressed: () async {
                              focusCameraCurrenLocation = false;
                              setState(() {});
                              getLocationUpdates();
                              LocationData currentLocation =
                                  await locationService.getLocation();
                              locationService
                                  .updateStartLocation(currentLocation);
                              getLocationUpdates();
                            },
                            label: Text('Current location'),
                            icon: Icon(Icons.location_history),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isNavigating == false)
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                            // onSaved: (value) {
                            //   emailController.text = value!;
                            // },
                            // style: GoogleFonts.inter(
                            //   color: Colors.white,
                            // ),
                            controller: startingPoint,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x3fffFFFFF0),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0x3fff454545),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              labelStyle: GoogleFonts.montserrat(
                                color: const Color(0x3fff454545),
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color(0x3fff454545),
                              ),
                              labelText: '1st PinPoint',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                            controller: midPoint,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x3fffFFFFF0),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0x3fff454545),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              labelStyle: GoogleFonts.montserrat(
                                color: const Color(0x3fff454545),
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color(0x3fff454545),
                              ),
                              labelText: '2nd PinPoint',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                            controller: endPoint,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x3fffFFFFF0),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0x3fff454545),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              labelStyle: GoogleFonts.montserrat(
                                color: const Color(0x3fff454545),
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color(0x3fff454545),
                              ),
                              labelText: '3rd PinPoint',
                            ),
                          ),
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
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            var direction = await LocationService()
                                .getStartToMid(
                                    startingPoint.text, midPoint.text);
                            var direction1 = await LocationService()
                                .getMidToFinish(midPoint.text, endPoint.text);

                            var distanceStarttoEnd = await LocationService()
                                .getStartingToEnd(
                                    startingPoint.text, endPoint.text);

                            _setPolyline(
                                direction!['polyline_decoded'], Colors.cyan);
                            _setPolyline(direction1!['polyline_decoded'],
                                Colors.deepPurple);
                            getLatLong(endPoint.text);
                            _setPlace(
                              direction['start_location']['lat'],
                              direction['start_location']['lng'],
                              direction['bounds_ne'],
                              direction['bounds_sw'],
                            );
                            _stopwatch.start();
                            isNavigating = true;
                            setDistance(
                              double.parse(distanceStarttoEnd!['distance']
                                  .split(' ')[0]),
                            );
                            _stopwatch.start();

                            Timer.periodic(Duration(seconds: 1), (timer) {
                              if (_stopwatch.isRunning) {
                                timer.cancel();
                              }
                            });
                          },
                          child: Text(
                            'Continue',
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
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  if (isNavigating == true)
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
                                  width: 120,
                                ),
                                Text(
                                  'TOTAL DISTANCE',
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
                                Text(
                                  '${distance.toStringAsFixed(2)} km',
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
                  if (isNavigating == true)
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
                                  SizedBox(
                                    width: 110,
                                  ),
                                  Text(
                                    'DISTANCE',
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
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                ),
                                Text(
                                  ' ${locationService.endDistance}',
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
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void getLatLong(String address) async {
    try {
      List<Geo.Location> locations = await Geo.locationFromAddress(address);
      double latitude = locations.first.latitude;
      double longitude = locations.first.longitude;

      setState(() {
        locationService.initEndPoint(latitude, longitude);
      });

      print('Latitude: $latitude, Longitude: $longitude');
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  late bool _shouldUpdateCamera;

  Location _locationController = new Location();
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
          });
        }
      }
    });

    if (locationService.endDistance1 == 0.0 && widget.isUser) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You have won the game!'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () async {
                  final won = await FirebaseFirestore.instance
                      .collection('rides')
                      .where('ridesID', isEqualTo: widget.ride.ridesID)
                      .get();
                  won.docs.first.reference.update({
                    'userWinner': true,
                  }).then((value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => TabsScreen(
                              email: widget.email,
                              tabsScreen: 1,
                              communityTabs: 0))));
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You have lose the game'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () async {
                  final won = await FirebaseFirestore.instance
                      .collection('rides')
                      .where('ridesID', isEqualTo: widget.ride.ridesID)
                      .get();
                  won.docs.first.reference.update({
                    'enemyWinner': false,
                  }).then((value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => TabsScreen(
                              email: widget.email,
                              tabsScreen: 1,
                              communityTabs: 0))));
                },
              ),
            ],
          );
        },
      );
    }

    if (locationService.endDistance1 == 0.0 && widget.isUser == false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You have won the game!'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () async {
                  final won = await FirebaseFirestore.instance
                      .collection('rides')
                      .where('ridesID', isEqualTo: widget.ride.ridesID)
                      .get();
                  won.docs.first.reference.update({
                    'enemyWinner': true,
                  }).then((value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => TabsScreen(
                              email: widget.email,
                              tabsScreen: 1,
                              communityTabs: 0))));
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You lose won the game!'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () async {
                  final won = await FirebaseFirestore.instance
                      .collection('rides')
                      .where('ridesID', isEqualTo: widget.ride.ridesID)
                      .get();
                  won.docs.first.reference.update({
                    'userWinner': false,
                  }).then((value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => TabsScreen(
                              email: widget.email,
                              tabsScreen: 1,
                              communityTabs: 0))));
                },
              ),
            ],
          );
        },
      );
    }
  }
}
