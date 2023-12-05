import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:ta_rides/models/rides_info.dart';
import 'package:location/location.dart' as loc;
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/rides/google_maps.dart';
import 'package:ta_rides/widget/rides/user_googlemaps.dart';

class UserRides extends StatefulWidget {
  const UserRides({
    super.key,
    required this.rides,
    required this.user,
  });

  final Rides rides;
  final Users user;

  @override
  State<UserRides> createState() => _UserRidesState();
}

class _UserRidesState extends State<UserRides> {
  LocationData? _locationData;
  late bool _serviceEnabled;
  loc.Location location = new loc.Location();
  late PermissionStatus _permissionGranted;

  @override
  void initState() {
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
              'userLat': latitude,
              'userLng': longitude,
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                // Text(
                //   'DISTANCE: ${widget.rides.distance} km',
                //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 25,
                //       ),
                // ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Your Team',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.rides.enemyCommunityTitle,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              ClipOval(
                                child: Image.network(
                                  widget.rides.userImage,
                                  height: 45,
                                  width: 45,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${widget.rides.userFirstname.replaceRange(0, 1, widget.rides.userFirstname[0].toUpperCase())} ${widget.rides.userLastname.replaceRange(0, 1, widget.rides.userLastname[0].toUpperCase())}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
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
                                    '@${widget.rides.userUsername}',
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
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Enemy Team',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (widget.rides.isEnemy == true)
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
                              widget.rides.enemyCommunityTitle,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                ClipOval(
                                  child: Image.network(
                                    widget.rides.enemyImage,
                                    height: 45,
                                    width: 45,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${widget.rides.enemyFirstname.replaceRange(0, 1, widget.rides.enemyFirstname[0].toUpperCase())} ${widget.rides.enemyLastname.replaceRange(0, 1, widget.rides.enemyLastname[0].toUpperCase())}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
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
                                      '@${widget.rides.enemyUsername}',
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
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
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
                    _locationData != null
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GoogleMaps(
                                locationData: _locationData,
                                ride: widget.rides,
                                isUser: true,
                                email: widget.user.email,
                              ),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                  child: Text(
                    'Start',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
