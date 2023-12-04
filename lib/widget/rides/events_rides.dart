import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/rides_info.dart';
import 'package:intl/intl.dart';
import 'package:ta_rides/widget/rides/join_event.dart';

class EventRides extends StatelessWidget {
  const EventRides({
    super.key,
    required this.rides,
    required this.email,
  });

  final Rides rides;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (rides.enemyFinished == false)
          Container(
            height: 260,
            width: 500,
            margin: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JoinEvent(
                      rides: rides,
                      email: email,
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  Card(
                    color: const Color(0xff282828),
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    clipBehavior: Clip.hardEdge,
                    elevation: 10,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Challenge!',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: const Color(0x3ffFF0000),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  rides.communitytitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
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
                                        rides.userImage,
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
                                              "${rides.userFirstname} ${rides.userLastname}",
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
                                          ],
                                        ),
                                        Text(
                                          '@${rides.userUsername}',
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
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  rides.caption,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Color(0x3ff989898),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14,
                                      ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  DateFormat('h:mm a • d MMM yyyy')
                                      .format(rides.timePost.toDate()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Color(0x3ff989898),
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
                  Positioned(
                    top: 50,
                    right: 25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          15), // Adjust the value as needed
                      child: Image.network(
                        rides.communityImage,
                        height: 150,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        else if (rides.userWinner)
          Card(
            color: const Color(0xff282828),
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.hardEdge,
            elevation: 10,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ride ID: ${rides.ridesID}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Game Winner',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Color(0x3ffE8AA0A),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    rides.communitytitle,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      ClipOval(
                        child: Image.network(
                          rides.userImage,
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
                            "${rides.userFirstname.replaceRange(0, 1, rides.userFirstname[0].toUpperCase())} ${rides.userLastname.replaceRange(0, 1, rides.userLastname[0].toUpperCase())}",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            rides.userUsername,
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Color(0x3ff797979),
                    thickness: 2.0,
                    indent: 0,
                    endIndent: 0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    rides.communitytitle,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      ClipOval(
                        child: Image.network(
                          rides.enemyImage,
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
                            "${rides.enemyFirstname.replaceRange(0, 1, rides.enemyFirstname[0].toUpperCase())} ${rides.enemyLastname.replaceRange(0, 1, rides.enemyLastname[0].toUpperCase())}",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            rides.enemyUsername,
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
          )
        else if (rides.enemyWinner)
          Card(
            color: const Color(0xff282828),
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.hardEdge,
            elevation: 10,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ride ID: ${rides.ridesID}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    rides.communitytitle,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      ClipOval(
                        child: Image.network(
                          rides.userImage,
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
                            "${rides.userFirstname.replaceRange(0, 1, rides.userFirstname[0].toUpperCase())} ${rides.userLastname.replaceRange(0, 1, rides.userLastname[0].toUpperCase())}",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            rides.userUsername,
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Color(0x3ff797979),
                    thickness: 2.0,
                    indent: 0,
                    endIndent: 0,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Game Winner',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Color(0x3ffE8AA0A),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    rides.communitytitle,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      ClipOval(
                        child: Image.network(
                          rides.enemyImage,
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
                            "${rides.enemyFirstname.replaceRange(0, 1, rides.enemyFirstname[0].toUpperCase())} ${rides.enemyLastname.replaceRange(0, 1, rides.enemyLastname[0].toUpperCase())}",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            rides.enemyUsername,
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
          ),
      ],
    );
  }
}
