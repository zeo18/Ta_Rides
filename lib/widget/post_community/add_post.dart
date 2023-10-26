import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';

class AddPostCommunity extends StatefulWidget {
  const AddPostCommunity({
    super.key,

    // required this.user,
    // required this.onAddPost,
    // required this.community,
    required this.user,
    required this.email,
  });

  // final Users user;
  // final Function(Post post) onAddPost;
  // final Community community;
  final String email;
  final UserController user;

  @override
  State<AddPostCommunity> createState() => _AddPostCommunityState();
}

class _AddPostCommunityState extends State<AddPostCommunity> {
  File? _postImage;
  final _formKey = GlobalKey<FormState>();
  final _captionPostController = TextEditingController();
  bool onClickPostImage = false;

  void _addPost() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();

      final idCommunity = widget.user.user.communityId;

      final postRef = FirebaseFirestore.instance.collection('post').doc();
      final postId = postRef.id;

      if (_postImage != null) {
        final storageRef = FirebaseStorage.instance.ref().child('post_image');
        final postImageRef = await storageRef.putFile(_postImage!);
        final postImageUrl = await postImageRef.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('post').add({
          'postId': postId,
          'caption': _captionPostController.text,
          'communityId': idCommunity,
          'heart': [],
          'imagePost': postImageUrl, // modify this line
          'isImage': onClickPostImage,
          'userId': widget.user.user.id,
          'usersName': widget.user.user.username,
          'comment': [],
          'isHeart': false,
          'timestamp': Timestamp.now(),
        });
      } else {
        await FirebaseFirestore.instance.collection('post').add({
          'postId': postId,
          'caption': _captionPostController.text,
          'communityId': idCommunity,
          'heart': [],
          'imagePost': '',
          'isImage': onClickPostImage,
          'userId': widget.user.user.id,
          'usersName': widget.user.user.username,
          'comment': [],
          'isHeart': false,
          'timestamp': Timestamp.now(),
        });
      }
    }

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (ctx) => TabsScreen(
                  email: widget.email,
                  communityTabs: 1,
                  tabsScreen: 0,
                )));
  }

  @override
  void dispose() {
    _captionPostController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 100, maxWidth: 400);
    if (pickedImage == null) {
      return;
    }

    setState(() {
      _postImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        backgroundColor: const Color(0x3ff0C0D11),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Stack(
            children: [
              if (_postImage != null)
                Container(
                  height: 504,
                  width: 395,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      color: const Color(0x3ff454545),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                )
              else
                Container(
                  height: 293,
                  width: 395,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      color: const Color(0x3ff454545),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              if (_postImage != null)
                Positioned(
                  top: 60,
                  left: 2.3,
                  child: Container(
                    height: 260,
                    width: 387,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(_postImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              if (_postImage != null)
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 320, 0, 0),
                  child: TextFormField(
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter a caption';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _captionPostController.text = value!;
                    },
                    controller: _captionPostController,
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(113, 69, 69, 69),
                      hintText: "What’s on your mind?",
                      hintStyle: GoogleFonts.inter(
                        color: const Color(0x3ff454545),
                        fontSize: 15,
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0x3ff454545)),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                    ),
                    maxLines: 6,
                  ),
                )
              else
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                  child: TextFormField(
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter a caption';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _captionPostController.text = value!;
                    },
                    controller: _captionPostController,
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(113, 69, 69, 69),
                      hintText: "What’s on your mind?",
                      hintStyle: GoogleFonts.inter(
                        color: const Color(0x3ff454545),
                        fontSize: 15,
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0x3ff454545)),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                    ),
                    maxLines: 8,
                  ),
                ),
              Positioned(
                bottom: 20,
                right: 115,
                child: IconButton(
                  onPressed: () {
                    _pickImage();
                    setState(() {
                      onClickPostImage = true;
                    });
                  },
                  icon: Image.asset(
                    'assets/images/community_images/post_community/addImage.png',
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 26,
                right: 20,
                child: InkWell(
                  onTap: _addPost,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white,
                        width: 1.4,
                      ),
                    ),
                    child: Text(
                      'Post',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Image(
                            image: NetworkImage(widget.user.user.userImage),
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.user.user.lastName}, ${widget.user.user.firstName} ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'member of this group',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: const Color(0x3ff797979),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
