import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ta_rides/models/rides_info.dart';
import 'package:ta_rides/screen/admin/admin_user.dart';

class EventsInformations extends StatefulWidget {
  const EventsInformations({
    super.key,
    required this.rides,
  });

  final Rides rides;
  @override
  State<EventsInformations> createState() => _EventsInformationsState();
}

class _EventsInformationsState extends State<EventsInformations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 13, 17),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 13, 17),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Events',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              final delete = await FirebaseFirestore.instance
                  .collection('rides')
                  .where('ridesID', isEqualTo: widget.rides.ridesID)
                  .get();

              await delete.docs.first.reference.delete().then(
                    (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const SuperAdminScreen(),
                      ),
                    ),
                  );
            },
            child: SizedBox(
              width: 120,
              height: 30,
              child: Stack(
                children: [
                  Positioned(
                    right: 10,
                    top: 15,
                    child: Container(
                      width: 92,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFF0000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 27,
                    top: 20,
                    child: Text(
                      'Delete event',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
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
              Padding(
                padding: const EdgeInsets.only(
                  left: 280,
                  top: 20,
                ),
                child: Container(
                  width: 115,
                  height: 160, // Adjust the height as needed
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.rides.communityImage),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
