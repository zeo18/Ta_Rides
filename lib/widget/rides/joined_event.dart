import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:ta_rides/models/rides_info.dart';
import 'package:ta_rides/widget/all_controller/rides_controller.dart';
import 'package:location/location.dart' as loc;
import 'package:ta_rides/widget/rides/google_maps.dart';
import 'package:ta_rides/widget/rides/realGooglemap.dart';
import 'package:http/http.dart' as http;

class JoinedEvent extends StatefulWidget {
  const JoinedEvent({
    super.key,
    required this.rides,
    required this.email,
  });

  final Rides rides;
  final String email;

  @override
  State<JoinedEvent> createState() => _JoinedEventState();
}

class _JoinedEventState extends State<JoinedEvent> {
  RidesController ridesController = RidesController();
  LocationData? _locationData;
  late bool _serviceEnabled;
  loc.Location location = new loc.Location();
  late PermissionStatus _permissionGranted;

  @override
  void initState() {
    ridesController.getUserRide(widget.rides.ridesID);
    initializeLocation();
    super.initState();
  }

  void initializeLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    if (mounted) {
      setState(() {
        _locationData = _locationData;
      });
    }

    double? latitude = _locationData?.latitude;
    double? longitude = _locationData?.longitude;
    FirebaseFirestore.instance
        .collection('rides')
        .where('ridesID', isEqualTo: widget.rides.ridesID)
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            element.reference.update({
              'enemyLat': latitude,
              'enemyLng': longitude,
            });
          },
        );
      },
    );
  }

  Future<Uint8List> _loadImage(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Uint8List originalBytes = response.bodyBytes;
      final List<int> resizedBytes =
          await FlutterImageCompress.compressWithList(
        originalBytes,
        minHeight: 100,
        minWidth: 100,
        quality: 100,
      );
      return Uint8List.fromList(resizedBytes);
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            final rideDoc = await FirebaseFirestore.instance
                .collection('rides')
                .where('ridesID', isEqualTo: widget.rides.ridesID)
                .get();
            await rideDoc.docs.first.reference.update({
              'isEnemy': false,
              'enemyFirstname': '',
              'enemyLastname': '',
              'enemyUsername': '',
              'enemyImage': '',
              'enemyCommunityId': '',
              'enemyCommunityTitle': '',
              'enemyCommunityImage': '',
            });

            Navigator.pop(context);
          },
        ),
        title: Text(
          'Rides',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: const Color(0x3ff0C0D11),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Engage in a wide range of challenges and activities to earn valuable achievements and rewards!',
              style: GoogleFonts.inter(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            AnimatedBuilder(
                animation: ridesController,
                builder: (context, snapshot) {
                  if (ridesController.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Enemy Team',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Container(
                        height: 150,
                        width: 500,
                        child: Card(
                          color: const Color(0xff282828),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.hardEdge,
                          elevation: 10,
                          child: Container(
                            margin: const EdgeInsets.all(25),
                            child: Column(
                              children: [
                                if (ridesController.ride.isUser)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ridesController
                                            .ride.enemyCommunityTitle,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ClipOval(
                                            child: Image.network(
                                              ridesController.ride.userImage,
                                              height: 45,
                                              width: 45,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${ridesController.ride.userFirstname.replaceRange(0, 1, ridesController.ride.userFirstname[0].toUpperCase())} ${ridesController.ride.userLastname.replaceRange(0, 1, ridesController.ride.userLastname[0].toUpperCase())}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 14,
                                                        ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Icon(Icons.verified,
                                                      color: Colors.green,
                                                      size: 15)
                                                ],
                                              ),
                                              Text(
                                                '@${ridesController.ride.userUsername}',
                                                style: GoogleFonts.inter(
                                                  fontSize: 15,
                                                  color: Color(0x3ff797979),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                else
                                  Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Text(
                                          'Host hast not joined yet',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 14,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Your Team',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (ridesController.ride.isEnemy == true)
                        Container(
                          height: 150,
                          width: 500,
                          child: Card(
                            color: const Color(0xff282828),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            clipBehavior: Clip.hardEdge,
                            elevation: 10,
                            child: Container(
                              margin: const EdgeInsets.all(25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ridesController.ride.enemyCommunityTitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      ClipOval(
                                        child: Image.network(
                                          ridesController.ride.enemyImage,
                                          height: 45,
                                          width: 45,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${ridesController.ride.enemyFirstname.replaceRange(0, 1, ridesController.ride.enemyFirstname[0].toUpperCase())} ${ridesController.ride.enemyLastname.replaceRange(0, 1, ridesController.ride.enemyLastname[0].toUpperCase())}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 14,
                                                    ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Icon(Icons.verified,
                                                  color: Colors.green, size: 15)
                                            ],
                                          ),
                                          Text(
                                            '@${ridesController.ride.enemyUsername}',
                                            style: GoogleFonts.inter(
                                              fontSize: 15,
                                              color: Color(0x3ff797979),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      else
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              Text(
                                'No Compitetor',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 80,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ridesController.ride.isUser
                              ? Color(0x3ffFF0000)
                              : Color(0x3ff797979),
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
                          final Uint8List originIcon =
                              await _loadImage(widget.rides.userImage);
                          final Uint8List enemyIcon =
                              await _loadImage(widget.rides.enemyImage);

                          _locationData != null
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RealGoogleMap(
                                      locationData: _locationData,
                                      ride: widget.rides,
                                      isUser: false,
                                      enemyIcon: enemyIcon,
                                      originIcon: originIcon,
                                      email: widget.email,
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                );
                        },
                        child: Text(
                          'Start',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                        onPressed: () {
                          setState(() {
                            ridesController.getUserRide(widget.rides.ridesID);
                          });
                        },
                        child: Text(
                          'Refresh',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
