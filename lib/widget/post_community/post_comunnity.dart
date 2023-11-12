import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/data/user_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
import 'package:ta_rides/widget/all_controller/community_controller.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';
import 'package:ta_rides/widget/post_community/comment.dart';

class PostCommunityScreen extends StatefulWidget {
  const PostCommunityScreen({
    super.key,
    // required this.post,
    // required this.user,
    // required this.community,
    // required this.realUser,

    required this.post,
    required this.user,
    required this.email,
    required this.realUser,
  });

  final UserController realUser;
  final Post post;
  final Users user;
  final String email;
  // final Users realUser;

  @override
  State<PostCommunityScreen> createState() => _PostCommunityScreenState();
}

class _PostCommunityScreenState extends State<PostCommunityScreen> {
  bool onTapDot = false;
  void commentSection() {
    // List<Comment> comments = [];
    // List<Users> userComment = [];

    // setState(() {
    //   for (var comment in commentCommunity) {
    //     if (comment.postId == widget.post.postId) {
    //       comments.add(comment);
    //     }
    //   }
    //   for (var comment in commentCommunity) {
    //     for (var user in UserInformation) {
    //       if (comment.usersName == user.username &&
    //           comment.postId == widget.post.postId) {
    //         userComment.add(user);
    //       }
    //     }
    //   }
    // });

    // for (var i = 0; i < commentCommunity.length; i++) {
    //   if(commentCommunity[i].postId == widget.post.postId){
    //     comment.add(commentCommunity[i]);
    //   }

    // }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Comments(
          community: widget.post,
          user: widget.user,
          email: widget.email,
          realUser: widget.realUser,

          //       // user: widget.user,
          //       // community: widget.community,
          //       // post: widget.post,
          //       // comment: comments,
          //       // userComment: userComment,
          //       // tapHeart: tapHeart,
          //       // realUser: widget.realUser,
        ),
      ),
    );
  }

  // void addComment(String commentText) {
  //   if (commentText.isNotEmpty) {
  //     Comment newComment = Comment(
  //       postId: widget.post.postId,
  //       comment: commentText,
  //       usersName: widget.realUser.username,
  //       userImage: '', // You may want to set the user's image here
  //     );

  //     setState(() {
  //       widget.comment.insert(
  //           0, newComment); // Add the new comment to the end of the list
  //       widget.userComment.insert(0, widget.realUser);
  //       commentController.clear(); // Clear the text field
  //     });
  //   }
  // }

  void onTapHeart() async {
    setState(() {
      if (widget.post.isHeart) {
        widget.post.isHeart = false;
        widget.post.heart.remove(widget.realUser.user.username);
      } else {
        widget.post.isHeart = true;
        widget.post.heart.add(widget.realUser.user.username);
      }
    });

    try {
      final postDocumentSnapshot = await FirebaseFirestore.instance
          .collection('post')
          .where('caption', isEqualTo: widget.post.caption)
          .where('usersName', isEqualTo: widget.post.usersName)
          .where('postId', isEqualTo: widget.post.postId)
          .get();

      if (postDocumentSnapshot.docs.isEmpty) {
        throw Exception('posts not found');
      }

      if (widget.post.isHeart) {
        await postDocumentSnapshot.docs.first.reference.update({
          'heart': FieldValue.arrayUnion([widget.realUser.user.username])
        });
      } else {
        await postDocumentSnapshot.docs.first.reference.update({
          'heart': FieldValue.arrayRemove([widget.realUser.user.username])
        });
      }
    } catch (e) {
      print('Error updating post: $e');
      // Handle the error here, such as displaying an error message to the user
    }
  }

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

  var onGroup = true;
  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < widget.post.heart.length; i++) {
      if (widget.realUser.user.username == widget.post.heart[i]) {
        widget.post.isHeart = true;
      } else {
        widget.post.isHeart = false;
      }
    }
    final postTime = widget.post.timestamp.toDate();
    final currentTime = DateTime.now();
    final difference = currentTime.difference(postTime);
    final minutes = difference.inMinutes;
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
                        "${widget.user.firstName.replaceRange(0, 1, widget.user.firstName[0].toUpperCase())} ${widget.user.lastName.replaceRange(0, 1, widget.user.lastName[0].toUpperCase())}",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
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
                      if (onGroup)
                        InkWell(
                          onTap: onTapHeart,
                          child: Image.asset(
                            widget.post.isHeart == false
                                ? 'assets/images/community_images/post_community/heart.png'
                                : 'assets/images/community_images/post_community/hearted.png',
                            height: 25,
                          ),
                        )
                      else
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
                      if (onGroup)
                        InkWell(
                          onTap: commentSection,
                          child: Image.asset(
                            'assets/images/community_images/post_community/comment.png',
                            height: 25,
                          ),
                        )
                      else
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
                      const SizedBox(
                        width: 210,
                      ),
                      // Expanded(
                      //   child: Image.asset(
                      //     'assets/images/community_images/post_community/icon.png',
                      //     height: 25,
                      //   ),
                      // ),
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
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    onTapDot = !onTapDot;
                  });
                },
                child: Image.asset(
                  'assets/images/community_images/post_community/iconDot.png',
                  height: 20,
                ),
              ),
            ],
          ),
        ),
        if (onTapDot)
          Positioned(
            top: 6,
            right: 22,
            child: Column(
              children: [
                if (widget.realUser.user.username == widget.post.usersName)
                  InkWell(
                    onTap: () async {
                      final delete = await FirebaseFirestore.instance
                          .collection('post')
                          .where('postId', isEqualTo: widget.post.postId)
                          .get();

                      await delete.docs.first.reference.delete();

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
                    },
                    child: Image.asset(
                      'assets/images/community_images/post_community/deletePost.png',
                    ),
                  )
                else
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/community_images/post_community/reportPost.png',
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}


//  if (widget.realUser.user.username == widget.post.usersName)