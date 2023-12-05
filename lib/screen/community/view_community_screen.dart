import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
import 'package:ta_rides/screen/community/private_condition_screen.dart';
import 'package:ta_rides/screen/community/public_screen.dart';
import 'package:ta_rides/widget/all_controller/community_controller.dart';
import 'package:ta_rides/widget/all_controller/post_controller.dart';
import 'package:ta_rides/widget/all_controller/private_community_controller.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';
import 'package:ta_rides/widget/post_community/post_comunnity.dart';

class ViewCommunityScreen extends StatefulWidget {
  const ViewCommunityScreen({
    super.key,
    // required this.community,
    // required this.onClickPrivateGroup,
    // required this.post,
    // required this.user,
    // required this.onPublicGroup,
    // required this.userUse,
    // required this.users,
    // required this.posts,
    required this.email,
    required this.community,
  });
  final Community community;
  final String email;
  // final Community community;
  // final List<Users> user;
  // final List<Post> post;
  // final Community community;
  // final void Function(Community community) onClickPrivateGroup;
  // final void Function(Community community, Users userUse, List<Users> users,
  //     List<Post> posts) onPublicGroup;
  // final Users userUse;
  // final List<Users> users;
  // final List<Post> posts;

  @override
  State<ViewCommunityScreen> createState() => _ViewCommunityScreenState();
}

class _ViewCommunityScreenState extends State<ViewCommunityScreen> {
  UserController userController = UserController();
  CommunityController communityController = CommunityController();
  PostController postController = PostController();
  PrivateCommunityController privateCommunityController =
      PrivateCommunityController();

  @override
  void initState() {
    userController.setEmail(widget.email);
    userController.getUser(widget.email);
    communityController.setEmail(widget.email);
    communityController.getCommunityAndUser(widget.email);
    postController.setEmail(widget.email);
    postController.getPost(widget.community.id);
    privateCommunityController.getPrivate(widget.community.id);
    // postController.getUserPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int numMembers = 0;
    List<IfPrivate> privates = [];

    // for (var private in privateCommunity) {
    //   if (private.privateCommunityId == widget.community.id) {
    //     if (private.writeRules.isNotEmpty) {
    //       privates.add(private);
    //     }
    //   }
    // }

    return Scaffold(
        backgroundColor: const Color(0x3ff0c0d11),
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0x3ff0c0d11),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(widget.community.coverImage),
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
                          widget.community.title,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                          textAlign: TextAlign.left,
                        ),
                        Row(
                          children: [
                            if (widget.community.private)
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
                            if (widget.community.private)
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
                              widget.community.members.length.toString(),
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
                          widget.community.description,
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
                      onPressed: () async {
                        // setState(() {
                        //   if (widget.community.private) {
                        //     widget.onClickPrivateGroup(widget.community);
                        //   } else {
                        //     widget.onPublicGroup(widget.community, widget.userUse,
                        //         widget.users, widget.posts);
                        //   }
                        // });
                        if (userController.user.isCommunity == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'You are already a part of a community. Before joining another community, make sure to leave your current one first.'),
                            ),
                          );
                        } else {
                          if (widget.community.private == false) {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(userController.user.id)
                                .update({
                              'communityId': widget.community.id,
                              'isCommunity': true,
                            });

                            try {
                              final communityDoc = await FirebaseFirestore
                                  .instance
                                  .collection('community')
                                  .where('id', isEqualTo: widget.community.id)
                                  .get();

                              await communityDoc.docs.first.reference.update({
                                'members': FieldValue.arrayUnion(
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
                          }

                          if (widget.community.private) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => PrivateConditionScreen(
                                  community: widget.community,
                                  email: widget.email,
                                  private: privateCommunityController,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      icon: Image.asset(
                        'assets/images/joinGroup.png',
                        height: 35,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                      animation: userController,
                      builder: (context, snapshot) {
                        if (userController.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Positioned(
                          top: 10,
                          right: 5,
                          child: Column(
                            children: [
                              if (userController.user.communityId ==
                                  widget.community.id)
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/images/joinedGroup.png',
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: const Divider(
                  color: Color(0x3ff797979),
                  thickness: 1.0,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              if (widget.community.private)
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rules',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      AnimatedBuilder(
                          animation: privateCommunityController,
                          builder: (context, snapshot) {
                            if (privateCommunityController.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Column(
                              children: [
                                for (var i = 0;
                                    i <
                                        privateCommunityController
                                            .private.length;
                                    i++)
                                  if (privateCommunityController
                                      .private[i].writeRules.isNotEmpty)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          privateCommunityController
                                              .private[i].writeRules,
                                          style: GoogleFonts.inter(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          privateCommunityController
                                              .private[i].detailsRules,
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),

              if (widget.community.private == false)
                Text(
                  'Group Post',
                  style: GoogleFonts.inter(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),

              if (widget.community.private == false)
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
                        for (var i = 0; i < postController.posts.length; i++)
                          PublicScreen(
                            post: postController.posts[i],
                            user: postController.users[i],
                          ),
                      ],
                    );
                  },
                ),
              // print('hello');
              //   for (var i = 0; i < communityController.posts.length; i++)
              //     PostCommunityScreen(
              //       community: communityController.posts[i],
              //       post: communityController,
              //       email: widget.email,
              //       realUser: userController,
              //       user: communityController.userPost[i],
              //       // post: widget.post[i],
              //       // user: widget.user[i],
              //       // community: widget.community,
              //       // realUser: widget.userUse,
              //     ),

              //       // else
              //       //   Text(
              //       //     'Group Post',
              //       //     style: GoogleFonts.inter(
              //       //       fontSize: 19,
              //       //       color: Colors.white,
              //       //       fontWeight: FontWeight.w600,
              //       //     ),
              //       //   ),
              //       // if (widget.community.private == false)
              //       //   for (var i = 0; i < widget.post.length; i++)
              //       //     // PostCommunityScreen(
              //       //   post: widget.post[i],
              //       //   user: widget.user[i],
              //       //   community: widget.community,
              //       //   realUser: widget.userUse,
              //       // ),

              //       // Expanded(
              //       //   child: ListView.builder(
              //       //     shrinkWrap: false,
              //       //     itemCount: widget.post.length,
              //       //     itemBuilder: (ctx, index) => PostCommunityScreen(
              //       //       post: widget.post[index],
              //       //       user: widget.user[index],
              //       //     ),
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // ),
            ],
          ),
        )

        //  SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Image(
        //         image: NetworkImage(widget.community.coverImage),
        //         height: 210,
        //         width: 450,
        //         fit: BoxFit.cover,
        //       ),

        //       Stack(
        //         children: [
        //           Container(
        //             margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   widget.community.title,
        //                   style: Theme.of(context).textTheme.titleLarge!.copyWith(
        //                         color: Colors.white,
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 20,
        //                       ),
        //                   textAlign: TextAlign.left,
        //                 ),
        //                 Row(
        //                   children: [
        //                     // if (widget.community.private)
        //                     //   Text(
        //                     //     'Private Group',
        //                     //     style: GoogleFonts.inter(
        //                     //       fontSize: 14,
        //                     //       color: const Color(0x3ff808080),
        //                     //       fontWeight: FontWeight.w600,
        //                     //     ),
        //                     // //   )
        //                     // else
        //                     //   Text(
        //                     //     'Public Group',
        //                     //     style: GoogleFonts.inter(
        //                     //       fontSize: 14,
        //                     //       color: const Color(0x3ff808080),
        //                     //       fontWeight: FontWeight.w600,
        //                     //     ),
        //                     //   ),
        //                     const SizedBox(
        //                       width: 2,
        //                     ),
        //                     // if (widget.community.private)
        //                     //   const Icon(
        //                     //     Icons.lock,
        //                     //     color: Color(0x3ff808080),
        //                     //     size: 15,
        //                     //   ),
        //                     const SizedBox(
        //                       width: 5,
        //                     ),
        //                     Container(
        //                       padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        //                       child: Text(
        //                         '.',
        //                         style: GoogleFonts.inter(
        //                           fontSize: 15,
        //                           color: const Color(0x3ff808080),
        //                           fontWeight: FontWeight.w600,
        //                         ),
        //                       ),
        //                     ),
        //                     const SizedBox(
        //                       width: 5,
        //                     ),
        //                     // Text(
        //                     //   widget.community.membersIndex.toString(),
        //                     //   style: GoogleFonts.inter(
        //                     //     fontSize: 14,
        //                     //     color: Colors.white,
        //                     //     fontWeight: FontWeight.bold,
        //                     //   ),
        //                     // ),
        //                     const SizedBox(
        //                       width: 5,
        //                     ),
        //                     Text(
        //                       'members',
        //                       style: GoogleFonts.inter(
        //                         fontSize: 14,
        //                         color: const Color(0x3ff808080),
        //                         fontWeight: FontWeight.w600,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //                 const SizedBox(
        //                   height: 10,
        //                 ),
        //                 // Text(
        //                 //   widget.community.description,
        //                 //   style: GoogleFonts.inter(
        //                 //     fontSize: 16,
        //                 //     color: Colors.white,
        //                 //     fontWeight: FontWeight.w700,
        //                 //   ),
        //                 // ),
        //               ],
        //             ),
        //           ),
        //           Positioned(
        //             top: 10,
        //             right: 10,
        //             child: IconButton(
        //               onPressed: () {
        //                 // setState(() {
        //                 //   if (widget.community.private) {
        //                 //     widget.onClickPrivateGroup(widget.community);
        //                 //   } else {
        //                 //     widget.onPublicGroup(widget.community, widget.userUse,
        //                 //         widget.users, widget.posts);
        //                 //   }
        //                 // });
        //               },
        //               icon: Image.asset(
        //                 'assets/images/joinGroup.png',
        //                 height: 35,
        //                 fit: BoxFit.cover,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //       Container(
        //         margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //         child: const Divider(
        //           color: Color(0x3ff797979),
        //           thickness: 1.0,
        //           indent: 0,
        //           endIndent: 0,
        //         ),
        //       ),
        //       // if (widget.community.private)
        //       Expanded(
        //         child: SingleChildScrollView(
        //           child: Container(
        //               margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     'Rules',
        //                     style:
        //                         Theme.of(context).textTheme.titleLarge!.copyWith(
        //                               color: Colors.white,
        //                               fontWeight: FontWeight.bold,
        //                             ),
        //                   ),
        //                   for (var private in privates)
        //                     Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         const SizedBox(
        //                           height: 10,
        //                         ),
        //                         Text(
        //                           private.writeRules,
        //                           style: GoogleFonts.inter(
        //                             fontSize: 16,
        //                             color: Colors.white,
        //                           ),
        //                         ),
        //                         const SizedBox(
        //                           height: 10,
        //                         ),
        //                         Text(
        //                           private.detailsRules,
        //                           style: GoogleFonts.inter(
        //                             fontSize: 16,
        //                             color: Colors.white,
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                 ],
        //               )),
        //         ),
        //       )
        //       // else
        //       //   Text(
        //       //     'Group Post',
        //       //     style: GoogleFonts.inter(
        //       //       fontSize: 19,
        //       //       color: Colors.white,
        //       //       fontWeight: FontWeight.w600,
        //       //     ),
        //       //   ),
        //       // if (widget.community.private == false)
        //       //   for (var i = 0; i < widget.post.length; i++)
        //       //     // PostCommunityScreen(
        //       //   post: widget.post[i],
        //       //   user: widget.user[i],
        //       //   community: widget.community,
        //       //   realUser: widget.userUse,
        //       // ),

        //       // Expanded(
        //       //   child: ListView.builder(
        //       //     shrinkWrap: false,
        //       //     itemCount: widget.post.length,
        //       //     itemBuilder: (ctx, index) => PostCommunityScreen(
        //       //       post: widget.post[index],
        //       //       user: widget.user[index],
        //       //     ),
        //       //   ),
        //       // ),
        //     ],
        //   ),
        // ),
        );
  }
}
