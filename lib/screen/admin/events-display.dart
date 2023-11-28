import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ta_rides/models/rides_info.dart';
import 'package:ta_rides/screen/admin/events-informations.dart';

class EventsDisplay extends StatefulWidget {
  const EventsDisplay({
    super.key,
    required this.rides,
  });

  final Rides rides;

  @override
  State<EventsDisplay> createState() => _EventsDisplayState();
}

class _EventsDisplayState extends State<EventsDisplay> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventsInformations(
              rides: widget.rides,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 365,
                height: 165, // Adjust the height as needed
                decoration: ShapeDecoration(
                  color: const Color.fromARGB(255, 40, 40, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        top: 8,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " CHALLENGE!",
                              style: GoogleFonts.montserrat(
                                color: const Color.fromARGB(255, 255, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              "  ${widget.rides.communitytitle}", // Replace with the actual property name
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "   wants to challenge your community \n   to a race.", // Replace with the actual property name
                              style: GoogleFonts.montserrat(
                                color: const Color.fromARGB(255, 152, 152, 152),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "   ${DateFormat('h:mm a dd MMM yyyy').format(widget.rides.timePost.toDate())}", // Format the date and time // Replace with the actual property name  // Replace with the actual property name
                              style: GoogleFonts.montserrat(
                                color: const Color.fromARGB(255, 152, 152, 152),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 276,
                  top: 10,
                ),
                child: Container(
                  width: 80,
                  height: 147, // Adjust the height as needed
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.rides.communityImage),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
