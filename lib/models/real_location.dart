import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ta_rides/models/directions_model.dart';

class DirectionsRespository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRespository({Dio? dio}) : _dio = dio ?? Dio();

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
}
