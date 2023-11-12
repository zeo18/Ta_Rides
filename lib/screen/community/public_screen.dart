import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';

class PublicScreen extends StatefulWidget {
  const PublicScreen({
    super.key,
    // required this.user,
    // required this.community,
    // required this.email,
    required this.post,
    required this.user,
    required this.email,
  });
  final Post post;
  final Users user;
  final String email;
  // final Post community;
  // final Users user;
  // final String email;

  @override
  State<PublicScreen> createState() => _PublicScreenState();
}

class _PublicScreenState extends State<PublicScreen> {
  String getTimeString(int minutes) {
    if (minutes < 60) {
      return '• $minutes min';
    } else if (minutes < 1440) {
      final hours = (minutes / 60).floor();
      return '• $hours hr';
    } else {
      final days = (minutes / 1440).floor();
      return '• $days days';
    }
  }

  @override
  Widget build(BuildContext context) {
    final postTime = widget.post.timestamp.toDate();
    final currentTime = DateTime.now();
    final difference = currentTime.difference(postTime);
    final minutes = difference.inMinutes;

    return
        // Column(
        //   children: [
        //     Text(
        //       widget.post.caption,
        //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //             color: Colors.white,
        //             fontWeight: FontWeight.w900,
        //           ),
        //     ),
        //     Text(
        //       widget.user.firstName,
        //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //             color: Colors.white,
        //             fontWeight: FontWeight.w900,
        //           ),
        //     ),
        //   ],
        // );

        Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.network(
                      widget.user.userImage,
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.user.firstName} ${widget.user.lastName}",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                      ),
                      Text(
                        '@${widget.post.usersName}',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: Color(0x3ff797979),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                    child: Text(
                      getTimeString(minutes),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Color(0x3ff797979),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.post.isImage)
              Image.network(
                widget.post.imagePost,
                height: 168,
                width: 420,
                fit: BoxFit.cover,
              ),
            if (widget.post.isImage)
              const SizedBox(
                height: 10,
              ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.caption,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/community_images/post_community/heart.png',
                        height: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.post.heart.length.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          color: Color(0x3ff797979),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Image.asset(
                        'assets/images/community_images/post_community/comment.png',
                        height: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.post.commment.length.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          color: Color(0x3ff797979),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 14,
          right: 12,
          child: Image.asset(
            'assets/images/community_images/post_community/iconDot.png',
            height: 20,
          ),
        ),
      ],
    );
  }
}
