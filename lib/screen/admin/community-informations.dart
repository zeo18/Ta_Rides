import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/screen/admin/admin_user.dart';
import 'package:ta_rides/screen/community/public_screen.dart';

import '../../widget/all_controller/post_controller.dart';

class CommunityInformations extends StatefulWidget {
  final Community community;

  const CommunityInformations({Key? key, required this.community})
      : super(key: key);

  @override
  State<CommunityInformations> createState() => _CommunityInformationsState();
}

class _CommunityInformationsState extends State<CommunityInformations> {
  PostController postController = PostController();

  @override
  void initState() {
    postController.getPost(widget.community.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Implement the UI for displaying community information
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 13, 17),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 13, 17),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '${widget.community.title} ',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              final delete = await FirebaseFirestore.instance
                  .collection('community')
                  .where('id', isEqualTo: widget.community.id)
                  .get();

              await delete.docs.first.reference.delete().then(
                    (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const SuperAdminScreen(),
                      ),
                    ),
                  );
            },
            child: SizedBox(
              width: 120,
              height: 30,
              child: Stack(
                children: [
                  Positioned(
                    right: 10,
                    top: 12,
                    child: Container(
                      width: 92,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFF0000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30,
                    top: 18,
                    child: Text(
                      'Delete user',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 500,
                height: 150, // Adjust the height as needed
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.community.coverImage),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "  ${widget.community.title.replaceRange(0, 1, widget.community.title[0].toUpperCase())}",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.community.private ? "  Private group" : "  Public",
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 125, 125, 125),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Text(
                    "  ${widget.community.members.length} members", // Replace with the actual property name
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
                child: Text(
                  "${widget.community.description} members", // Replace with the actual property name
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Divider(color: Colors.white),
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
            ],
          ),
        ),
      ),
    );
  }
}
