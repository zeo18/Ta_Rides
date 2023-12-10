import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ta_rides/models/pedal_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';
import 'package:ta_rides/widget/profile_Tabs/history_location.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProgressTabs extends StatelessWidget {
  const ProgressTabs({
    super.key,
    required this.user,
    required this.pedal,
  });

  final UserController user;
  final Pedal pedal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Card(
              color: const Color(0xff282828),
              margin: const EdgeInsets.symmetric(horizontal: 0.1, vertical: 3),
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => HistoryLocation(
                              pedal: pedal,
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: pedal.location,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 72,
            child: Text(
              'DATE: ${DateFormat('dd/MM/yyyy').format(pedal.startTime.toDate())}',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
            ),
          ),
          Positioned(
            top: 135,
            right: 24,
            child: Row(
              children: [
                Text(
                  'START TIME',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  'END TIME',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 155,
            right: 10,
            child: Row(
              children: [
                Text(
                  DateFormat('hh:mm:ss a').format(pedal.startTime.toDate()),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat('hh:mm:ss a').format(pedal.endTime.toDate()),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 60,
            right: 8,
            child: Row(
              children: [
                Text(
                  'TOTAL DISTANCE',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'TRAVEL DISTANCE',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 80,
            right: 24,
            child: Row(
              children: [
                Text(
                  pedal.totalDistance,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Text(
                  pedal.travelDistance,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 210,
            right: 35,
            child: Row(
              children: [
                Text(
                  'AVERAGE SPEED',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Text(
                  'TIMER',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 230,
            right: 20,
            child: Row(
              children: [
                Text(
                  '${pedal.avgSpeed.toStringAsFixed(1)} km',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Text(
                  pedal.timer,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
