import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';
import 'package:intl/intl.dart';

class ProfileTabs extends StatelessWidget {
  const ProfileTabs({super.key, required this.user});

  final UserController user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text(
              'Informations',
              style: GoogleFonts.inter(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Card(
            color: const Color(0xff282828),
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.hardEdge,
            elevation: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Username:   ',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: const Color(0x3ffE8AA0A),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                        ),
                        Text(
                          user.user.username,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          'Email:   ',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: const Color(0x3ffE8AA0A),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                        ),
                        Text(
                          user.user.email,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          'Birthdate: ',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: const Color(0x3ffE8AA0A),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                        ),
                        Text(
                          DateFormat('MMMM dd, yyyy')
                              .format(user.user.birthdate),
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          'Gender:   ',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: const Color(0x3ffE8AA0A),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                        ),
                        Text(
                          user.user.gender.toString().split('.').last,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          'Location:   ',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: const Color(0x3ffE8AA0A),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                        ),
                        Text(
                          user.user.location,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          'Phone Number:   ',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: const Color(0x3ffE8AA0A),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                        ),
                        Text(
                          user.user.phoneNumber,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
