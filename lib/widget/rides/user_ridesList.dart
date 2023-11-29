import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ta_rides/models/rides_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/rides/user_rides.dart';

class UserRideList extends StatefulWidget {
  const UserRideList({
    super.key,
    required this.ride,
    required this.user,
  });

  final Rides ride;
  final Users user;

  @override
  State<UserRideList> createState() => _UserRideListState();
}

class _UserRideListState extends State<UserRideList> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color(0xff282828),
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 10,
        child: InkWell(
          onTap: () async {
            final join = await FirebaseFirestore.instance
                .collection('rides')
                .where('ridesID', isEqualTo: widget.ride.ridesID)
                .get();

            await join.docs.first.reference.update({
              'isUser': true,
            }).then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserRides(
                    rides: widget.ride,
                    user: widget.user,
                  ),
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'THIS USER HAS ACCEPTED YOUR CHALLENGE!',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Color(0x3ffE8AA0A),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Ride ID: ${widget.ride.ridesID}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Distance: ${widget.ride.distance} km',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.ride.enemyCommunityTitle,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    ClipOval(
                      child: Image.network(
                        widget.ride.enemyImage,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.ride.enemyFirstname.replaceRange(0, 1, widget.ride.enemyLastname[0].toUpperCase())} ${widget.ride.enemyLastname.replaceRange(0, 1, widget.ride.enemyLastname[0].toUpperCase())}",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          widget.ride.enemyUsername,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: const Color(0x3ff797979),
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
