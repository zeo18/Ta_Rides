import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/profile_Tabs/achievements_tabs.dart';
import 'package:ta_rides/widget/profile_Tabs/profile_tabs.dart';
import 'package:ta_rides/widget/profile_Tabs/progress_tabs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user});

  final Users user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectTab = 0;

  void selectedPage(int index) {
    setState(() {
      selectTab = index;
    });
    print(selectTab);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: selectTab,
      child: Scaffold(
        backgroundColor: const Color(0x3ff0c0d11),
        appBar: AppBar(
          title: Text(
            'You',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: const Color(0x3ff0c0d11),
        ),
        body: Column(
          children: [
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3.5,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  widget.user.userImage,
                  height: 130,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "${widget.user.lastName}, ${widget.user.firstName} ",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            if (selectTab == 0)
              Stack(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Followers',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: const Color(0x3ff666666),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 10,
                                      ),
                                ),
                                Text(
                                  widget.user.followers.toString(),
                                  style: GoogleFonts.inter(
                                    fontSize: 25,
                                    color: const Color(0x3ffe8aa0a),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 60,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Following',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: const Color(0x3ff666666),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 10,
                                      ),
                                ),
                                Text(
                                  widget.user.following.toString(),
                                  style: GoogleFonts.inter(
                                    fontSize: 25,
                                    color: const Color(0x3ffe8aa0a),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 205,
                    child: Image.asset(
                      'assets/images/user_images/line.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            if (selectTab == 1)
              Text(
                'Community',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
              ),
            const SizedBox(
              height: 20,
            ),
            TabBar(
              labelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4,
              indicatorColor: const Color(0x3ffff0000),
              onTap: selectedPage,
              tabs: const [
                Tab(
                  text: 'Profile',
                  // child: Text(
                  //   'Profile',
                  //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 18,
                  //       ),
                  // ),
                ),

                Tab(
                  text: "Achievements",
                  // child: Text(
                  //   'Achievements',
                  //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 18,
                  //       ),
                  // ),
                ),
                Tab(
                  text: 'Progress',
                )
                // Tab(
                // text: 'Progress'
                // child: Text(
                //   'Progress',
                //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 18,
                // )
                //),
                // ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ProfileTabs(user: widget.user),
                  AchievementsTabs(user: widget.user),
                  ProgressTabs(user: widget.user),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
