import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class LocationServicer extends ChangeNotifier {
  Location location = Location();
  LocationData? startLocation;
  StreamSubscription<LocationData>? locationSubscription;
  String? distance;

  get http => null;

  void initLocation() async {
    startLocation = await location.getLocation();
    locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) async {
      Map<String, dynamic>? result = await getDirectionOriginUser(
        currentLocation.latitude!,
        currentLocation.longitude!,
        startLocation!.latitude!,
        startLocation!.longitude!,
      );
      distance = result?['distance'];
      print('Distance from starting location: $distance');
      notifyListeners(); // Notify listeners about the change
    });
  }

  Future<Map<String, dynamic>?> getDirectionOriginUser(
      double latCurrentLocation,
      double lngCurrentLocation,
      double latStartingPoint,
      double lngStartingPoint) async {
    Location location = new Location();

    String key = 'AIzaSyCi5Ei7cqIqlf7G7K2i4FhoJsLJ-1CQIsE';
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    String origin = '${_locationData.latitude},${_locationData.longitude}';
    print('Starting point location: $origin');

    // Get current location
    String startLoc = '${latStartingPoint},${lngStartingPoint}';
    String currentLoc = '${latCurrentLocation},${lngCurrentLocation}';
    print('Current location: $currentLoc');

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$currentLoc&destination=$startLoc&mode=walking&alternatives=true&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    print(json['routes']);
    print(response.statusCode);

    if (json['routes'].isEmpty) {
      throw Exception('No routes found for the given origin and destination');
    }
    String distance = json['routes'][0]['legs'][0]['distance']['text'];

    print('Extracted distance: $distance');
    Map<String, dynamic> results = {
      'distance': distance,
    };

    return results;
  }
  // Your existing code...
}
