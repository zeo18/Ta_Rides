import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ta_rides/models/directions_model.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'dart:convert' as convert;

class DirectionsRespository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRespository({Dio? dio}) : _dio = dio ?? Dio();
  final String key = 'AIzaSyCi5Ei7cqIqlf7G7K2i4FhoJsLJ-1CQIsE';

  Location location = Location();
  LocationData? startLocation;
  StreamSubscription<LocationData>? locationSubscription;
  String? distance;
  double? distance1;

  void initStartLocation() async {
    startLocation = await location.getLocation();
    locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) async {
      Map<String, dynamic>? result = await getDistance(
        currentLocation.latitude!,
        currentLocation.longitude!,
        startLocation!.latitude!,
        startLocation!.longitude!,
      );
      if (result?['distance'] != null && result!['distance'] is String) {
        String distanceString = result['distance'].replaceAll('km', '');
        print('Parsing: $distanceString');
        distance1 = double.tryParse(distanceString) ?? 0.0;
      }

      distance = result?['distance'];

      print('Distance from starting location: $distance');
    });
  }

  Future<Directions?> getDirection({
    required LatLng orgin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${orgin.latitude},${orgin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': 'AIzaSyCi5Ei7cqIqlf7G7K2i4FhoJsLJ-1CQIsE',
      },
    );

    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;
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

  Future<Map<String, dynamic>?> getDistance(
    double startingLat,
    double startinglng,
    double currentLat,
    double currentLng,
  ) async {
    // Get current location
    String startLoc = '${startingLat},${startinglng}';
    String currentLoc = '${currentLat},${currentLng}';
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
}
