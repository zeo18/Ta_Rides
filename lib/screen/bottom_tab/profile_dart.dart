import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/auth/logInPage.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
import 'package:ta_rides/widget/all_controller/pedal_controller.dart';
import 'package:ta_rides/widget/profile_Tabs/achievements_tabs.dart';
import 'package:ta_rides/widget/profile_Tabs/edit_profile.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';
import 'package:ta_rides/widget/profile_Tabs/profile_tabs.dart';
import 'package:ta_rides/widget/profile_Tabs/progress_tabs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.email,
    //   required this.community,
    //   required this.communityPosted,
    //   required this.userPosted,
    //   required this.achievements,
    //   required this.onEditProfile,
  });

  final String email;
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
  UserController userController = UserController();
  PedalController pedalController = PedalController();

  void selectedPage(int index) {
    setState(() {
      selectTab = index;
    });
    print(selectTab);
  }

  @override
  void initState() {
    print('hello');
    userController.setEmail(widget.email);
    userController.getUser(widget.email);
    userController.getAchievement(widget.email);
    pedalController.getPedal(widget.email);

    super.initState();
  }

  // Future getUser() async {
  //   return await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('email', isEqualTo: widget.email)
  //       .get();
  // }

  void signOutUser() async {
    await FirebaseAuth.instance.signOut().then(
          (value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          ),
        );
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
              actions: [
                IconButton(
                  onPressed: () {
                    signOutUser();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
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
                    child: Image.network(
                      userController.user.userImage,
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
                  '${userController.user.firstName.replaceRange(0, 1, userController.user.firstName[0].toUpperCase())} ${userController.user.lastName.replaceRange(0, 1, userController.user.lastName[0].toUpperCase())}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: (userController.user.firstName.length +
                                    userController.user.lastName.length >
                                15)
                            ? 20
                            : 25,
                      ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TabBar(
                  labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  unselectedLabelColor: const Color(0x3ff666666),
                  indicatorWeight: 4,
                  indicatorColor: const Color(0x3ffff0000),
                  onTap: selectedPage,
                  tabs: const [
                    Tab(
                      text: 'Profile',
                    ),
                    Tab(
                      text: "Achievements",
                    ),
                    Tab(
                      text: 'Progress',
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ProfileTabs(user: userController),
                      AchievementsTabs(
                        email: widget.email,
                      ),
                      AnimatedBuilder(
                          animation: pedalController,
                          builder: (context, snapshot) {
                            if (pedalController.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Text(
                                    'History',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: pedalController.pedal.length,
                                      itemBuilder: (context, index) =>
                                          ProgressTabs(
                                            user: userController,
                                            pedal: pedalController.pedal[index],
                                          )),
                                ),
                              ],
                            );

                            // ;
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

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
