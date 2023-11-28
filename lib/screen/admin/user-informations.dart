import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:intl/intl.dart';
import 'package:ta_rides/screen/admin/admin_user.dart';
import 'package:ta_rides/widget/all_controller/community_controller.dart';

class UserInformation extends StatefulWidget {
  final Users users;

  const UserInformation({
    super.key,
    required this.users,
  });

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  CommunityController communityController = CommunityController();

  @override
  void initState() {
    communityController.getCommunityAndUser(widget.users.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          'User Information',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              final delete = await FirebaseFirestore.instance
                  .collection('users')
                  .where('username', isEqualTo: widget.users.username)
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
                    top: 0,
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
                    top: 7,
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
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0), // adjust this value to move the picture
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white, // change this color for the outline
                      width: 3.0, // change this width for the outline thickness
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      widget.users.userImage,
                      height: 10,
                      width: 10,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Flexible(
                  child: Text(
                    "${widget.users.lastName.replaceRange(0, 1, widget.users.lastName[0].toUpperCase())},\n${widget.users.firstName.replaceRange(0, 1, widget.users.firstName[0].toUpperCase())}",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Add a SizedBox for spacing, adjust the height as needed
          const SizedBox(height: 30),
          // Add a Column for user information text
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedBuilder(
                  animation: communityController,
                  builder: (context, snapchat) {
                    if (communityController.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Column(
                      children: [
                        if (communityController.community == null)
                          RichText(
                            text: TextSpan(
                              text: "Community: ",
                              style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 232, 170, 10),
                              ),
                              children: [
                                const TextSpan(
                                  text: "\n", //space between the two text spans
                                ),
                                TextSpan(
                                  text: 'No community',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          RichText(
                            text: TextSpan(
                              text: "Community: ",
                              style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 232, 170, 10),
                              ),
                              children: [
                                const TextSpan(
                                  text: "\n", //space between the two text spans
                                ),
                                TextSpan(
                                  text:
                                      "${communityController.community!.title}",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    text: "Username: ",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 232, 170, 10),
                    ),
                    children: [
                      const TextSpan(
                        text: "\n", //space between the two text spans
                      ),
                      TextSpan(
                        text: "${widget.users.username}",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    text: "Email: ",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 232, 170, 10),
                    ),
                    children: [
                      const TextSpan(
                        text: "\n", //space between the two text spans
                      ),
                      TextSpan(
                        text: "${widget.users.email}",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                      text: "Birthdate: ",
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 232, 170, 10),
                      ),
                      children: [
                        const TextSpan(
                          text: "\n", //space between the two text spans
                        ),
                        TextSpan(
                          text: DateFormat('yyyy-MM-dd')
                              .format(widget.users.birthdate),
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    text: "Gender: ",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 232, 170, 10),
                    ),
                    children: [
                      const TextSpan(
                        text: "\n", //space between the two text spans
                      ),
                      TextSpan(
                        text: "${widget.users.gender}",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    text: "Location: ",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 232, 170, 10),
                    ),
                    children: [
                      const TextSpan(
                        text: "\n", //space between the two text spans
                      ),
                      TextSpan(
                        text: "${widget.users.location}",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    text: "Phone Number: ",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 232, 170, 10),
                    ),
                    children: [
                      const TextSpan(
                        text: "\n", //space between the two text spans
                      ),
                      TextSpan(
                        text: "${widget.users.phoneNumber}",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
