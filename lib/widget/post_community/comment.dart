import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';

class Comments extends StatefulWidget {
  Comments({
    super.key,
    required this.user,
    required this.community,
    required this.post,
    required this.comment,
    required this.userComment,
    required this.tapHeart,
    required this.realUser,
  });

  final Users realUser;
  final Users user;
  final Community community;
  final Post post;
  final List<Comment> comment;
  final List<Users> userComment;

  late bool tapHeart;

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  TextEditingController commentController = TextEditingController();

  void onTapHeart() {
    setState(() {
      widget.tapHeart = widget.tapHeart ? false : true;

      if (widget.tapHeart == true) {
        widget.post.heart -= 1;
      } else {
        widget.post.heart += 1;
      }
    });
  }

  void addComment(String commentText) {
    if (commentText.isNotEmpty) {
      Comment newComment = Comment(
        postId: widget.post.postId,
        comment: commentText,
        usersName: widget.realUser.username,
        userImage: '', // You may want to set the user's image here
      );

      setState(() {
        widget.comment.insert(
            0, newComment); // Add the new comment to the end of the list
        widget.userComment.insert(0, widget.realUser);
        commentController.clear(); // Clear the text field
      });
    }
    FocusNode focusNode = FocusNode();
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        backgroundColor: const Color(0x3ff0C0D11),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
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
                  height: 200,
                  width: 450,
                  fit: BoxFit.cover,
                )
              else
                Image(
                  image: MemoryImage(widget.post.ifImage),
                  height: 200,
                  width: 450,
                  fit: BoxFit.cover,
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
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: onTapHeart,
                        child: Image.asset(
                          widget.tapHeart
                              ? 'assets/images/community_images/post_community/heart.png'
                              : 'assets/images/community_images/post_community/hearted.png',
                          height: 25,
                        ),
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
                      Image.asset(
                        'assets/images/community_images/post_community/comment.png',
                        height: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.comment.length.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          color: Color(0x3ff797979),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: ClipOval(
                          child: Image.asset(
                            widget.realUser.userImage,
                            height: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 340,
                        child: TextFormField(
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                          cursorColor: Colors.white,
                          controller: commentController,
                          maxLength: 25,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            label: Text(
                              'Write a comment...',
                              style: GoogleFonts.inter(
                                color: const Color(0x3ff454545),
                                fontSize: 15,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0x3ff454545)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            suffix: InkWell(
                              onTap: () {
                                addComment(commentController.text);
                              },
                              child: const Icon(
                                Icons.send,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const Divider(
                  //   color: Color(0x3ff797979),
                  //   thickness: 1.0,
                  //   indent: 0,
                  //   endIndent: 0,
                  // ),
                  for (var i = 0; i < widget.comment.length; i++)
                    if (i < widget.userComment.length)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  widget.userComment[i].userImage,
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
                                    "${widget.userComment[i].firstName} ${widget.userComment[i].lastName}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.comment[i].comment,
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
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

                          // Container(
                          //   margin: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                          //   child: Text(
                          //     widget.comment[i].comment,
                          //     style: GoogleFonts.inter(
                          //       fontSize: 13,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
