import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ta_rides/models/directions_model.dart';
import 'package:ta_rides/models/real_location.dart';
import 'package:ta_rides/models/rides_info.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';

class RealGoogleMap extends StatefulWidget {
  const RealGoogleMap({
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
  State<RealGoogleMap> createState() => _RealGoogleMapState();
}

class _RealGoogleMapState extends State<RealGoogleMap> {
  DirectionsRespository directionsRespository = DirectionsRespository();

  late GoogleMapController _googleController;
  StreamSubscription? _originSubscription;
  StreamController<Duration> _durationController =
      StreamController<Duration>.broadcast();
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
  bool isStart = false;
  Duration _duration = Duration();
  Timer? _timer;
  DateTime? startTime;

  @override
  void initState() {
    super.initState();
    reload();
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

  void start() {
    setState(() {
      _duration = Duration();
      isStart = true;
    });
    startTime = DateTime.now();
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _duration += Duration(seconds: 1);
      _durationController.add(_duration);
    });
  }

  void finish() async {
    _originSubscription?.pause();
    _googleController.animateCamera(_info != null
        ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
        : CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(widget.locationData!.latitude ?? 10.2899758,
                  widget.locationData!.longitude ?? 123.861891),
              zoom: 20.4746,
            ),
          ));

    Future.delayed(Duration(seconds: 5), () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('FINISH'),
            content: Text('Are you sure you want to finish?'),
            actions: <Widget>[
              TextButton(
                child: Text('No'),
                onPressed: () {
                  _originSubscription?.resume();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () async {
                  final Uint8List? screenshot =
                      await _googleController.takeSnapshot();
                  // if (screenshot != null) {
                  //   final directory = await getApplicationDocumentsDirectory();
                  //   final imagePath = '${directory.path}/screenshot.png';
                  //   final imageFile = File(imagePath);
                  //   await imageFile.writeAsBytes(screenshot);

                  //   final FirebaseFirestore _firestore =
                  //       FirebaseFirestore.instance;
                  //   final String id = _firestore.collection('pedal').doc().id;

                  //   final storageRef = FirebaseStorage.instance
                  //       .ref()
                  //       .child('pedal_image')
                  //       .child('$id.jpg');
                  //   await storageRef.putFile(imageFile);

                  //   final imageUrl = await storageRef.getDownloadURL();

                  //   await FirebaseFirestore.instance.collection('pedal').add({
                  //     'pedalId': id,
                  //     'username': widget.user.username,
                  //     'startTime': startTime,
                  //     'endTime': DateTime.now(),
                  //     'timer':
                  //         _duration.toString().split('.').first.padLeft(8, "0"),
                  //     'totalDistance': _info!.totalDistance,
                  //     'avgSpeed': avgSpeed,
                  //     'travelDistance': directionsRespository.distance,
                  //     'location': imageUrl,
                  //   }).then(
                  //     (value) => Navigator.of(context).pop(),
                  //   );
                  // }

                  setState(() {
                    isStart = false;
                    _timer?.cancel(); // stop the timer

                    _info = null;
                  });
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _durationController.close();
    super.dispose();
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
      _info = null;
      _info1 = null;
      _fistPoint = Marker(
        markerId: const MarkerId('fistPoint'),
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );

      _info = null;
      _secondPoint = null;
      _thirdPoint = null;
      setState(() {});
    } else if (_secondPoint == null) {
      _secondPoint = Marker(
        markerId: const MarkerId('secondPoint'),
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );

      directionsRespository.initSecondPoint(
          position.latitude, position.longitude);

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

      directionsRespository.initEndPoint(position.latitude, position.longitude);

      final direction2 = await DirectionsRespository()
          .getDirection(orgin: _secondPoint!.position, destination: position);
      setState(() => _info1 = direction2);
    }
  }

  void reload() {
    setState(() {
      directionsRespository.initSecondPoint;
      directionsRespository.initEndPoint;
      directionsRespository.secondDistance;
      directionsRespository.endDistance;
      directionsRespository.secondDistance1;
      directionsRespository.endDistance1;
    });
  }

  @override
  Widget build(BuildContext context) {
    reload();
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
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('rides')
                .where('ridesID', isEqualTo: widget.ride.ridesID)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              Set<Marker> markers = {};

              for (var doc in snapshot.data!.docs) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                LatLng position = LatLng(data['userLat'] ?? 10.2899758,
                    data['userLng'] ?? 123.861891);
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
              }
              bool secondpoint = false;
              bool endpoint = false;
              bool userWinner = false;
              bool enemyWinner = false;

              if (directionsRespository.secondDistance1 == 0.1) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You reach the second point'),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ),
                  );
                  bool secondpoint = true;
                });
              }

              if (directionsRespository.endDistance1 == 0.1) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You reach the end point'),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ),
                  );
                  bool endpoint = true;
                });
              }

              if (secondpoint == true &&
                  endpoint == true &&
                  widget.isUser == true) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Congratulations!'),
                        content: Text('You Won the game!'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () async {
                              final won = await FirebaseFirestore.instance
                                  .collection('rides')
                                  .where('ridesID',
                                      isEqualTo: widget.ride.ridesID)
                                  .get();
                              won.docs.first.reference.update({
                                'userWinner': true,
                                'enemyFinished': true,
                              }).then((value) {
                                if (widget.isUser) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => TabsScreen(
                                          email: widget.email,
                                          tabsScreen: 1,
                                          communityTabs: 0),
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                  setState(() {
                    userWinner = true;
                  });
                });
              }
              if (userWinner == true && widget.isUser == false) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Game Over'),
                        content: Text('You Lose the game!'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () async {
                              final won = await FirebaseFirestore.instance
                                  .collection('rides')
                                  .where('ridesID',
                                      isEqualTo: widget.ride.ridesID)
                                  .get();
                              won.docs.first.reference.update({
                                'enemyWinner': false,
                                'enemyFinished': true,
                              }).then((value) {
                                if (widget.isUser == false) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => TabsScreen(
                                                email: widget.email,
                                                tabsScreen: 0,
                                                communityTabs: 1,
                                              )));
                                }
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                });
              }

              if (secondpoint == true &&
                  endpoint == true &&
                  widget.isUser == false) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Congratulations!'),
                        content: Text('You Won the game!'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () async {
                              final won = await FirebaseFirestore.instance
                                  .collection('rides')
                                  .where('ridesID',
                                      isEqualTo: widget.ride.ridesID)
                                  .get();
                              won.docs.first.reference.update({
                                'userWinner': false,
                                'enemyFinished': true,
                              }).then((value) {
                                if (widget.isUser) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => TabsScreen(
                                          email: widget.email,
                                          tabsScreen: 1,
                                          communityTabs: 0),
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                  setState(() {
                    enemyWinner = true;
                  });
                });
              }
              if (enemyWinner == true && widget.isUser == true) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Game Over'),
                        content: Text('You Lose the game!'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () async {
                              final won = await FirebaseFirestore.instance
                                  .collection('rides')
                                  .where('ridesID',
                                      isEqualTo: widget.ride.ridesID)
                                  .get();
                              won.docs.first.reference.update({
                                'user': false,
                                'enemyFinished': true,
                              }).then((value) {
                                if (widget.isUser == false) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => TabsScreen(
                                                email: widget.email,
                                                tabsScreen: 0,
                                                communityTabs: 1,
                                              )));
                                }
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                });
              }

              return Expanded(
                child: Stack(
                  children: [
                    GoogleMap(
                      myLocationEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _googleController = controller;
                        // _controller.complete(controller);
                      },
                      initialCameraPosition: CameraPosition(
                        target: _origin!.position,
                        zoom: 15,
                      ),
                      markers: {
                        if (_origin != null) _origin!,
                        if (_enemy != null) _enemy!,
                        if (_fistPoint != null) _fistPoint!,
                        if (_secondPoint != null) _secondPoint!,
                        if (_thirdPoint != null) _thirdPoint!,
                      },
                      polylines: {
                        if (_info != null)
                          Polyline(
                            polylineId: const PolylineId('overview_polyline'),
                            color: Colors.redAccent,
                            width: 5,
                            points: _info!.polylinePoints
                                .map((e) => LatLng(e.latitude, e.longitude))
                                .toList(),
                          ),
                        if (_info1 != null)
                          Polyline(
                            polylineId: const PolylineId('overview_polyline'),
                            color: Color.fromARGB(255, 34, 63, 228),
                            width: 5,
                            points: _info1!.polylinePoints
                                .map((e) => LatLng(e.latitude, e.longitude))
                                .toList(),
                          ),
                      },
                      onLongPress: _addMarker,
                    ),
                    if (_info != null)
                      if (isStart == false && widget.isUser == true)
                        Positioned(
                          left: 10,
                          bottom: 10,
                          child: Stack(
                            children: [
                              Container(
                                height: 130,
                                width: 340,
                                decoration: BoxDecoration(
                                  color: Color(0x3fff0C0D11),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              if (_info != null)
                                Positioned(
                                  left: 20,
                                  top: 15,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (_info != null)
                                        Text(
                                          'STARTING POINT TO SECOND POINT',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                        ),
                                      Text(
                                        '${_info!.totalDistance}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                      ),
                                      Text(
                                        'SECOND POINT TO END POINT',
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
                                          '${_info1!.totalDistance}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                        ),
                                    ],
                                  ),
                                ),
                              Positioned(
                                right: 10,
                                bottom: 10,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0x3ffFF0000),
                                    minimumSize: const Size(
                                      105,
                                      82,
                                    ),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    reload();
                                    start();
                                  },
                                  child: Text(
                                    'START',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    if (isStart == false && widget.isUser == false)
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Stack(children: [
                          Container(
                            height: 130,
                            width: 340,
                            decoration: BoxDecoration(
                              color: Color(0x3fff0C0D11),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_info != null)
                                  Text(
                                    'STARTING POINT TO SECOND POINT',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                  ),
                                Text(
                                  '${_info!.totalDistance}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                ),
                                Text(
                                  'SECOND POINT TO END POINT',
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
                                    '${_info1!.totalDistance}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                  ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    if (isStart == true)
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Stack(
                          children: [
                            Container(
                              height: 190,
                              width: 340,
                              decoration: BoxDecoration(
                                color: Color(0x3fff0C0D11),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 20,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'TRAVEL TO SECOND POINT',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                ),
                                          ),
                                          Text(
                                            directionsRespository
                                                .secondDistance!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'TRAVEL TO END POINT',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                ),
                                          ),
                                          Text(
                                            directionsRespository.endDistance!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'TIME',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                  ),
                                  StreamBuilder<Duration>(
                                    stream: _durationController.stream,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Duration> snapshot) {
                                      if (snapshot.hasData) {
                                        // Format the duration as you want
                                        String formattedDuration = snapshot
                                            .data!
                                            .toString()
                                            .split('.')
                                            .first
                                            .padLeft(8, "0");
                                        return Text(
                                          formattedDuration,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        );
                                      } else {
                                        return Text('No data');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 20,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0x3ffFF0000),
                                  minimumSize: const Size(
                                    300,
                                    40,
                                  ),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isStart = false;
                                  });
                                  // start();
                                },
                                child: Text(
                                  'FINISH',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
