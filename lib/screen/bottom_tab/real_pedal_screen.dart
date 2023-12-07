import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ta_rides/models/directions_model.dart';
import 'package:ta_rides/models/real_location.dart';
import 'package:ta_rides/models/user_info.dart';

class RealPedalScreen extends StatefulWidget {
  const RealPedalScreen({
    super.key,
    this.locationData,
    required this.user,
  });

  final LocationData? locationData;
  final Users user;

  @override
  State<RealPedalScreen> createState() => _RealPedalScreenState();
}

class _RealPedalScreenState extends State<RealPedalScreen> {
  StreamSubscription<LocationData>? _locationSubscription;
  GoogleMapController? _googlemapController;
  Location location = Location();
  Location _location = Location();
  Marker? _origin;
  Directions? _info;
  late Future<void> _setMarkerFuture;

  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  Marker? _destination;

  @override
  void initState() {
    _setMarkerFuture = setMarker();

    _locationSubscription =
        _location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          position:
              LatLng(currentLocation.latitude!, currentLocation.longitude!),
        );

        polylineCoordinates
            .add(LatLng(currentLocation.latitude!, currentLocation.longitude!));

        PolylineId id = PolylineId('poly');
        Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.blue,
          points: polylineCoordinates,
          width: 16,
        );
        polylines[id] = polyline;
      });
    });
    super.initState();
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
    super.dispose();
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
          return Scaffold(
            backgroundColor: Color(0x3fff0C0D11),
            appBar: AppBar(
              title: Text(
                'Pedal',
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
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.locationData!.latitude ?? 10.2899758,
                        widget.locationData!.longitude ?? 123.861891),
                    zoom: 14.4746,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _googlemapController = controller;
                  },
                  markers: {
                    if (_origin != null) _origin!,
                    if (_destination != null) _destination!,
                  },
                  polylines: allPolylines,

// {
//                     if (_info != null)
//                       Polyline(
//                         polylineId: const PolylineId('overview_polyline'),
//                         color: Colors.red,
//                         width: 5,
//                         points: _info!.polylinePoints
//                             .map((e) => LatLng(e.latitude, e.longitude))
//                             .toList(),
//                       ),
//                   },
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
                  Positioned(
                    bottom: 20.0,
                    left: 10.0,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 8.0),
                        child: Text(
                          '${_info!.totalDistance}, ${_info!.totalDuration}',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(
                  bottom: 0.0, right: 40.0), // adjust as needed
              child: FloatingActionButton(
                backgroundColor: Color.fromARGB(164, 255, 255, 255),
                onPressed: () {
                  _googlemapController!.animateCamera(_info != null
                      ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
                      : CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(
                                widget.locationData!.latitude ?? 10.2899758,
                                widget.locationData!.longitude ?? 123.861891),
                            zoom: 14.4746,
                          ),
                        ));
                },
                child: Icon(Icons.location_searching),
              ),
            ),
          );
        }
      },
    );
  }
}
