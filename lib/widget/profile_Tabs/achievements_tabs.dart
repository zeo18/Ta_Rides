import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/data/user_data.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';

class AchievementsTabs extends StatefulWidget {
  const AchievementsTabs({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<AchievementsTabs> createState() => _AchievementsTabsState();
}

class _AchievementsTabsState extends State<AchievementsTabs> {
  UserController userController = UserController();

  @override
  void initState() {
    userController.setEmail(widget.email);
    userController.getAchievement(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: userController,
        builder: (context, snapshot) {
          if (userController.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            margin: const EdgeInsets.all(10),
            child: SingleChildScrollView(
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
                  Card(
                    color: const Color(0xff282828),
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.hardEdge,
                    elevation: 10,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Column(
                        children: [
                          if (userController.achievement.legendary)
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
                          if (userController.achievement.legendary)
                            const SizedBox(
                              height: 10,
                            ),
                          if (userController.achievement.challenger)
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
                          if (userController.achievement.challenger)
                            const SizedBox(
                              height: 10,
                            ),
                          if (userController.achievement.roadMaster)
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
                          if (userController.achievement.roadMaster)
                            const SizedBox(
                              height: 10,
                            ),
                          if (userController.achievement.noSweat)
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
                          if (userController.achievement.noSweat)
                            const SizedBox(
                              height: 10,
                            ),
                          if (userController.achievement.calvesGoBrrr)
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
                          if (userController.achievement.calvesGoBrrr)
                            const SizedBox(
                              height: 10,
                            ),
                          if (userController.achievement.newbie)
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
                          if (userController.achievement.newbie)
                            const SizedBox(
                              height: 10,
                            ),
                          if (userController.achievement.resilientgoal30)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/goal30/resilient30.png',
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Resilient Rider Badge Goal 30',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          if (userController.achievement.consistentGoal30)
                            const SizedBox(
                              height: 10,
                            ),
                          if (userController.achievement.consistentGoal30)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/goal30/consistent30.png',
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Consistent Challenger Badge Goal 30',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          if (userController.achievement.consistentGoal30)
                            const SizedBox(
                              height: 10,
                            ),
                          if (userController.achievement.flawlessGoal30)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/goal30/flawless30.png',
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Flawless Challenger Badge Goal 30',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          if (userController.achievement.flawlessGoal30)
                            const SizedBox(
                              height: 10,
                            ),
                          if (userController.achievement.resilientgoal60)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/goal30/resilient60.png',
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Resilient Rider Badge Goal 60',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          if (userController.achievement.consistentGoal60)
                            const SizedBox(
                              height: 10,
                            ),
                          if (userController.achievement.consistentGoal60)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/goal30/consistent60.png',
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Consistent Challenger Badge Goal 60',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          if (userController.achievement.consistentGoal60)
                            const SizedBox(
                              height: 10,
                            ),
                          if (userController.achievement.flawlessGoal60)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/goal30/flawless60.png',
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Flawless Challenger Badge Goal 60',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          if (userController.achievement.flawlessGoal60)
                            const SizedBox(
                              height: 10,
                            ),
                          if (userController.achievement.resilientgoal90)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/goal30/resilient90.png',
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Resilient Rider Badge Goal 90',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          if (userController.achievement.consistentGoal90)
                            const SizedBox(
                              height: 10,
                            ),
                          if (userController.achievement.consistentGoal90)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/goal30/consistent90.png',
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Consistent Challenger Badge Goal 90',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          if (userController.achievement.consistentGoal90)
                            const SizedBox(
                              height: 10,
                            ),
                          if (userController.achievement.flawlessGoal90)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/goal30/flawless90.png',
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Flawless Challenger Badge Goal 90',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          if (userController.achievement.flawlessGoal90)
                            const SizedBox(
                              height: 10,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
