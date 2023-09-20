import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
import 'package:ta_rides/widget/profile_Tabs/achievements_tabs.dart';
import 'package:ta_rides/widget/profile_Tabs/edit_profile.dart';
import 'package:ta_rides/widget/profile_Tabs/profile_tabs.dart';
import 'package:ta_rides/widget/profile_Tabs/progress_tabs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.user,
    //   required this.community,
    //   required this.communityPosted,
    //   required this.userPosted,
    //   required this.achievements,
    //   required this.onEditProfile,
  });

  final Users user;
  // final Community? community;
  // // final List<Users> userPosted;
  // // final List<Post> communityPosted;
  // final Achievements? achievements;
  // final Function(Users users) onEditProfile;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectTab = 0;
  int selectButtomTab = 0;

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
              automaticallyImplyLeading: false,
              title: Text(
                'You',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              backgroundColor: const Color(0x3ff0c0d11),
            ),
            body: Column(children: [
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
                )
            ] //
                ) //
            ) //
        ); //

    // if (selectTab == 1)
    //   // // // // widget.community == null
    //   // // //     ? Container(
    //   // // //         child: const Text("No Community"),
    //   // // //       )
    //   // //     : Column(
    //   // //         children: [
    //   // //           Text(
    //   // //             'Community',
    //   // //             style:
    //   // //                 Theme.of(context).textTheme.titleMedium!.copyWith(
    //   // //                       color: const Color(0x3ffe8aa0a),
    //   // //                       fontWeight: FontWeight.bold,
    //   // //                       fontSize: 10,
    //   // //                     ),
    //   // //           ),
    //   //           // InkWell(
    //   //           //   onTap: () {
    //   //           //     Navigator.push(
    //   //           //       context,
    //   //           //       MaterialPageRoute(
    //   //           //         builder: (ctx) => TabsScreen(
    //   //           //           user: widget.user,
    //   //           //           community: widget.community,
    //   //           //           communityPosted: widget.communityPosted,
    //   //           //           selectTab: selectTab,
    //   //           //           userPosted: widget.userPosted,
    //   //           //           achievements: widget.achievements,
    //   //           //           selectButtomTab: selectButtomTab,
    //   //           //         ),
    //   //           //       ),
    //   //           //     );
    //   //           //   },
    //   //             // child:
    //   //             Card(
    //   //               color: const Color(0xff282828),
    //   //               shape: RoundedRectangleBorder(
    //   //                 borderRadius: BorderRadius.circular(50),
    //   //               ),
    //   //               clipBehavior: Clip.hardEdge,
    //   //               elevation: 10,
    //   //               child: Container(
    //   //                 padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
    //   //                 child: Text(
    //   //                   widget.community!.id.toString(),
    //   //                   style: Theme.of(context)
    //   //                       .textTheme
    //   //                       .titleMedium!
    //   //                       .copyWith(
    //   //                         color: Colors.white,
    //   //                         fontWeight: FontWeight.bold,
    //   //                         fontSize: 12,
    //   //                       ),
    //   //                 ),
    //   //               ),
    //   //             ),
    //   //           )
    //   //         ],
    //   //       ),
    // if (selectTab == 2)
    //   // widget.community == null || widget.achievements == null
    //   //     ? Container(
    //   //         child: const Text("No Community"),
    //   //       )
    //   //     : InkWell(
    //   //         onTap: () {
    //   //           Navigator.push(
    //   //             context,
    //   //             MaterialPageRoute(
    //   //                 builder: (ctx) => ProfileEdit(
    //   //                       user: widget.user,
    //   //                       onEditProfile: widget.onEditProfile,
    //   //                       achievements: widget.achievements!,
    //   //                       community: widget.community,
    //   //                       communityPosted: widget.communityPosted,
    //   //                       userPosted: widget.userPosted,
    //   //                     )),
    //   //           );
    //   //         },
    //           // child:
    //           Container(
    //             padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(20),
    //               border: Border.all(
    //                 color: Colors.white, // Border color
    //                 width: 1, // Border width
    //               ),
    //             ),
    //             child: Text(
    //               'Edit',
    //               style:
    //                   Theme.of(context).textTheme.titleLarge!.copyWith(
    //                         color: Colors.white,
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 12,
    //                       ),
    //             ),
    //           ),
    //         ),
    // const SizedBox(
    //   height: 20,
    // ),
    // TabBar(
    //   labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
    //         color: Colors.white,
    //         fontWeight: FontWeight.bold,
    //         fontSize: 18,
    //       ),
    //   indicatorSize: TabBarIndicatorSize.label,
    //   isScrollable: true,
    //   unselectedLabelColor: const Color(0x3ff666666),
    //   indicatorWeight: 4,
    //   indicatorColor: const Color(0x3ffff0000),
    //   onTap: selectedPage,
    //   tabs: const [
    //     Tab(
    //       text: 'Profile',
    //     ),
    //     Tab(
    //       text: "Achievements",
    //     ),
    //     Tab(
    //       text: 'Progress',
    //     )
    //   ],
    // ),
    // // Expanded(
    // //   child: TabBarView(
    // //     children: [
    // //       ProfileTabs(user: widget.user),
    // //       AchievementsTabs(
    // //         user: widget.user,
    // //         achievements: widget.achievements,
    // //       ),
    // //       ProgressTabs(user: widget.user),
    //     // ],
    //   ),
    // ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
