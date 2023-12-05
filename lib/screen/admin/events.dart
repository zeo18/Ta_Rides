import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/screen/admin/events-display.dart';
import 'package:ta_rides/widget/all_controller/rides_controller.dart';
import 'package:ta_rides/widget/rides/finished_rides.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  late FocusNode _focusNode;
  RidesController ridesController = RidesController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    ridesController.getAllFinishedRides();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All events',
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: AnimatedBuilder(
              animation: ridesController,
              builder: (context, snapshot) {
                if (ridesController.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: ridesController.allFinishRides.length,
                  itemBuilder: (context, index) => FinishedRides(
                    rides: ridesController.allFinishRides[index],
                    email: '',
                  ),
                );
              }),
        ),

        // AnimatedBuilder(
        //   animation: ridesController,
        //   builder: (context, snapshot) {
        //     if (ridesController.isLoading) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     return Expanded(
        //       child: GridView(
        //         padding: const EdgeInsets.all(2),
        //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 1,
        //           childAspectRatio: 2.3,
        //           crossAxisSpacing:
        //               2, // Decrease this value to reduce the horizontal space between the items
        //           mainAxisSpacing:
        //               2, // Decrease this value to reduce the vertical space between the items
        //         ),
        //         children: [
        //           for (var i = 0; i < ridesController.allRides.length; i++)
        //             EventsDisplay(
        //               rides: ridesController.allRides[i],
        //             )
        //         ],
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}
