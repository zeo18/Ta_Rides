import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class UserGoogleMaps extends StatefulWidget {
  const UserGoogleMaps({
    super.key,
    required this.locationData,
  });
  final LocationData? locationData;
  @override
  State<UserGoogleMaps> createState() => _UserGoogleMapsState();
}

class _UserGoogleMapsState extends State<UserGoogleMaps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0D11),
        automaticallyImplyLeading: false,
        title: Text(
          'Google Maps',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.locationData!.latitude ?? 10.2899758,
              widget.locationData!.longitude ?? 123.861891),
          zoom: 14.4746,
        ),
      ),
    );
  }
}
