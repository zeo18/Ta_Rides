import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/data/user_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/auth/logInPage.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';

class CreateGroup2 extends StatefulWidget {
  const CreateGroup2({
    super.key,
    required this.user,
    required this.coverImage,
    required this.description,
    required this.isPrivate,
    required this.titleText,
    required this.email,
    required this.idCommunity,
  });
  final bool isPrivate;
  final String titleText;
  final String description;
  final File? coverImage;
  final String email;
  final String idCommunity;

  final UserController user;
  @override
  State<CreateGroup2> createState() => _CreateGroup2State();
}

class _CreateGroup2State extends State<CreateGroup2> {
  final _captionPostController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool onClickPostImage = false;
  File? _postImage;

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
  void initState() {
    print('hello');
    widget.user.setEmail(widget.email);
    widget.user.getUser(widget.email);
    widget.user.getAchievement(widget.email);
    super.initState();
  }

  void submitCreateGroup() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();

      // final idCommunity =
      //     FirebaseFirestore.instance.collection('community').doc().id;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('community_image')
          .child('${widget.idCommunity}.jpg');
      final coverImageRef = await storageRef.putFile(widget.coverImage!);
      final coverImageUrl = await coverImageRef.ref.getDownloadURL();
      // if (_postImage != null) {
      //   await storageRef.putFile(_postImage!);
      // }

      await FirebaseFirestore.instance.collection('community').add({
        'title': widget.titleText,
        'description': widget.description,
        'private': widget.isPrivate,
        'members': [widget.user.user.username],
        'coverImage': coverImageUrl,
        'id': widget.idCommunity,
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.user.id)
          .update({
        'communityId': widget.idCommunity,
        'isCommunity': true,
      });

      if (_postImage != null) {
        final idpost = FirebaseFirestore.instance.collection('post').doc().id;
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('post_image')
            .child('${idpost}.jpg');
        final postImageRef = await storageRef.putFile(_postImage!);
        final postImageUrl = await postImageRef.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('post').add({
          'postId': '',
          'caption': _captionPostController.text,
          'communityId': widget.idCommunity,
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
          'postId': '',
          'caption': _captionPostController.text,
          'communityId': widget.idCommunity,
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
      if (privateCommunity.isNotEmpty) {
        for (var i = 0; i < privateCommunity.length; i++) {
          if (privateCommunity[i].privateCommunityId == widget.idCommunity) {
            await FirebaseFirestore.instance
                .collection('private_AddQuestion')
                .add({
              'privateCommunityId': privateCommunity[i].privateCommunityId,
              'choiceQuestion': privateCommunity[i].choiceQuestion,
              'choices': privateCommunity[i].choices,
              'choicesAnswer': privateCommunity[i].choicesAnswer,
              'cheboxesQuestion': privateCommunity[i].cheboxesQuestion,
              'cheboxes': privateCommunity[i].cheboxes,
              'cheboxesAnswer': privateCommunity[i].cheboxesAnswer,
              'writtenQuestion': privateCommunity[i].writtenQuestion,
              'writtenAnswer': privateCommunity[i].writtenAnswer,
              'writeRules': privateCommunity[i].writeRules,
              'detailsRules': privateCommunity[i].detailsRules,
            });
          }
        }
      }

      privateCommunity.clear();

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (ctx) => TabsScreen(
                  email: widget.email,
                  communityTabs: 0,
                  tabsScreen: 1,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (privateCommunity.isNotEmpty) {
    //   // print(["nakasud pilay lenght", privateCommunity.length]);
    //   // print(["private community", privateCommunity[0].privateCommunityId]);
    //   // print(["community id", privateCommunity[0].privateCommunityId]);
    // }
    return AnimatedBuilder(
        animation: widget.user,
        builder: (context, snapshot) {
          if (widget.user.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            backgroundColor: const Color(0x3ff0C0D11),
            appBar: AppBar(
              backgroundColor: const Color(0x3ff0C0D11),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Make your First Post',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 25,
                                ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Pedal into the spotlight with your debut post! Share your unforgettable bicycle moments and inspire fellow riders.',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: const Color(0x3ff797979),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Stack(
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
                                    image: Image.file(_postImage!).image,
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
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15))),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0x3ff454545)),
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
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15))),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0x3ff454545)),
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
                            right: 20,
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
                            top: 10,
                            left: 10,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: Image(
                                        image: NetworkImage(
                                            widget.user.user.userImage),
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
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
                      if (_postImage != null)
                        const SizedBox(height: 30)
                      else
                        const SizedBox(height: 265),
                      Center(
                        child: Column(
                          children: [
                            Image.asset(
                                'assets/images/community_images/third.png'),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0x3ffFF0000),
                                minimumSize: const Size(
                                  375,
                                  45,
                                ),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: submitCreateGroup,
                              child: Text(
                                'Continue',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
  // final querySnapshot = await FirebaseFirestore.instance
  //       .collection('community')
  //       .where('id', isEqualTo: idCommunity)
  //       .get();

  //   final documentSnapshot = querySnapshot.docs.first;

  // void _addPost() {
  //   setState(() {
  //     if (_postImage != null) {
  //       widget.onAddPost(Post(
  //         postId: PostCommunity.length + 1,
  //         communityId: idCommunity,
  //         userId: widget.user.id,
  //         isImage: onClickPostImage,
  //         imagePost: '',
  //         usersName: widget.user.username,
  //         caption: _captionPostController.text,
  //         commment: [],
  //         commentNumber: 0,
  //         heart: 0,
  //         ifImage: _postImage!,
  //       ));
  //     } else {
  //       widget.onAddPost(Post(
  //         postId: PostCommunity.length + 1,
  //         communityId: idCommunity,
  //         userId: widget.user.id,
  //         isImage: onClickPostImage,
  //         imagePost: '',
  //         usersName: widget.user.username,
  //         caption: _captionPostController.text,
  //         commment: [],
  //         commentNumber: 0,
  //         heart: 0,
  //         ifImage: Uint8List.fromList([]),
  //       ));
  //     }
  //   });
  // }

  // void submitNewCommunity() {
  //   widget.onAddCommunity(Community(
  //     title: widget.titleText,
  //     coverImage: '',
  //     private: widget.isPrivate,
  //     description: widget.description,
  //     membersIndex: 12,
  //     members: [widget.user],
  //     image: '',
  //     id: idCommunity,
  //     ifItsImage: widget.coverImage!,
  //   ));

  //   var select = 1;
  //   Community? communityUser;
  //   List<Users>? userPost = [];
  //   Achievements? userAchievements;
  //   final List<Community> communities = CommunityInformation;
  //   print(['List of Lenght of post', PostCommunity.length]);

  //   for (int i = 0; i < PostCommunity.length; i++) {
  //     print(['Post list caption', PostCommunity[i].caption]);
  //   }
  //   // late Community communityUser;

  //   List<Post> communityPost = [];

  //   for (var post in PostCommunity) {
  //     if (post.communityId.toString() == idCommunity.toString()) {
  //       communityPost.add(post);
  //     }
  //   }

  //   for (var post in communityPost) {
  //     if (post.usersName == widget.user.username) {
  //       print([post.usersName.toString(), widget.user.username.toString()]);
  //       userPost.add(widget.user);
  //     }
  //   }

  //   for (var achieve in achievementsInformation) {
  //     if (achieve.userName == widget.user.username) {
  //       //////////////////////////////
  //       userAchievements = achieve;
  //       break;
  //     }
  //   }
  //   for (var community in communities) {
  //     if (widget.user.communityId == community.id) {
  //       communityUser = community;
  //       break;
  //     }
  //   }
  //   setState(() {
  //     widget.user.isCommunity = true;
  //     widget.user.communityId = idCommunity;
  //   });
  //   print(widget.user.communityId);

  //   var selectButtom = 0;
  //   // Navigator.pushReplacement(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //     builder: ((ctx) => TabsScreen(
  //   //           user: widget.user,
  //   //           community: communityUser!,
  //   //           communityPosted: communityPost,
  //   //           selectTab: select,
  //   //           userPosted: userPost,
  //   //           achievements: userAchievements!,
  //   //           selectButtomTab: selectButtom,
  //   //         )),
  //   //   ),
  //   // );
  // }

  // pickImage(ImageSource source) async {
  //   final ImagePicker _imagePicker = ImagePicker();
  //   XFile? _file = await _imagePicker.pickImage(source: source);
  //   if (_file != null) {
  //     return await _file.readAsBytes();
  //   }
  //   print('No image selected.');
  // }

  // void selectedImage() async {
  //   Uint8List? img = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     _postImage = img;
  //     onClickPostImage = true;
  //   });
  // }