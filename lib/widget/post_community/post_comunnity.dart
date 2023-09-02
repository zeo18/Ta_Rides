import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';

class PostCommunityScreen extends StatelessWidget {
  const PostCommunityScreen(
      {super.key, required this.post, required this.user});

  final Post post;
  final Users user;

  @override
  Widget build(BuildContext context) {
    print(['user in post', user.username]);
    print([' post caption', post.caption]);
    return Stack(
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
                    child: Image.asset(
                      user.userImage,
                      height: 45,
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
                        "${user.firstName} ${user.lastName}",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                      ),
                      Text(
                        '@${post.usersName}',
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
                      '12m',
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
            if (post.isImage)
              if (post.ifImage.isEmpty)
                Image.asset(
                  post.imagePost,
                  height: 168,
                  width: 420,
                  fit: BoxFit.cover,
                )
              else
                Image(
                  image: MemoryImage(post.ifImage),
                  height: 168,
                  width: 420,
                  fit: BoxFit.cover,
                ),
            if (post.isImage)
              const SizedBox(
                height: 10,
              ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.caption,
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
                        post.heart.toString(),
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
                        post.commment.length.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          color: Color(0x3ff797979),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 210,
                      ),
                      Expanded(
                        child: Image.asset(
                          'assets/images/community_images/post_community/icon.png',
                          height: 25,
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
