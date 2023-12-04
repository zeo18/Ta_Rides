import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/widget/all_controller/rides_controller.dart';
import 'package:ta_rides/widget/rides/events_rides.dart';
import 'package:ta_rides/widget/rides/finished_rides.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({
    super.key,
    required this.email,
    required this.community,
  });

  final String email;
  final Community? community;

  @override
  State<EventsTab> createState() {
    return _EventsTabState();
  }
}

class _EventsTabState extends State<EventsTab> {
  RidesController ridesController = RidesController();

  @override
  void initState() {
    ridesController.getRides(widget.community!.id);
    ridesController.getFinishedRides(widget.community!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4,
              indicatorColor: const Color(0x3ffff0000),
              labelColor: const Color(0x3ffff0000),
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  child: Text(
                    'Rides',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Tab(
                  child: Text(
                    'History Challenge',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    color: const Color(0xfff0C0D11),
                    child: AnimatedBuilder(
                      animation: ridesController,
                      builder: (context, snapshot) {
                        if (ridesController.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                          itemCount: ridesController.rides.length,
                          itemBuilder: (context, index) {
                            final ride = ridesController.rides[index];
                            final duration = DateTime.now()
                                .difference(ride.timePost.toDate());
                            if (duration.inHours >= 5 && !ride.isEnemy) {
                              // Delete the ride from Firebase
                              FirebaseFirestore.instance
                                  .collection('rides')
                                  .doc(ride.ridesID)
                                  .delete();
                              // Remove the ride from the list
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                setState(() {
                                  ridesController.rides.removeAt(index);
                                });
                              });
                            }
                            return EventRides(
                              rides: ride,
                              email: widget.email,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  AnimatedBuilder(
                      animation: ridesController,
                      builder: (context, snapshot) {
                        if (ridesController.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ListView.builder(
                          itemCount: ridesController.finishRides.length,
                          itemBuilder: (context, index) => FinishedRides(
                              rides: ridesController.finishRides[index],
                              email: widget.email),
                        );
                      }),
                ],
              ),
            ),
          ],
        ));

    // Container(
    //     color: const Color(0xfff0C0D11),
    //     child: AnimatedBuilder(
    //       animation: ridesController,
    //       builder: (context, snapshot) {
    //         if (ridesController.isLoading) {
    //           return const Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         }
    //         return ListView.builder(
    //           itemCount: ridesController.rides.length,
    //           itemBuilder: (context, index) {
    //             final ride = ridesController.rides[index];
    //             final duration =
    //                 DateTime.now().difference(ride.timePost.toDate());
    //             if (duration.inHours >= 5 && !ride.isEnemy) {
    //               // Delete the ride from Firebase
    //               FirebaseFirestore.instance
    //                   .collection('rides')
    //                   .doc(ride.ridesID)
    //                   .delete();
    //               // Remove the ride from the list
    //               WidgetsBinding.instance.addPostFrameCallback((_) {
    //                 setState(() {
    //                   ridesController.rides.removeAt(index);
    //                 });
    //               });
    //             }
    //             return EventRides(
    //               rides: ride,
    //               email: widget.email,
    //             );
    //           },
    //         );
    //       },
    //     ));
  }
}
        // Container(
        //   height: 200,
        //   width: 500,
        //   margin: const EdgeInsets.all(10),
        //   child: Card(
        //     color: const Color(0xff282828),
        //     margin: const EdgeInsets.all(10),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //     clipBehavior: Clip.hardEdge,
        //     elevation: 10,
        //     child: Container(
        //       margin: const EdgeInsets.all(10),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Challenge!',
        //             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        //                 color: const Color(0x3ffFF0000),
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 25),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // )
