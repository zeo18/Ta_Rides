import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ta_rides/models/rides_info.dart';
import 'package:ta_rides/widget/all_controller/community_controller.dart';
import 'package:ta_rides/widget/all_controller/rides_controller.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';
import 'package:ta_rides/widget/rides/joined_event.dart';

class JoinEvent extends StatefulWidget {
  const JoinEvent({
    super.key,
    required this.rides,
    required this.email,
  });

  final Rides rides;
  final String email;

  @override
  State<JoinEvent> createState() => _JoinEventState();
}

class _JoinEventState extends State<JoinEvent> {
  UserController userController = UserController();
  CommunityController communityController = CommunityController();

  @override
  void initState() {
    userController.setEmail(widget.email);
    userController.getUser(widget.email);
    communityController.getCommunityAndUser(widget.email);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x3FFF0C0D11),
      appBar: AppBar(
        backgroundColor: Color(0x3FFF0C0D11),
        title: Text(
          'Events',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Card(
                color: const Color(0xff0C0D11),
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(
                    color: Color(0x3fff282828),
                    width: 2,
                  ),
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                              widget.rides.communitytitle,
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
                                          "${widget.rides.userFirstname} ${widget.rides.userLastname}",
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
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.rides.caption,
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
                                  .format(widget.rides.timePost.toDate()),
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
                        onPressed: () async {
                          print(widget.rides.ridesID);
                          final rideDoc = await FirebaseFirestore.instance
                              .collection('rides')
                              .where('ridesID', isEqualTo: widget.rides.ridesID)
                              .get();

                          if (rideDoc.docs.isNotEmpty) {
                            await rideDoc.docs.first.reference.update({
                              'isEnemy': true,
                              'enemyFirstname': userController.user.firstName,
                              'enemyLastname': userController.user.lastName,
                              'enemyUsername': userController.user.username,
                              'enemyImage': userController.user.userImage,
                              'enemyCommunityId':
                                  communityController.community!.id,
                              'enemyCommunityTitle':
                                  communityController.community!.title,
                              'enemyCommunityImage':
                                  communityController.community!.coverImage,
                            }).then((value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => JoinedEvent(
                                    rides: widget.rides,
                                    email: widget.email,
                                  ),
                                ),
                              );
                            });
                          } else {
                            print('No documents found with the given ridesId');
                          }
                        },
                        child: Text(
                          'Join',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 40,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(15), // Adjust the value as needed
                  child: Image.network(
                    widget.rides.communityImage,
                    height: 150,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
