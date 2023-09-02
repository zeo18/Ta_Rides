import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/user_info.dart';

class AchievementsTabs extends StatelessWidget {
  const AchievementsTabs({
    super.key,
    required this.user,
    required this.achievements,
  });

  final Users user;
  final Achievements? achievements;

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
          if (user.isAchievement)
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
                    if (achievements!.legendary)
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
                    if (achievements!.legendary)
                      const SizedBox(
                        height: 10,
                      ),
                    if (achievements!.challenger)
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
                    if (achievements!.challenger)
                      const SizedBox(
                        height: 10,
                      ),
                    if (achievements!.roadMaster)
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
                    if (achievements!.roadMaster)
                      const SizedBox(
                        height: 10,
                      ),
                    if (achievements!.noSweat)
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
                    if (achievements!.noSweat)
                      const SizedBox(
                        height: 10,
                      ),
                    if (achievements!.calvesGoBrrr)
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
                    if (achievements!.calvesGoBrrr)
                      const SizedBox(
                        height: 10,
                      ),
                    if (achievements!.newbie)
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
