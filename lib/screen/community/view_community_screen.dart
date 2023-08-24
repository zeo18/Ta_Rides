import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/post_community/post_comunnity.dart';
import 'package:ta_rides/widget/tab_widget/for_you.dart';

class ViewCommunityScreen extends StatelessWidget {
  const ViewCommunityScreen({
    super.key,
    required this.community,
    required this.onClickPrivateGroup,
    required this.post,
    required this.user,
    required this.onPublicGroup,
    required this.userUse,
    required this.users,
    required this.posts,
  });
  final List<Users> user;
  final List<Post> post;
  final Community community;
  final void Function(Community community) onClickPrivateGroup;
  final void Function(Community community, Users userUse, List<Users> users,
      List<Post> posts) onPublicGroup;
  final Users userUse;
  final List<Users> users;
  final List<Post> posts;

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
            width: 450,
            fit: BoxFit.cover,
          ),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      community.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: [
                        if (community.private)
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
                        if (community.private)
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
                          community.membersIndex.toString(),
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
                      community.description,
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
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {
                    if (community.private) {
                      onClickPrivateGroup(community);
                    } else {
                      onPublicGroup(community, userUse, users, posts);
                    }
                  },
                  icon: Image.asset(
                    'assets/images/joinGroup.png',
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const Text(
            '____________________________________________',
            style: TextStyle(
              color: Color(0x3ff797979),
              fontSize: 18,
            ),
          ),
          if (community.private)
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rules',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur. Ornare auctor velit mauris rutrum imperdiet risus et hendrerit rhoncus. Quis lorem at sapien',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur. Ornare auctor velit mauris rutrum imperdiet risus et hendrerit rhoncus. Quis lorem at sapien',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )),
              ),
            )
          else
            Text(
              'Group Post',
              style: GoogleFonts.inter(
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          if (community.private == false)
            Expanded(
              child: ListView.builder(
                shrinkWrap: false,
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