import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/screen/bottom_tab/pedal_screen.dart';
import 'package:ta_rides/screen/bottom_tab/rides_screen.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
import 'package:ta_rides/widget/all_controller/community_controller.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';

class RequestChallenge extends StatefulWidget {
  const RequestChallenge({
    super.key,
    required this.email,
    required this.community,
  });

  final Community community;
  final String email;
  @override
  State<RequestChallenge> createState() => _RequestChallengeState();
}

class _RequestChallengeState extends State<RequestChallenge> {
  final _captionPostController = TextEditingController();
  final _distancePostController = TextEditingController();
  final _meetUpTime = TextEditingController();
  UserController userController = UserController();
  CommunityController communityController = CommunityController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userController.setEmail(widget.email);
    userController.getUser(widget.email);
    communityController.getCommunityAndUser(widget.email);
    super.initState();
  }

  void submitChallenge() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      print(_captionPostController.text);
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('rides').doc();

      await FirebaseFirestore.instance.collection('rides').add({
        'ridesID': docRef.id,
        'caption': _captionPostController.text,
        'userCommunityId': userController.user.communityId,
        'communityId': widget.community.id,
        'communityImage': communityController.community!.coverImage,
        'communitytitle': communityController.community!.title,
        'userFirstname': userController.user.firstName,
        'userLastname': userController.user.lastName,
        'userImage': userController.user.userImage,
        'userUsername': userController.user.username,
        'meetUp': _distancePostController.text,
        'timeMeetUp': _meetUpTime.text,
        'isUser': false,
        'timePost': DateTime.now(),
        'userWinner': false,
        'enemyWinner': false,
        'enemyJoined': DateTime.now(),
        'isEnemy': false,
        'enemyFirstname': '',
        'enemyLastname': '',
        'enemyImage': '',
        'enemyUsername': '',
        'enemyCommunityId': '',
        'enemyCommunityTitle': '',
        'enemyCommunityImage': '',
        'userStart': false,
        'userFinished': false,
        'enemyStart': false,
        'enemyFinished': false,
        'userLat': 0.0,
        'userLng': 0.0,
        'enemyLat': 0.0,
        'enemyLng': 0.0,
        'startLat': 0.0,
        'startLng': 0.0,
        'midLat': 0.0,
        'midLng': 0.0,
        'endLat': 0.0,
        'endLng': 0.0,
        'startLoc': '',
        'midLoc': '',
        'endLoc': '',
      }).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TabsScreen(
                    email: widget.email,
                    communityTabs: 0,
                    tabsScreen: 1,
                  )),
        );
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Invalid Input',
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request Challenge',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
        ),
        backgroundColor: const Color(0x3ff0C0D11),
      ),
      backgroundColor: const Color(0x3ff0C0D11),
      body: AnimatedBuilder(
          animation: userController,
          builder: (context, snapshot) {
            if (userController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    if (userController.user.communityId == widget.community.id)
                      const Text(
                        'Are you sure you want to request a challenge with your own team?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    else
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Are you sure you want to request a challenge with a memeber of the ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                            ),
                            TextSpan(
                              text: '${widget.community.title}?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Color(0x3ffE89B05),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        ClipOval(
                          child: Image.network(
                            userController.user.userImage,
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${userController.user.firstName.replaceRange(0, 1, userController.user.firstName[0].toUpperCase())} ${userController.user.lastName.replaceRange(0, 1, userController.user.lastName[0].toUpperCase())}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14,
                                      ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(Icons.verified,
                                    color: Colors.green, size: 15)
                              ],
                            ),
                            Text(
                              '@${userController.user.username}',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Color(0x3ff797979),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'LOCATION MEET UP : ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 500,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Please enter place';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _distancePostController.text = value!;
                              },
                              controller: _distancePostController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(113, 69, 69, 69),
                                hintText: "Please enter place",
                                hintStyle: GoogleFonts.inter(
                                  color: const Color(0x3ff454545),
                                  fontSize: 15,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0x3ff454545)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            'TIME MEET UP : ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 500,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Please enter time';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _meetUpTime.text = value!;
                              },
                              controller: _meetUpTime,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(113, 69, 69, 69),
                                hintText: "Please enter time",
                                hintStyle: GoogleFonts.inter(
                                  color: const Color(0x3ff454545),
                                  fontSize: 15,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0x3ff454545)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
                      onPressed: submitChallenge,
                      child: Text(
                        'Send to Challenge',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
