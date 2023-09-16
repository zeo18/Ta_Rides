import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/data/user_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/post_community/comment.dart';

class PostCommunityScreen extends StatefulWidget {
  const PostCommunityScreen({
    super.key,
    required this.post,
    required this.user,
    required this.community,
    required this.realUser,
  });

  final Post post;
  final Community community;
  final Users user;
  final Users realUser;

  @override
  State<PostCommunityScreen> createState() => _PostCommunityScreenState();
}

class _PostCommunityScreenState extends State<PostCommunityScreen> {
  bool tapHeart = true;
  bool isHearted = false;

  void commentSection() {
    List<Comment> comments = [];
    List<Users> userComment = [];

    setState(() {
      for (var comment in commentCommunity) {
        if (comment.postId == widget.post.postId) {
          comments.add(comment);
        }
      }
      for (var comment in commentCommunity) {
        for (var user in UserInformation) {
          if (comment.usersName == user.username &&
              comment.postId == widget.post.postId) {
            userComment.add(user);
          }
        }
      }
    });

    // for (var i = 0; i < commentCommunity.length; i++) {
    //   if(commentCommunity[i].postId == widget.post.postId){
    //     comment.add(commentCommunity[i]);
    //   }

    // }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Comments(
          user: widget.user,
          community: widget.community,
          post: widget.post,
          comment: comments,
          userComment: userComment,
          tapHeart: tapHeart,
          realUser: widget.realUser,
        ),
      ),
    );
    // print(['username', userComment[0].username]);
    // print(['first name', userComment[0].firstName]);
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

  void onTapHeart() {
    setState(() {
      tapHeart = tapHeart ? false : true;

      if (tapHeart == true) {
        widget.post.heart -= 1;
      } else {
        widget.post.heart += 1;
      }
    });
  }

  var onGroup = true;
  @override
  Widget build(BuildContext context) {
    List<Comment> commenter = [];
    for (var comment in commentCommunity) {
      if (comment.postId == widget.post.postId) {
        commenter.add(comment);
      }
    }

    print(['user in post', widget.user.username]);
    print([' post caption', widget.post.caption]);
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
                      widget.user.userImage,
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
            if (widget.post.isImage)
              if (widget.post.ifImage.isEmpty)
                Image.asset(
                  widget.post.imagePost,
                  height: 168,
                  width: 420,
                  fit: BoxFit.cover,
                )
              else
                Image(
                  image: MemoryImage(widget.post.ifImage),
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
                            tapHeart
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
                        widget.post.heart.toString(),
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
                        commenter.length.toString(),
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
