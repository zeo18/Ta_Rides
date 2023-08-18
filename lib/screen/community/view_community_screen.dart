import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/post_community/post_comunnity.dart';

class ViewCommunityScreen extends StatelessWidget {
  const ViewCommunityScreen({
    super.key,
    required this.community,
    required this.onClickPrivateGroup,
    required this.post,
    required this.user,
  });
  final List<Users> user;
  final List<Post> post;
  final Community community;
  final void Function(Community community) onClickPrivateGroup;

  @override
  Widget build(BuildContext context) {
    // print(["user", user[0].toJson()]);
    // print(["post", post.length]);
    for (var i = 0; i < post.length; i++) {
      // print("${post[i].toJson()}" '\n');
    }
    return Scaffold(
      backgroundColor: const Color(0x3ff0c0d11),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0x3ff0c0d11),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            community.coverImage,
            height: 210,
            width: 480,
            fit: BoxFit.cover,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Stack(
              children: [
                const SizedBox(
                  height: 45,
                  width: 200,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 172, 0),
                  child: Text(
                    community.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Positioned(
                  top: 3,
                  left: 272,
                  child: IconButton(
                    onPressed: () {
                      onClickPrivateGroup(community);
                    },
                    icon: Image.asset(
                      'assets/images/joinGroup.png',
                      height: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (community.private)
                  Positioned(
                    top: 28,
                    child: Text(
                      'Private Group',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0x3ff808080),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  Positioned(
                    top: 28,
                    child: Text(
                      'Public Group',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0x3ff808080),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                if (community.private)
                  const Positioned(
                    top: 31,
                    left: 100,
                    child: Icon(
                      Icons.lock,
                      color: Color(0x3ff808080),
                      size: 15,
                    ),
                  ),
                if (community.private)
                  Positioned(
                    top: 25,
                    left: 120,
                    child: Text(
                      '.',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: const Color(0x3ff808080),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  Positioned(
                    top: 25,
                    left: 98,
                    child: Text(
                      '.',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: const Color(0x3ff808080),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                if (community.private)
                  Positioned(
                    top: 28,
                    left: 131,
                    child: Text(
                      community.membersIndex.toString(),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  Positioned(
                    top: 28,
                    left: 110,
                    child: Text(
                      community.membersIndex.toString(),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (community.private)
                  Positioned(
                    top: 28,
                    left: 153,
                    child: Text(
                      'members',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0x3ff808080),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  Positioned(
                    top: 28,
                    left: 134,
                    child: Text(
                      'members',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0x3ff808080),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              community.description,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: const Text(
              '__________________________________________',
              style: TextStyle(
                color: Color(0x3ff797979),
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              'Group Post',
              style: GoogleFonts.inter(
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (community.private == false)
            Expanded(
              child: ListView.builder(
                itemCount: post.length,
                itemBuilder: (ctx, index) => PostCommunityScreen(
                  post: post[index],
                  user: user[index],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
