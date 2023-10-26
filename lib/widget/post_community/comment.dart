import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
import 'package:intl/intl.dart';
import 'package:ta_rides/widget/all_controller/community_controller.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';

class Comments extends StatefulWidget {
  Comments({
    super.key,
    //   required this.user,
    //   required this.community,
    //   required this.post,
    //   required this.comment,
    //   required this.userComment,
    //   required this.tapHeart,
    //   required this.realUser,
    required this.user,
    required this.community,
    required this.email,
    required this.realUser,
  });
  final UserController realUser;
  final Users user;
  final Post community;
  final String email;
  // final Users realUser;
  // final Users user;
  // final Community community;
  // final Post post;
  // final List<Comment> comment;
  // final List<Users> userComment;

  // late bool tapHeart;

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  TextEditingController commentController = TextEditingController();
  UserController userController = UserController();
  CommunityController communityController = CommunityController();
  late int commentLength = 0;

  @override
  void initState() {
    userController.setEmail(widget.email);
    userController.getUser(widget.email);
    communityController.setEmail(widget.email);
    communityController.getCommunityAndUser(widget.email);
    communityController.getComment(widget.community.postId);
    commentLength = widget.community.commment.length;
    super.initState();
  }

  void onTapHeart() async {
    setState(() {
      if (widget.community.isHeart) {
        widget.community.isHeart = false;
        widget.community.heart.remove(widget.realUser.user.username);
      } else {
        widget.community.isHeart = true;
        widget.community.heart.add(widget.realUser.user.username);
      }
    });

    try {
      final postDocumentSnapshot = await FirebaseFirestore.instance
          .collection('post')
          .where('caption', isEqualTo: widget.community.caption)
          .where('usersName', isEqualTo: widget.community.usersName)
          .where('postId', isEqualTo: widget.community.postId)
          .get();

      if (postDocumentSnapshot.docs.isEmpty) {
        throw Exception('posts not found');
      }

      if (widget.community.isHeart) {
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
  // if (commentText.isNotEmpty) {
  //   Comment newComment = Comment(
  //     postId: widget.post.postId,
  //     comment: commentText,
  //     usersName: widget.realUser.username,
  //     userImage: '', // You may want to set the user's image here
  //   );

  //   setState(() {
  //     widget.comment.insert(
  //         0, newComment); // Add the new comment to the end of the list
  //     widget.userComment.insert(0, widget.realUser);
  //     commentController.clear(); // Clear the text field
  //   });
  // }

  void addComment(String commentText) async {
    await FirebaseFirestore.instance.collection('comment').add({
      'comment': commentText,
      'usersName': userController.user.username,
      'userImage': userController.user.userImage,
      'postId': widget.community.postId,
      'timestamp': Timestamp.now(),
      'firstName': userController.user.firstName,
      'lastName': userController.user.lastName,
    });

    final postDocumentSnapshot = await FirebaseFirestore.instance
        .collection('post')
        .where('caption', isEqualTo: widget.community.caption)
        .where('usersName', isEqualTo: widget.community.usersName)
        .where('postId', isEqualTo: widget.community.postId)
        .get();

    print(widget.community.caption);

    if (postDocumentSnapshot.docs.isEmpty) {
      throw Exception('posts not found');
    }

    await postDocumentSnapshot.docs.first.reference.update({
      'comment': FieldValue.arrayUnion([commentText])
    });
    setState(() {
      communityController.comment.add(Comment(
        comment: commentText,
        usersName: userController.user.username,
        userImage: userController.user.userImage,
        timestamp: Timestamp.now(),
        firstName: userController.user.firstName,
        lastName: userController.user.lastName,
        postId: widget.community.postId,
      ));

      communityController.notifyListeners();

      commentController.clear();
      FocusNode focusNode = FocusNode();
      FocusScope.of(context).requestFocus(focusNode);

      for (var i = 0; i < communityController.comment.length; i++) {
        print(communityController.comment[i].comment);
      }

      commentLength = communityController.comment.length;
    });
  }

  String getTimeString(Timestamp timestamp) {
    final now = DateTime.now();
    final commentTime = timestamp.toDate();
    final difference = now.difference(commentTime);

    if (difference.inMinutes < 60) {
      return '• ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return '• ${difference.inHours} hr';
    } else {
      return '• ${difference.inDays} days';
    }
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < widget.community.heart.length; i++) {
      if (widget.realUser.user.username == widget.community.heart[i]) {
        widget.community.isHeart = true;
      } else {
        widget.community.isHeart = false;
      }
    }
    final postTime = widget.community.timestamp.toDate();
    final currentTime = DateTime.now();
    final difference = currentTime.difference(postTime);
    final minutes = difference.inMinutes;
    return Scaffold(
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        backgroundColor: const Color(0x3ff0C0D11),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              // Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) => TabsScreen(
                    email: widget.email,
                    communityTabs: 1,
                    tabsScreen: 0,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
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
                        '@${widget.community.usersName}',
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
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: Text(
                DateFormat('h:mm a • MMM d, yyyy')
                    .format(widget.community.timestamp.toDate()),
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Color(0x3ff797979),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (widget.community.isImage)
              Column(
                children: [
                  Image.network(
                    widget.community.imagePost,
                    height: 200,
                    width: 450,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      widget.community.caption,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                  const Divider(
                    color: Color(0x3ff797979),
                    thickness: 0.5,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: onTapHeart,
                          child: Image.asset(
                            widget.community.isHeart == false
                                ? 'assets/images/community_images/post_community/heart.png'
                                : 'assets/images/community_images/post_community/hearted.png',
                            height: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.community.heart.length.toString(),
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
                          commentLength.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            color: Color(0x3ff797979),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color(0x3ff797979),
                    thickness: 0.5,
                    indent: 0,
                    endIndent: 0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: AnimatedBuilder(
                        animation: userController,
                        builder: (context, snapshot) {
                          if (userController.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: ClipOval(
                                  child: Image.network(
                                    userController.user.userImage,
                                    height: 45,
                                    width: 45,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
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
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0x3ff454545)),
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
                          );
                        }),
                  ),
                  AnimatedBuilder(
                      animation: communityController,
                      builder: (context, snapshot) {
                        // if (communityController.isLoading) {
                        //   return const Center(
                        //     child: CircularProgressIndicator(),
                        //   );
                        // }
                        return Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0;
                                  i < communityController.comment.length;
                                  i++)
                                //   if (i < widget.userComment.length)

                                Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipOval(
                                          child: Image.network(
                                            communityController
                                                .comment[i].userImage,
                                            height: 45,
                                            width: 45,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 18,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${communityController.comment[i].firstName} ${communityController.comment[i].lastName}",
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
                                              communityController
                                                  .comment[i].comment,
                                              style: GoogleFonts.inter(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 2, 0, 0),
                                          child: Text(
                                              '@${communityController.comment[i].usersName}',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                color: const Color(0x3ff797979),
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 2, 0, 0),
                                          child: Text(
                                            getTimeString(communityController
                                                .comment[i].timestamp),
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              color: const Color.fromARGB(
                                                  255, 248, 216, 216),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
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
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
