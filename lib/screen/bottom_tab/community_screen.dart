// import 'package:flutter/material.dart';
// import 'package:ta_rides/models/community_info.dart';
// import 'package:ta_rides/models/user_info.dart';
// import 'package:ta_rides/widget/tab_widget/events.dart';
// import 'package:ta_rides/widget/tab_widget/for_you.dart';
// import 'package:ta_rides/widget/tab_widget/search.dart';

// class CommunityScreen extends StatefulWidget {
//   const CommunityScreen({
//     super.key,
//     required this.selectTab,
//     required this.userUse,
//     required this.communityPosted,
//     required this.userPosted,
//     required this.community,
//     required this.achievements,
//   });

//   final int selectTab;
//   final Users userUse;
//   final List<Users> userPosted;
//   final List<Post> communityPosted;
//   final Community? community;
//   final Achievements? achievements;

//   @override
//   State<CommunityScreen> createState() => _CommunityScreenState();
// }

// class _CommunityScreenState extends State<CommunityScreen> {
//   int selectedTab = 0;

//   @override
//   void initState() {
//     super.initState();
//     selectedTab = widget.selectTab;
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(['communityID', widget.userUse.communityId]);
//     print(['isCommunity', widget.userUse.isCommunity]);
//     print(['List<Users>', widget.userPosted.length]);
//     print(['List<Post>', widget.communityPosted.length]);
//     if (widget.community != null) {
//       print(['community', widget.community!.title]);
//     }
//     return DefaultTabController(
//       length: 3,
//       initialIndex: selectedTab,
//       child: Scaffold(
//         backgroundColor: const Color(0x3ff0c0d11),
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Text(
//             'Community',
//             style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//           backgroundColor: const Color(0x3ff0c0d11),
//           // backgroundColor: Colors.red,
//         ),
//         body: Column(
//           children: [
//             TabBar(
//               indicatorSize: TabBarIndicatorSize.label,
//               indicatorWeight: 4,
//               indicatorColor: const Color(0x3ffff0000),
//               tabs: [
//                 Tab(
//                   child: Text(
//                     'Search',
//                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                 ),
//                 Tab(
//                   child: Text(
//                     'For You',
//                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                 ),
//                 Tab(
//                   child: Text(
//                     'Events',
//                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   // SearchTab(
//                   //   userUse: widget.userUse,
//                   //   achievements: widget.achievements,
//                   // ),
//                   ForYouTabs(
//                     communityPosted: widget.communityPosted,
//                     userPosted: widget.userPosted,
//                     userUse: widget.userUse,
//                     community: widget.community,
//                   ),
//                   const EventsTab(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
