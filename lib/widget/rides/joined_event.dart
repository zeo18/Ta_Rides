import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/rides_info.dart';
import 'package:ta_rides/widget/all_controller/rides_controller.dart';

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

  @override
  void initState() {
    ridesController.getUserRide(widget.rides.ridesID);
    super.initState();
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        onPressed: () {},
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
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
