import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/screen/admin/community-informations.dart';

class CommunityDisplay extends StatefulWidget {
  const CommunityDisplay({
    super.key,
    required this.community,
  });

  final Community community;

  @override
  State<CommunityDisplay> createState() => _CommunityDisplayState();
}

class _CommunityDisplayState extends State<CommunityDisplay> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff282828),
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 10,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CommunityInformations(
                community: widget.community,
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.community.coverImage,
                height: 60,
                width: 180,
                fit: BoxFit.fill,
              ),
              Text(
                "${widget.community.title.replaceRange(0, 1, widget.community.title[0].toUpperCase())}",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              Text(
                "${widget.community.description.length > 40 ? widget.community.description.substring(0, 40) + '...' : widget.community.description}", // Adjust the length as needed
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 121, 121, 121),
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "+${widget.community.members.length.toString()} members",
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 121, 121, 121),
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );

    //
    // InkWell(
    //   onTap: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => CommunityInformations(
    //           community: widget.community,
    //         ),
    //       ),
    //     );
    //   },
    //   child: Column(
    //     children: [
    //       Container(
    //         width: 195,
    //         height: 160, // Adjust the height as needed
    //         decoration: ShapeDecoration(
    //           color: const Color.fromARGB(255, 40, 40, 40),
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(10),
    //           ),
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Container(
    //                 width: 180,
    //                 height: 60, // Adjust the height as needed
    //                 decoration: ShapeDecoration(
    //                   image: DecorationImage(
    //                     image: NetworkImage(widget.community.coverImage),
    //                     fit: BoxFit.cover,
    //                   ),
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(5),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Align(
    //               alignment: Alignment.centerLeft,
    //               child: Text(
    //                 "  ${widget.community.title.replaceRange(0, 1, widget.community.title[0].toUpperCase())}",
    //                 style: GoogleFonts.montserrat(
    //                   color: Colors.white,
    //                   fontWeight: FontWeight.w700,
    //                   fontSize: 15,
    //                 ),
    //               ),
    //             ),
    //             Align(
    //               alignment: Alignment.centerLeft,
    //               child: Text(
    //                 "  ${widget.community.description.substring(0, 30)}..", // Adjust the length as needed
    //                 style: GoogleFonts.inter(
    //                   color: const Color.fromARGB(255, 121, 121, 121),
    //                   fontWeight: FontWeight.w500,
    //                   fontSize: 10,
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             Align(
    //               alignment: Alignment.bottomLeft,
    //               child: Text(
    //                 "  +${widget.community.members.length} members", // Display the number of members
    //                 style: GoogleFonts.inter(
    //                   color: const Color.fromARGB(255, 69, 69, 69),
    //                   fontWeight: FontWeight.w700,
    //                   fontSize: 11,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
