import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ta_rides/models/community_info.dart';

import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
import 'package:ta_rides/screen/community/view_member_request.dart';

import 'package:ta_rides/widget/all_controller/post_controller.dart';
import 'package:ta_rides/widget/all_controller/request_controller.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';
import 'package:ta_rides/widget/post_community/add_post.dart';
import 'package:ta_rides/widget/post_community/post_comunnity.dart';

class ForYouTabs extends StatefulWidget {
  const ForYouTabs({
    super.key,
    // required this.communityPosted,
    // required this.userPosted,
    // required this.userUse,
    // required this.community,
    required this.email,
    required this.community,
    // required this.community,
    // required this.user,
  });

  // final Users userUse;
  // final List<Users> userPosted;
  // final List<Post> communityPosted;
  // final Community? community;
  // final CommunityController community;
  // final UserController user;
  final String email;
  final Community? community;

  @override
  State<ForYouTabs> createState() => _ForYouTabsState();
}

class _ForYouTabsState extends State<ForYouTabs> {
  UserController userController = UserController();
  // CommunityController communityController = CommunityController();
  PostController postController = PostController();
  RequestController requestController = RequestController();
  bool leaveGroup = false;

  // CommunityController communityController = CommunityController();
  // Community community = communityInformation[0];

  @override
  void initState() {
    userController.setEmail(widget.email);
    userController.getUser(widget.email);
    // communityController.setEmail(widget.email);
    // communityController.getCommunityAndUser(widget.email);
    postController.setEmail(widget.email);
    postController.getPost(widget.community!.id);
    requestController.getRequest(widget.community!.id);
    super.initState();
  }

  // void addPostCommunity(Post post) {
  //   setState(() {
  //     PostCommunity.insert(0, post);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // print(communityController.posts.length);
    return Scaffold(
      backgroundColor: const Color(0x3ff0C0D11),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => AddPostCommunity(
                        user: userController,
                        email: widget.email,
                        // user: widget.userUse,
                        // onAddPost: addPostCommunity,
                        // community: widget.community!,
                      )));
        },
        backgroundColor: Color(0x3ffFF0000),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: AnimatedBuilder(
            animation: userController,
            builder: (context, snapshot) {
              if (userController.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (userController.user.isCommunity == false)
                    Text(
                      'there is no community',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                    ),
                  if (userController.user.isCommunity)
                    Image(
                      image: NetworkImage(widget.community!.coverImage),
                      height: 180,
                      width: 450,
                      fit: BoxFit.cover,
                    ),
                  if (userController.user.isCommunity)
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.community!.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                textAlign: TextAlign.left,
                              ),
                              Row(
                                children: [
                                  if (widget.community!.private)
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
                                  if (widget.community!.private)
                                    const Icon(
                                      Icons.lock,
                                      color: Color(0x3ff808080),
                                      size: 15,
                                    ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 5),
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
                                    widget.community!.members.length.toString(),
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
                                widget.community!.description,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'hello',
                                style: TextStyle(color: Colors.white),
                              ),
                              AnimatedBuilder(
                                animation: requestController,
                                builder: (context, snapshot) {
                                  if (requestController.isLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  return IconButton(
                                    onPressed: () {
                                      for (var i = 0;
                                          i < requestController.request.length;
                                          i++) {
                                        print('heyyyyyy');
                                        print(
                                            'Checking username: ${requestController.request[i].userName}');
                                        print(requestController
                                            .request[i].userName);
                                        print(userController.user.username);
                                        if (widget.community!.owner ==
                                            userController.user.username) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (ctx) =>
                                                  ViewMemberRequest(
                                                request: requestController
                                                    .request[i],
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                      print('No matching username found');
                                    },
                                    icon: const Icon(
                                      Icons.person_add,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  );
                                },
                              ),
                              // if community is private or host ka sa community show this
                            ],
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 20,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                leaveGroup = !leaveGroup;
                              });
                            },
                            child: Image.asset(
                              'assets/images/joinedGroup.png',
                              height: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (leaveGroup)
                          Positioned(
                            top: 53,
                            right: 10,
                            child: InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userController.user.id)
                                    .update({
                                  'communityId': '0',
                                  'isCommunity': false,
                                });

                                try {
                                  final communityDoc = await FirebaseFirestore
                                      .instance
                                      .collection('community')
                                      .where('id',
                                          isEqualTo: widget.community!.id)
                                      .where('members',
                                          arrayContains:
                                              userController.user.username)
                                      .get();

                                  await communityDoc.docs.first.reference
                                      .update({
                                    'members': FieldValue.arrayRemove(
                                        [userController.user.username]),
                                  });
                                } catch (e) {
                                  print('Error updating document: $e');
                                }

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => TabsScreen(
                                      email: widget.email,
                                      tabsScreen: 0,
                                      communityTabs: 1,
                                    ),
                                  ),
                                );
                                setState(() {});
                              },
                              child: Image.asset(
                                'assets/images/community_images/leaveGroup.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      ],
                    ),
                  if (userController.user.isCommunity)
                    const Divider(
                      color: Color(0x3ff797979),
                      thickness: 1.0,
                      indent: 10,
                      endIndent: 10,
                    ),
                  if (userController.user.isCommunity)
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
                  if (userController.user.isCommunity)
                    AnimatedBuilder(
                      animation: postController,
                      builder: (context, snapshot) {
                        if (postController.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (postController.posts.isEmpty) {
                          return const Center(
                            child: Text('No posts found.'),
                          );
                        }
                        if (postController.users.isEmpty) {
                          return const Center(
                            child: Text('No users found.'),
                          );
                        }
                        return Column(
                          children: [
                            for (var i = 0;
                                i < postController.posts.length;
                                i++)
                              PostCommunityScreen(
                                user: postController.users[i],
                                post: postController.posts[i],
                                email: widget.email,
                                realUser: userController,
                              ),
                          ],
                        );
                      },
                    ),
                ],
              );
            }),
      ),
    );
  }
}