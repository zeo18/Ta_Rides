import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

import 'dart:convert' as convert;

class LocationService {
  final String key = 'AIzaSyCi5Ei7cqIqlf7G7K2i4FhoJsLJ-1CQIsE';

  Location location = Location();
  LocationData? startLocation;
  StreamSubscription<LocationData>? locationSubscription;
  String? distance;

  LocationService() {
    initLocation();
  }

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
    });
  }

  Future<LocationData> getLocation() async {
    Location location = Location();
    LocationData currentLocation = await location.getLocation();
    print('Current location: $currentLocation');
    return currentLocation;
  }

  void updateStartLocation(LocationData newLocation) {
    print('Updating start location: $newLocation');
    startLocation = newLocation;
  }

  Future<String> getPlaceId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var placeId = json['candidates'][0]['place_id'] as String;

    print(placeId);

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final String placeId = await getPlaceId(input);
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var results = json['result'] as Map<String, dynamic>;

    print(results);
    return results;
  }

  Future<Map<String, dynamic>?> getDirections(
      String destination, String text) async {
    Location location = new Location();

    final double latOrigin = 10.3641;
    final double lngOrigin = 123.8830;

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
    print(origin);
    print('destination: $destination');
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&mode=walking&alternatives=true&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    print(json['routes']);
    print(response.statusCode);

    if (json['routes'].isEmpty) {
      throw Exception('No routes found for the given origin and destination');
    }

    String distance = json['routes'][0]['legs'][0]['distance']['text'];

    // Calculate distance between origin and current user location
    double distanceToUserLocation = calculateDistance(latOrigin, latOrigin,
        _locationData.latitude!, _locationData.longitude!);

    Map<String, dynamic> results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points']),
      'distance': distance,
      'distance_to_user_location': distanceToUserLocation,
    };
    print(results);

    return results;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = math.cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * math.asin(math.sqrt(a));
  }

  Future<Map<String, dynamic>?> getDirectionOriginUser(
      double latCurrentLocation,
      double lngCurrentLocation,
      double latStartingPoint,
      double lngStartingPoint) async {
    Location location = new Location();

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

  void dispose() {
    locationSubscription?.cancel();
  }
}
