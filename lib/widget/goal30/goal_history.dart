import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ta_rides/data/goal30_data.dart';
import 'package:ta_rides/models/goal30_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/all_controller/goal30_controller.dart';

class Goal30History extends StatefulWidget {
  Goal30History({
    super.key,
    required this.user,
    required this.day,
    required this.goal30,
  });

  final Users user;
  int day;
  final Goal30 goal30;

  @override
  State<Goal30History> createState() => _Goal30HistoryState();

  static fromDocument(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {}
}

class _Goal30HistoryState extends State<Goal30History> {
  Goal30Controller goal30Controller = Goal30Controller();

  @override
  void initState() {
    goal30Controller.getGoal30History(
        widget.user.username, widget.day, widget.goal30.goalLenght);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      goal30Controller.getGoal30History(
          widget.user.username, widget.day, widget.goal30.goalLenght);
      widget.day;
    });
    print(['Dayyy', widget.day]);
    return AnimatedBuilder(
        animation: goal30Controller,
        builder: (context, snapshot) {
          if (goal30Controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            children: [
              const SizedBox(
                height: 300,
                width: 400,
              ),
              Positioned(
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var index = 0;
                        index < goal30Controller.goal30Histories.length;
                        index++)
                      if (widget.day ==
                          goal30Controller.goal30Histories[index].day)
                        Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: goal30Controller
                                      .goal30Histories[index].location,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                child: Column(
                  children: [
                    for (var index = 0;
                        index < goal30Controller.goal30Histories.length;
                        index++)
                      if (widget.day ==
                          goal30Controller.goal30Histories[index].day)
                        Text(
                          DateFormat('MM/dd/yyyy').format(goal30Controller
                              .goal30Histories[index].startTime
                              .toDate()),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                        ),
                  ],
                ),
              ),
              Positioned(
                right: 20,
                child: Column(
                  children: [
                    for (var index = 0;
                        index < goal30Controller.goal30Histories.length;
                        index++)
                      if (widget.day ==
                          goal30Controller.goal30Histories[index].day)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'STARTING TIME',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                    ),
                                    Text(
                                      DateFormat('HH:mm:ss').format(
                                          goal30Controller
                                              .goal30Histories[index].startTime
                                              .toDate()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'END TIME',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      DateFormat('HH:mm:ss').format(
                                          goal30Controller
                                              .goal30Histories[index].endTime
                                              .toDate()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'AVERAGE SPEED',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                    ),
                                    Text(
                                      '${goal30Controller.goal30Histories[index].avgSpeed.toStringAsFixed(1)} km',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'TIME',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                    ),
                                    Text(
                                      '${goal30Controller.goal30Histories[index].timer}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 35,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'TRAVELLED DISTANCE',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                    ),
                                    Text(
                                      '${goal30Controller.goal30Histories[index].travelDistance}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 50,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'TOTAL DISTANCE',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                    ),
                                    Text(
                                      '${goal30Controller.goal30Histories[index].totalDistance}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                  ],
                ),
              )
            ],
          );
        });
  }
}
