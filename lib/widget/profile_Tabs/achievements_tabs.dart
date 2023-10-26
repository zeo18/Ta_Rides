import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/data/user_data.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';

class AchievementsTabs extends StatefulWidget {
  const AchievementsTabs({
    super.key,
    required this.user,
  });

  final UserController user;

  @override
  State<AchievementsTabs> createState() => _AchievementsTabsState();
}

class _AchievementsTabsState extends State<AchievementsTabs> {
  Achievements achievement = achievementsInformation[0];

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
              'Your Achievements',
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
          if (widget.user.user.isAchievement)
            Card(
              color: const Color(0xff282828),
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.hardEdge,
              elevation: 10,
              child: Container(
                margin: const EdgeInsets.fromLTRB(30, 10, 20, 10),
                child: Column(
                  children: [
                    if (achievement.legendary)
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/user_images/Achievements/legendary.png',
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Legendary',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    if (achievement.legendary)
                      const SizedBox(
                        height: 10,
                      ),
                    if (achievement.challenger)
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/user_images/Achievements/challenger.png',
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Challenger',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    if (achievement.challenger)
                      const SizedBox(
                        height: 10,
                      ),
                    if (achievement.roadMaster)
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/user_images/Achievements/roadMaster.png',
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Road Master',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    if (achievement.roadMaster)
                      const SizedBox(
                        height: 10,
                      ),
                    if (achievement.noSweat)
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/user_images/Achievements/noSweat.png',
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'No Sweat',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    if (achievement.noSweat)
                      const SizedBox(
                        height: 10,
                      ),
                    if (achievement.calvesGoBrrr)
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/user_images/Achievements/calves.png',
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Calves Go Brrr',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    if (achievement.calvesGoBrrr)
                      const SizedBox(
                        height: 10,
                      ),
                    if (achievement.newbie)
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/user_images/Achievements/newbie.png',
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Newbie',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            )
          else
            Text(
              'No Achievements',
              style: GoogleFonts.inter(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            )
        ],
      ),
    );
  }
}
