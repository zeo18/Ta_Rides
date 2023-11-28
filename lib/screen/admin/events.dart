import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/screen/admin/events-display.dart';
import 'package:ta_rides/widget/all_controller/rides_controller.dart';

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
   ridesController.getAllRides();
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
        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            focusNode: _focusNode,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              labelText: 'Search events',
              labelStyle: GoogleFonts.inter(
                color: _focusNode.hasFocus
                    ? const Color.fromARGB(255, 232, 155, 5)
                    : const Color.fromARGB(255, 69, 69, 69),
                fontWeight: FontWeight.w400,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 232, 155, 5),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 69, 69, 69),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                },
                icon: Image.asset(
                  'assets/images/admin_images/search-icon.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ),
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
        AnimatedBuilder(
          animation: ridesController,
          builder: (context, snapshot) {
            if (ridesController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Expanded(
              child: GridView(
                padding: const EdgeInsets.all(2),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2.3,
                  crossAxisSpacing:
                      2, // Decrease this value to reduce the horizontal space between the items
                  mainAxisSpacing:
                      2, // Decrease this value to reduce the vertical space between the items
                ),
                children: [
                  for (var i = 0; i < ridesController.allRides.length; i++)
                    EventsDisplay(
                      rides: ridesController.allRides[i], 
                    )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
