import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/location_info.dart';

class SetRoute extends StatefulWidget {
  const SetRoute({
    super.key,
    required this.selectPinPoint,
    required this.selectPinPoint2,
    required this.pinPoint1st,
    required this.pinPoint2nd,
    required this.setPlace,
    required this.setPolyline,
  });
  final Function() selectPinPoint2;

  final Function() selectPinPoint;
  final Future<void> Function(
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) setPlace;
  final void Function(List<PointLatLng> points) setPolyline;
  final String pinPoint1st;
  final String pinPoint2nd;
  @override
  State<SetRoute> createState() => _SetRouteState();
}

class _SetRouteState extends State<SetRoute> {
  bool selectPoint = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'Pin point your location',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: const Color(0x3ff454545),
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
              color: Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.hardEdge,
              elevation: 10,
              child: InkWell(
                onTap: () {
                  widget.selectPinPoint();
                },
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Image.asset('assets/images/pedal/icon.png'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.pinPoint1st.isEmpty
                            ? '1st Pinpoint'
                            : widget.pinPoint1st,
                        style: GoogleFonts.inter(
                          color: Color(0x3FF989898),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              color: Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.hardEdge,
              elevation: 10,
              child: InkWell(
                onTap: () {
                  widget.selectPinPoint2();
                },
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Image.asset('assets/images/pedal/icon1.png'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.pinPoint2nd.isEmpty
                            ? '2nd Pinpoint'
                            : widget.pinPoint2nd,
                        style: GoogleFonts.inter(
                          color: Color(0x3FF989898),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Card(
            //   color: Color.fromARGB(255, 255, 255, 255),
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   clipBehavior: Clip.hardEdge,
            //   elevation: 10,
            //   child: InkWell(
            //     onTap: () {},
            //     child: Container(
            //       margin: const EdgeInsets.all(15),
            //       child: Row(
            //         children: [
            //           Image.asset('assets/images/pedal/icon2.png'),
            //           const SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             '3rd Pinpoint',
            //             style: GoogleFonts.inter(
            //               color: Color(0x3FF989898),
            //               fontSize: 12,
            //               fontWeight: FontWeight.w500,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
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
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                var direction = await LocationService()
                    .getDirections(widget.pinPoint1st, widget.pinPoint2nd);

                widget.setPlace(
                  direction['start_location']['lat'],
                  direction['start_location']['lng'],
                  direction['bounds_ne'],
                  direction['bounds_sw'],
                );

                widget.setPolyline(direction['polyline_decoded']);
              },
              child: Text(
                'Continue',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
