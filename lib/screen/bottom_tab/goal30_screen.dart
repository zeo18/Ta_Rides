import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ta_rides/models/goal30_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
import 'package:ta_rides/widget/all_controller/goal30_controller.dart';
import 'package:ta_rides/widget/goal30/goal30_1stTab.dart';
import 'package:ta_rides/widget/goal30/goal30_2ndTab.dart';
import 'package:ta_rides/widget/goal30/goal30_3rdTab.dart';
import 'package:ta_rides/widget/goal30/goal30_BMI_screen.dart';
import 'package:ta_rides/widget/goal30/goal30_trackgoal.dart';

class Goal30Screen extends StatefulWidget {
  const Goal30Screen({
    super.key,
    required this.user,
    required this.email,
  });

  final Users user;
  final String email;

  @override
  State<Goal30Screen> createState() => _Goal30ScreenState();
}

final _goal30PageController = PageController();

class _Goal30ScreenState extends State<Goal30Screen> {
  Goal30Controller goal30Controller = Goal30Controller();
  bool check = false;
  late Goal30 goals30;

  @override
  void initState() {
    goal30Controller.getUserGoal30(widget.user.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user.firstName);

    return AnimatedBuilder(
        animation: goal30Controller,
        builder: (context, snapshot) {
          if (goal30Controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            backgroundColor: const Color(0x3fff0C0D11),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                goal30Controller.goal30.category,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
              ),
              backgroundColor: const Color(0x3fff0C0D11),
              actions: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          check = !check;
                        });
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                    if (check)
                      InkWell(
                        onTap: () async {
                          final goal = await FirebaseFirestore.instance
                              .collection('goal30')
                              .where('userName',
                                  isEqualTo: widget.user.username)
                              .get();

                          goals30 = Goal30.fromDocument(goal.docs.first);

                          for (var i = 0; i < goals30.goalLenght; i++) {
                            await goal.docs.first.reference.update({
                              'userData': false,
                              'day${i + 1}': false,
                            });
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TabsScreen(
                                email: widget.email,
                                tabsScreen: 3,
                                communityTabs: 0,
                              ),
                            ),
                          );
                        },
                        child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Image.asset(
                              'assets/images/reset.png',
                            )),
                      ),
                  ],
                ),
              ],
            ),
            body: Column(
              children: [
                if (goal30Controller.goal30.userData)
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Goal30TrackGoal(
                        user: widget.user,
                        goal30: goal30Controller.goal30,
                      ),
                    ],
                  ),
                if (goal30Controller.goal30.userData == false)
                  Row(
                    children: [
                      Text(
                        '   GOAL 30',
                        style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                if (goal30Controller.goal30.userData == false)
                  const SizedBox(
                    height: 10,
                  ),
                if (goal30Controller.goal30.userData == false)
                  Expanded(
                    child: PageView(
                      controller: _goal30PageController,
                      children: [
                        const Goal30_1stTab(),
                        const Goal30_2ndTab(),
                        Goal30_3rdTab(
                          user: widget.user,
                          email: widget.user.email,
                        ),
                      ],
                    ),
                  ),
                if (goal30Controller.goal30.userData == false)
                  SmoothPageIndicator(
                    controller: _goal30PageController,
                    count: 3,
                    effect: const JumpingDotEffect(
                      activeDotColor: Colors.white,
                      dotHeight: 3,
                      dotWidth: 30,
                    ),
                  ),
                if (goal30Controller.goal30.userData == false)
                  const SizedBox(
                    height: 30,
                  )
              ],
            ),
          );
        });
  }
}
