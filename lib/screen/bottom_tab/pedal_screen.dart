// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ta_rides/models/location_info.dart';
import 'package:ta_rides/screen/auth/logInPage.dart';
import 'package:ta_rides/widget/pedal/route.dart';
import 'package:ta_rides/widget/pedal/saved_route.dart';

class PedalScreen extends StatefulWidget {
  const PedalScreen({super.key});

  @override
  State<PedalScreen> createState() => _PedalScreenState();
}

class _PedalScreenState extends State<PedalScreen> {
  TextEditingController pinPoint1stController = TextEditingController();
  TextEditingController pinPoint2ndController = TextEditingController();
  int selectTab = 0;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late GoogleMapController _googleController;
  Location _locationController = new Location();

  List<Marker> _markers = [];
  List<Marker> _markers2 = [];
  Set<Marker> _currentLocation = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  void selectedPage(int index) {
    setState(() {
      selectTab = index;
    });
    print(selectTab);
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    _setMarker(LatLng(37.42796133580664, -122.085749655962));
    super.initState();
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Pedal',
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
                // markers: {
                //   _kGooglePlexMarker,
                //   // _kLakeMarker,
                // },
                // // polylines: {
                // //   _kPolyline,
                // // },
                // // polygons: {
                // //   _kPolygon,
                // // },
                onTap: (point) {
                  setState(() {
                    polygonLatLngs.add(point);
                    _setPolygon();
                  });
                },
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _googleController = controller;
                  _controller.complete(controller);
                },
              ),
            ),
            if (selectPoint && selectPoint2)
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
                            Expanded(
                              child: TabBarView(
                                children: [
                                  SetRoute(
                                    pinPoint1st: pinPoint1stController.text,
                                    pinPoint2nd: pinPoint2ndController.text,
                                    selectPinPoint: selectPinPoint,
                                    selectPinPoint2: selectPinPoint2,
                                    setPlace: ((lat, lng, boundsNe, boundsSw) =>
                                        _setPlace(
                                            lat, lng, boundsNe, boundsSw)),
                                    setPolyline: (points) =>
                                        _setPolyline(points),
                                  ),
                                  SavedRoute(),
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
                          '1st Pin point',
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
                        // Container(
                        //   height: 30,
                        //   width: 80,
                        //   decoration: BoxDecoration(
                        //     color: const Color(0x3ffff0000),
                        //     borderRadius: BorderRadius.circular(50),
                        //   ),
                        //   child: TextButton(
                        //     onPressed: () {},
                        //     child: Text(
                        //       'Done',
                        //       style:
                        //           Theme.of(context).textTheme.bodyLarge!.copyWith(
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: 13,
                        //               ),
                        //     ),
                        //   ),
                        // )
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
                              // onChanged: (value) {
                              //   _setMarker(LatLng(
                              //     double.parse(pinPoint1stController.text),
                              //     double.parse(pinPoint2ndController.text),
                              //   ));
                              // },
                              decoration: InputDecoration(
                                label: Text(
                                  'Search your 1st Pin point...',
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: selectBack2,
                          icon: Icon(Icons.arrow_back),
                        ),
                        IconButton(
                            onPressed: () async {
                              var direction = await LocationService()
                                  .getDirections(pinPoint1stController.text,
                                      pinPoint2ndController.text);

                              _setPlace(
                                direction['start_location']['lat'],
                                direction['start_location']['lng'],
                                direction['bounds_ne'],
                                direction['bounds_sw'],
                              );

                              _setPolyline(direction['polyline_decoded']);
                            },
                            icon: Icon(Icons.arrow_circle_up_sharp)),
                        Text(
                          '2nd Pin point',
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
                        // Container(
                        //   height: 30,
                        //   width: 80,
                        //   decoration: BoxDecoration(
                        //     color: const Color(0x3ffff0000),
                        //     borderRadius: BorderRadius.circular(50),
                        //   ),
                        //   child: TextButton(
                        //     onPressed: () {},
                        //     child: Text(
                        //       'Done',
                        //       style:
                        //           Theme.of(context).textTheme.bodyLarge!.copyWith(
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: 13,
                        //               ),
                        //     ),
                        //   ),
                        // )
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
                              // onChanged: (value) {
                              //   _setMarker(LatLng(
                              //     double.parse(pinPoint2ndController.text),
                              //     double.parse(pinPoint1stController.text),
                              //   ));
                              // },
                              cursorColor: Colors.white,
                              controller: pinPoint2ndController,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                label: Text(
                                  'Input your 2nd Pin point...',
                                  style: GoogleFonts.inter(
                                    color: const Color(0x3ff454545),
                                    fontSize: 12,
                                  ),
                                ),
                                suffix: IconButton(
                                  onPressed: () async {
                                    var place = await LocationService()
                                        .getPlace(pinPoint2ndController.text);
                                    _goToPlace(place);
                                  },
                                  // () async {
                                  //   var place = await LocationService()
                                  //       .getPlace(pinPoint2ndController.text);
                                  //   _goToPlace(place);
                                  // },
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
          ],
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: const Text('To the lake!'),
        //   icon: const Icon(Icons.directions_boat),
        // ),

        floatingActionButton: Column(
          children: [
            if (selectPoint == false)
              Padding(
                padding: EdgeInsets.fromLTRB(0, 700, 0, 0),
                child: FloatingActionButton.extended(
                  onPressed: () async {
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
    );
  }

  Future<void> getLocationUpdates() async {
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

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        _googleController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(
                    currentLocation.latitude!, currentLocation.longitude!),
                zoom: 15.5),
          ),
        );
        _markers.clear();

        _currentLocation.add(Marker(
            markerId: MarkerId('currentLocation'),
            position:
                LatLng(currentLocation.latitude!, currentLocation.longitude!)));

        setState(() {});
      }
      // _googleController.animateCamera(
      //   CameraUpdate.newCameraPosition(
      //     CameraPosition(
      //         target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
      //         zoom: 15.5),
      //   ),
      // );
      // _markers.clear();

      // _currentLocation.add(Marker(
      //     markerId: MarkerId('currentLocation'),
      //     position: LatLng(currentLocation.latitude!, currentLocation.longitude!)));

      // setState(() {});
    });
  }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permantly denied, we cannot request permissions.');
  //   }

  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission != LocationPermission.whileInUse &&
  //         permission != LocationPermission.always) {
  //       return Future.error(
  //           'Location permissions are denied (actual value: $permission).');
  //     }
  //   }

  //   return await Geolocator.getCurrentPosition();
  // }

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

// static final Marker _kGooglePlexMarker = Marker(
//   markerId: MarkerId('_kGooglePlex'),
//   infoWindow: InfoWindow(title: 'Google Plex'),
//   icon: BitmapDescriptor.defaultMarker,
//   position: LatLng(37.42796133580664, -122.085749655962),
// );

// static const CameraPosition _kLake = CameraPosition(
//     bearing: 192.8334901395799,
//     target: LatLng(37.43296265331129, -122.08832357078792),
//     tilt: 59.440717697143555,
//     zoom: 19.151926040649414);

// static final Marker _kLakeMarker = Marker(
//   markerId: MarkerId('_kLakeMarker'),
//   infoWindow: InfoWindow(title: 'Lake'),
//   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//   position: LatLng(37.43296265331129, -122.08832357078792),
// );

// static final Polyline _kPolyline = Polyline(
//     polylineId: PolylineId('_kPolyline'),
//     points: const [
//       LatLng(37.42796133580664, -122.085749655962),
//       LatLng(37.43296265331129, -122.08832357078792),
//     ],
//     width: 5);

// static final Polygon _kPolygon = Polygon(
//   polygonId: PolygonId('_kPolygon'),
//   points: const [
//     LatLng(37.43296265331129, -122.08832357078792),
//     LatLng(37.42796133580664, -122.085749655962),
//     LatLng(37.418, -122.092),
//     LatLng(37.435, -122.092),
//   ],
//   strokeWidth: 5,
//   fillColor: Colors.transparent,
// );
