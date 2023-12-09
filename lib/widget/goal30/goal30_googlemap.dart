import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:ta_rides/data/goal30_data.dart';
import 'package:ta_rides/models/directions_model.dart';
import 'package:ta_rides/models/goal30_info.dart';
import 'package:ta_rides/models/location_info.dart';
import 'package:ta_rides/models/real_location.dart';
import 'package:ta_rides/models/user_info.dart';

class Goal30GoogleMap extends StatefulWidget {
  const Goal30GoogleMap({
    super.key,
    this.locationData,
    required this.user,
    required this.goalDay,
    required this.goal30,
    required this.day,
  });

  final LocationData? locationData;
  final Users user;
  final int goalDay;
  final Goal30 goal30;
  final int day;

  @override
  State<Goal30GoogleMap> createState() => _RealPedalScreenState();
}

class _RealPedalScreenState extends State<Goal30GoogleMap> {
  final ScreenshotController screenshotController = ScreenshotController();
  DirectionsRespository directionsRespository = DirectionsRespository();
  TextEditingController searchLocationController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  StreamSubscription<LocationData>? _locationSubscription;
  GoogleMapController? _googlemapController;
  Location location = Location();
  Location _location = Location();
  Marker? _origin;
  Directions? _info;
  late Future<void> _setMarkerFuture;
  Duration _duration = Duration();
  Timer? _timer;
  double avgSpeed = 0.0;
  StreamController<LatLng> _originStreamController = StreamController<LatLng>();
  StreamSubscription? _originSubscription;

  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  bool isStart = false;
  Marker? _destination;
  DateTime? startTime;
  double yourGoal = 0.0;

  @override
  void initState() {
    directionsRespository.initStartLocation();
    directionsRespository.distance1;

    _setMarkerFuture = setMarker();

    _locationSubscription =
        _location.onLocationChanged.listen((LocationData currentLocation) {
      if (mounted) {
        setState(() {
          _origin = Marker(
            markerId: const MarkerId('origin'),
            position:
                LatLng(currentLocation.latitude!, currentLocation.longitude!),
          );

          polylineCoordinates.add(
              LatLng(currentLocation.latitude!, currentLocation.longitude!));

          PolylineId id = PolylineId('poly');
          Polyline polyline = Polyline(
            polylineId: id,
            color: Colors.blue,
            points: polylineCoordinates,
            width: 16,
          );
          polylines[id] = polyline;
        });
      }
    });
    super.initState();
  }

  void refreshDistance() {
    setState(() {
      directionsRespository.initStartLocation();
      directionsRespository.distance;
      directionsRespository.distance1;
    });
  }

  void start() {
    refreshDistance();
    setState(() {
      _duration = Duration();
      isStart = true;
      polylineCoordinates.clear();
    });
    startTime = DateTime.now();
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration += Duration(seconds: 1);
      });
    });
  }

  void finish() async {
    _originSubscription?.pause();
    _googlemapController!.animateCamera(_info != null
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
                      await _googlemapController!.takeSnapshot();
                  if (screenshot != null) {
                    final directory = await getApplicationDocumentsDirectory();
                    final imagePath = '${directory.path}/screenshot.png';
                    final imageFile = File(imagePath);
                    await imageFile.writeAsBytes(screenshot);

                    final FirebaseFirestore _firestore =
                        FirebaseFirestore.instance;
                    final String id = _firestore.collection('pedal').doc().id;

                    final storageRef = FirebaseStorage.instance
                        .ref()
                        .child('pedal_image')
                        .child('$id.jpg');
                    await storageRef.putFile(imageFile);

                    final imageUrl = await storageRef.getDownloadURL();

                    await FirebaseFirestore.instance.collection('pedal').add({
                      'pedalId': id,
                      'username': widget.user.username,
                      'startTime': startTime,
                      'endTime': DateTime.now(),
                      'timer':
                          _duration.toString().split('.').first.padLeft(8, "0"),
                      'totalDistance': _info!.totalDistance,
                      'avgSpeed': avgSpeed,
                      'travelDistance': directionsRespository.distance,
                      'location': imageUrl,
                    }).then(
                      (value) => Navigator.of(context).pop(),
                    );
                  }

                  setState(() {
                    isStart = false;
                    _timer?.cancel(); // stop the timer
                    polylines.clear();
                    polylineCoordinates.clear();
                    _info = null;
                    _destination = null;
                  });
                  refreshDistance;
                },
              ),
            ],
          );
        },
      );
    });
  }

  Future<void> setMarker() async {
    final icon = await getNetworkImage(
      widget.user.userImage,
    ); // replace with your image URL

    location = Location();
    _locationSubscription = location.onLocationChanged.listen(
      (LocationData currentLocation) {
        print(
            'Current location: ${currentLocation.latitude}, ${currentLocation.longitude}');

        setState(() {
          _origin = Marker(
            markerId: const MarkerId('currentLocation'),
            position:
                LatLng(currentLocation.latitude!, currentLocation.longitude!),
            infoWindow: const InfoWindow(title: 'Current Location'),
            icon: icon,
          );
        });
        _originStreamController.add(_origin!.position);
      },
    );
    _info = null;
  }

  Future<BitmapDescriptor> getNetworkImage(String url,
      {int width = 150, int height = 150}) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    final codec = await ui.instantiateImageCodec(bytes,
        targetWidth: width, targetHeight: height);
    final frame = await codec.getNextFrame();

    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();

    _googlemapController!.dispose();
    _originSubscription?.cancel();
    _originStreamController.close();
    _timer?.cancel();

    super.dispose();
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng), zoom: 15.5),
    ));
  }

  void focusLocation(LatLng newPosition) async {
    final bearing = await FlutterCompass.events!.first;

    _googlemapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: newPosition,
          zoom: 17.4746,
          tilt: 50,
          bearing: bearing.heading!,
        ),
      ),
    );
  }

  void getGoalKm() {
    setState(() {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    Set<Polyline> allPolylines = Set<Polyline>.of(polylines.values);

    if (_info != null) {
      allPolylines.add(
        Polyline(
          polylineId: const PolylineId('overview_polyline'),
          color: Colors.red,
          width: 5,
          points: _info!.polylinePoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
        ),
      );
    }
    if (directionsRespository.distance1 != null) {
      final elapsedSeconds = _duration.inSeconds / 2000;
      final elapsedMinutes = _duration.inMinutes / 60;
      final elapsedHours = _duration.inHours;
      double doubleDistance = directionsRespository.distance1!;

      print(['second', elapsedHours.toDouble().toStringAsFixed(10)]);
      print(['distance', doubleDistance]);
      setState(() {
        avgSpeed = doubleDistance.toDouble() / elapsedSeconds.toDouble();
      });
    }

    getGoalKm();
    return FutureBuilder(
      future: _setMarkerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Show loading indicator while waiting for setMarker to complete
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show error message if setMarker completed with an error
        } else {
          return Screenshot(
            controller: screenshotController,
            child: Scaffold(
              backgroundColor: Color(0x3fff0C0D11),
              appBar: AppBar(
                title: Text(
                  'Goal ${widget.goal30.goalLenght}',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: Color(0x3fff0C0D11),
                actions: [
                  Container(
                    width: 40,
                    child: Image(
                      image: NetworkImage(
                        widget.user.userImage,
                      ),
                    ),
                  ),
                  TextButton(
                    onLongPress: () {
                      _googlemapController!.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: _origin!.position,
                            zoom: 18.4746,
                            tilt: 0.0,
                          ),
                        ),
                      );
                    },
                    onPressed: () {
                      _googlemapController!.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: _origin!.position,
                            zoom: 19.50,
                            tilt: 50.0,
                            bearing: 45.0,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Origin',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Icon(Icons.place, color: Colors.red),
                  if (_destination != null)
                    TextButton(
                      onLongPress: () {
                        _googlemapController!.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: _destination!.position,
                              zoom: 18.4746,
                              tilt: 0.0,
                            ),
                          ),
                        );
                      },
                      onPressed: () {
                        _googlemapController!.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: _destination!.position,
                              zoom: 18.4746,
                              tilt: 50.0,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Destination',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.red,
                              fontSize: 15,
                            ),
                      ),
                    )
                  else
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Destination',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.red,
                              fontSize: 15,
                            ),
                      ),
                    )
                ],
              ),
              body: Stack(
                children: [
                  GoogleMap(
                    // myLocationButtonEnabled: true,
                    // myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          widget.locationData!.latitude ?? 10.2899758,
                          widget.locationData!.longitude ?? 123.861891),
                      zoom: 14.4746,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _googlemapController = controller;
                      _controller.complete(controller);
                    },
                    markers: {
                      if (_origin != null) _origin!,
                      if (_destination != null) _destination!,
                    },
                    polylines: allPolylines,

                    onLongPress: (LatLng latLng) async {
                      setState(() {
                        _destination = Marker(
                          markerId: const MarkerId('destination'),
                          infoWindow: const InfoWindow(title: 'Destination'),
                          position: latLng,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed),
                        );

                        print(latLng);
                      });

                      print('Origin: ${_origin!.position}');
                      print('Destination: ${_destination!.position}');
                      final directions = await DirectionsRespository()
                          .getDirection(
                              orgin: _origin!.position, destination: latLng);
                      setState(() => _info = directions);
                    },
                  ),
                  if (_info != null)
                    if (isStart == false)
                      Positioned(
                        bottom: 5.0,
                        left: 5.0,
                        child: Container(
                          height: 100,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color(0x3FFF0C0D11),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'TOTAL DISTANCE',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                          'KM GOAL',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 25,
                                  child: Text(
                                    '${_info!.totalDistance}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 130,
                                  child: Text(
                                    '$yourGoal km',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
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
                                      setState(() {
                                        isStart = true;
                                      });
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
                        ),
                      ),
                  if (_info != null)
                    if (isStart)
                      Positioned(
                        bottom: 175,
                        left: 10.0,
                        child: InkWell(
                          onTap: () {
                            if (_originSubscription == null) {
                              _originSubscription = _originStreamController
                                  .stream
                                  .listen((newPosition) {
                                focusLocation(newPosition);
                              });
                            } else if (_originSubscription!.isPaused) {
                              _originSubscription!.resume();
                            } else {
                              _originSubscription!.pause();
                            }
                          },
                          child: Container(
                            width: 140,
                            height: 45,
                            decoration: BoxDecoration(
                              color: _originSubscription != null &&
                                      !_originSubscription!.isPaused
                                  ? Color.fromARGB(103, 12, 13, 17)
                                  : Color(0x3FFF0C0D11),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'FOCUS YOUR ',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'LOCATION',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  if (_info != null)
                    if (isStart)
                      Positioned(
                        bottom: 5.0,
                        left: 5.0,
                        child: Container(
                          height: 166,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color(0x3FFF0C0D11),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'TIME',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    _duration
                                        .toString()
                                        .split('.')
                                        .first
                                        .padLeft(8, "0"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'TRAVEL DISTANCE',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                        ),
                                        Text(
                                          directionsRespository.distance
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'AVG DISTANCE',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                        ),
                                        Text(
                                          avgSpeed == double.infinity
                                              ? 'Calculating...'
                                              : '${avgSpeed.toStringAsFixed(2)} km',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0x3ffFF0000),
                                    minimumSize: const Size(
                                      330,
                                      40,
                                    ),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isStart = true;
                                    });
                                    finish();
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
                              ],
                            ),
                          ),
                        ),
                      ),
                  Container(
                    height: 80,
                    width: 450,
                    decoration: const BoxDecoration(
                      color: Color(0x3fff0C0D11),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                        cursorColor: Colors.white,
                        controller: searchLocationController,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: 'Search your Destination...',
                          hintStyle: GoogleFonts.inter(
                            color: const Color(0x3ff454545),
                            fontSize: 14,
                          ),
                          suffix: IconButton(
                            onPressed: () async {
                              var placer = await DirectionsRespository()
                                  .getPlace(searchLocationController.text);
                              _goToPlace(placer);
                            },
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(
                    bottom: 90.0, right: 0.0), // adjust as needed
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  child: FloatingActionButton(
                    backgroundColor: Color.fromARGB(181, 255, 255, 255),
                    onPressed: () {
                      _googlemapController!.animateCamera(_info != null
                          ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
                          : CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                    widget.locationData!.latitude ?? 10.2899758,
                                    widget.locationData!.longitude ??
                                        123.861891),
                                zoom: 20.4746,
                              ),
                            ));
                    },
                    child: const Icon(Icons.location_searching,
                        size: 20.0), // adjust icon size as needed
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}











  // final LocationData? locationData;
  // final Users user;
  // final int goalDay;
  // final Goal30 goal30;
  // final int day;



        // if (_info != null)
        //             if (isStart == false)
        //               Positioned(
        //                 bottom: 5.0,
        //                 left: 5.0,
        //                 child: Container(
        //                   height: 100,
        //                   width: 350,
        //                   decoration: BoxDecoration(
        //                     color: Color(0x3FFF0C0D11),
        //                     borderRadius: BorderRadius.circular(15.0),
        //                   ),
        //                   child: Container(
        //                     margin: const EdgeInsets.all(10),
        //                     child: Stack(
        //                       children: [
        //                         Column(
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             const SizedBox(
        //                               height: 15,
        //                             ),
        //                             Row(
        //                               children: [
        //                                 const SizedBox(
        //                                   width: 10,
        //                                 ),
        //                                 Text(
        //                                   'TOTAL DISTANCE',
        //                                   style: Theme.of(context)
        //                                       .textTheme
        //                                       .titleLarge!
        //                                       .copyWith(
        //                                         color: Colors.white,
        //                                         fontSize: 10,
        //                                       ),
        //                                 ),
        //                                 const SizedBox(
        //                                   width: 40,
        //                                 ),
        //                                 Text(
        //                                   'KM GOAL',
        //                                   style: Theme.of(context)
        //                                       .textTheme
        //                                       .titleLarge!
        //                                       .copyWith(
        //                                         color: Colors.white,
        //                                         fontSize: 10,
        //                                       ),
        //                                 ),
        //                               ],
        //                             ),
        //                           ],
        //                         ),
        //                         Positioned(
        //                           bottom: 20,
        //                           left: 25,
        //                           child: Text(
        //                             '${_info!.totalDistance}',
        //                             style: Theme.of(context)
        //                                 .textTheme
        //                                 .titleLarge!
        //                                 .copyWith(
        //                                   color: Colors.white,
        //                                   fontSize: 20,
        //                                   fontWeight: FontWeight.bold,
        //                                 ),
        //                           ),
        //                         ),
        //                         Positioned(
        //                           bottom: 20,
        //                           left: 130,
        //                           child: Text(
        //                             '$yourGoal km',
        //                             style: Theme.of(context)
        //                                 .textTheme
        //                                 .titleLarge!
        //                                 .copyWith(
        //                                   color: Colors.white,
        //                                   fontSize: 20,
        //                                   fontWeight: FontWeight.bold,
        //                                 ),
        //                           ),
        //                         ),
        //                         Positioned(
        //                           right: 0,
        //                           child: ElevatedButton(
        //                             style: ElevatedButton.styleFrom(
        //                               backgroundColor: Color(0x3ffFF0000),
        //                               minimumSize: const Size(
        //                                 105,
        //                                 82,
        //                               ),
        //                               elevation: 0,
        //                               shape: RoundedRectangleBorder(
        //                                 borderRadius: BorderRadius.circular(20),
        //                               ),
        //                             ),
        //                             onPressed: () {
        //                               setState(() {
        //                                 isStart = true;
        //                               });
        //                               start();
        //                             },
        //                             child: Text(
        //                               'START',
        //                               style: GoogleFonts.inter(
        //                                 color: Colors.white,
        //                                 fontWeight: FontWeight.bold,
        //                                 fontSize: 20,
        //                               ),
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               ),