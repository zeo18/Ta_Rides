import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/post_community/post_comunnity.dart';

class ForYouTabs extends StatelessWidget {
  const ForYouTabs({
    super.key,
    required this.communityPosted,
    required this.userPosted,
    required this.userUse,
    required this.community,
  });

  final Users userUse;
  final List<Users> userPosted;
  final List<Post> communityPosted;
  final Community? community;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (userUse.isCommunity)
          if (community!.ifItsImage.isEmpty)
            Image.asset(
              community!.coverImage,
              height: 180,
              width: 450,
              fit: BoxFit.cover,
            )
          else if (userUse.isCommunity)
            Image(
              image: MemoryImage(community!.ifItsImage),
              height: 180,
              width: 450,
              fit: BoxFit.cover,
            ),
        if (userUse.isCommunity)
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      community!.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: [
                        if (community!.private)
                          Text(
                            'Private Group',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0x3ff808080),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        else
                          Text(
                            'Public Group',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0x3ff808080),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        const SizedBox(
                          width: 2,
                        ),
                        if (community!.private)
                          const Icon(
                            Icons.lock,
                            color: Color(0x3ff808080),
                            size: 15,
                          ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Text(
                            '.',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: const Color(0x3ff808080),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          community!.membersIndex.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'members',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0x3ff808080),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      community!.description,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 15,
                right: 20,
                child: Image.asset(
                  'assets/images/joinedGroup.png',
                  height: 35,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        if (userUse.isCommunity)
          const Divider(
            color: Color(0x3ff797979),
            thickness: 1.0,
            indent: 10,
            endIndent: 10,
          ),
        if (userUse.isCommunity)
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              'Group Post',
              style: GoogleFonts.inter(
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        if (userUse.isCommunity)
          Expanded(
            child: ListView.builder(
              itemCount: communityPosted.length,
              itemBuilder: (ctx, index) => PostCommunityScreen(
                post: communityPosted[index],
                user: userPosted[index],
              ),
            ),
          ),
      ],
    );
  }
}
