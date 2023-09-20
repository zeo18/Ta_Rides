// import 'package:flutter/material.dart';
// import 'package:ta_rides/data/community_data.dart';
// import 'package:ta_rides/data/user_data.dart';
// import 'package:ta_rides/models/community_info.dart';
// import 'package:ta_rides/models/user_info.dart';
// import 'package:ta_rides/screen/bottom_tab/pedal_screen.dart';
// import 'package:ta_rides/screen/bottom_tab/profile_dart.dart';
// import 'package:ta_rides/screen/bottom_tab/rides_screen.dart';

// import 'community_screen.dart';
// import 'goal30_screen.dart';

// class TabsScreen extends StatefulWidget {
//   const TabsScreen({
//     super.key,
//     required this.user,
//     required this.community,
//     required this.communityPosted,
//     required this.selectTab,
//     required this.userPosted,
//     required this.achievements,
//     required this.selectButtomTab,
//   });

//   final Users user;
//   final int selectButtomTab;
//   final int selectTab;
//   final List<Users> userPosted;
//   final List<Post> communityPosted;
//   final Community? community;
//   final Achievements? achievements;

//   @override
//   State<TabsScreen> createState() {
//     return _TabsScreenState();
//   }
// }

// class _TabsScreenState extends State<TabsScreen> {
//   int _selectedPageIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     // Set the initial selected page index based on selectButtomTab
//     _selectedPageIndex = widget.selectButtomTab;
//   }

//   void selectedPage(int index) {
//     setState(() {
//       _selectedPageIndex = index;
//     });
//     print(_selectedPageIndex);
//   }

//   void _editProfile(Users newUser) {
//     // setState(() {

//     //   UserInformation.add(user);
//     // });
//     setState(() {
//       // Find the index of the user to be edited in UserInformation list
//       _selectedPageIndex = widget.selectButtomTab;

//       // UserInformation.remove(newUser);
//       // UserInformation.add(newUser);
//       int index = UserInformation.indexWhere((user) => user.id == newUser.id);

//       UserInformation[index] = newUser;
//       print(['fuck nasud ba', UserInformation[index].firstName]);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Community> communities = CommunityInformation;

//     late var communityUser = widget.community;

//     setState(() {
//       if (widget.community != null) {
//         print('hello');
//         for (var community in communities) {
//           print('hello2');
//           if (widget.user.communityId == community.id) {
//             communityUser = community;
//             print(['correct2', communityUser!.title]);
//             break; // Break the loop after finding a match for the current user
//           }
//         }
//       }
//     });

//     Widget activePage = CommunityScreen(
//       selectTab: widget.selectTab,
//       community: communityUser,
//       communityPosted: widget.communityPosted,
//       userPosted: widget.userPosted,
//       userUse: widget.user,
//       achievements: widget.achievements,
//     );

//     //var activePageTitle = 'Community';

//     if (_selectedPageIndex == 1) {
//       activePage = const RidesScreen();
//       //    activePageTitle = 'Rides';
//     }
//     if (_selectedPageIndex == 2) {
//       activePage = const PedalScreen();
//       //   activePageTitle = 'Pedal';
//     }
//     if (_selectedPageIndex == 3) {
//       activePage = const Goal30Screen();
//       //   activePageTitle = 'Goal30';
//     }
//     if (_selectedPageIndex == 4) {
//       // activePage = ProfileScreen(
//       //   user: widget.user,
//       //   community: widget.community,
//       //   communityPosted: widget.communityPosted,
//       //   userPosted: widget.userPosted,
//       //   achievements: widget.achievements,
//       //   onEditProfile: _editProfile,
//       // );
//       // //   activePageTitle = 'You';
//     }

//     return Scaffold(
//       body: activePage,
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: const Color(0x3ff0c0d11),
//         onTap: selectedPage,
//         currentIndex: _selectedPageIndex,
//         fixedColor: const Color(0x3ffff0000),
//         items: [
//           if (_selectedPageIndex == 0)
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 'assets/images/community.png',
//                 height: 30,
//                 width: 30,
//                 color: const Color(0x3ffff0000),
//               ),
//               label: 'Community',
//               backgroundColor: const Color(0x3ff0c0d11),
//             )
//           else
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 'assets/images/community.png',
//                 height: 30,
//                 width: 30,
//               ),
//               label: 'Community',
//               backgroundColor: const Color(0x3ff0c0d11),
//             ),
//           if (_selectedPageIndex == 1)
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 'assets/images/rides.png',
//                 height: 30,
//                 width: 30,
//                 color: const Color(0x3ffff0000),
//               ),
//               label: 'Rides',
//               backgroundColor: const Color(0x3ff0c0d11),
//             )
//           else
//             BottomNavigationBarItem(
//               icon:
//                   Image.asset('assets/images/rides.png', height: 30, width: 30),
//               label: 'Rides',
//               backgroundColor: const Color(0x3ff0c0d11),
//             ),
//           if (_selectedPageIndex == 2)
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 'assets/images/pedal.png',
//                 height: 30,
//                 width: 30,
//                 color: const Color(0x3ffff0000),
//               ),
//               label: 'Pedal',
//               backgroundColor: const Color(0x3ff0c0d11),
//             )
//           else
//             BottomNavigationBarItem(
//               icon:
//                   Image.asset('assets/images/pedal.png', height: 30, width: 30),
//               label: 'Pedal',
//               backgroundColor: const Color(0x3ff0c0d11),
//             ),
//           if (_selectedPageIndex == 3)
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 'assets/images/goal30.png',
//                 height: 30,
//                 width: 30,
//                 color: const Color(0x3ffff0000),
//               ),
//               label: 'Goal 30',
//               backgroundColor: const Color(0x3ff0c0d11),
//             )
//           else
//             BottomNavigationBarItem(
//               icon: Image.asset('assets/images/goal30.png',
//                   height: 30, width: 30),
//               label: 'Goal 30',
//               backgroundColor: const Color(0x3ff0c0d11),
//             ),
//           if (_selectedPageIndex == 4)
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 'assets/images/profile.png',
//                 height: 30,
//                 width: 30,
//                 color: const Color(0x3ffff0000),
//               ),
//               label: 'You',
//               backgroundColor: const Color(0x3ff0c0d11),
//             )
//           else
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 'assets/images/profile.png',
//                 height: 30,
//                 width: 30,
//               ),
//               label: 'You',
//               backgroundColor: const Color(0x3ff0c0d11),
//             ),
//         ],
//       ),
//     );
//   }
// }
