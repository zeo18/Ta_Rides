import 'package:flutter/material.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/all_controller/community_controller.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';
import 'package:ta_rides/widget/tab_widget/events.dart';
import 'package:ta_rides/widget/tab_widget/for_you.dart';
import 'package:ta_rides/widget/tab_widget/search.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({
    super.key,
    required this.email,
    required this.communityTab,

    // required this.selectTab,
    // required this.userUse,
    // required this.communityPosted,
    // required this.userPosted,
    // required this.community,
    // required this.achievements,
  });
  final String email;
  final int communityTab;
  // final int selectTab;
  // final Users userUse;
  // final List<Users> userPosted;
  // final List<Post> communityPosted;
  // final Community? community;
  // final Achievements? achievements;

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int selectedTab = 0;
  // UserController userController = UserController();
  CommunityController communityController = CommunityController();

  // @override
  // void initState() {
  //   super.initState();
  //   selectedTab = widget.selectTab;
  // }
  // @override
  // void initState() {
  //   userController.setEmail(widget.email);
  //   userController.getUser(widget.email);
  //   communityController.setEmail(widget.email);
  //   communityController.getCommunityAndUser(widget.email);
  // }

  @override
  void initState() {
    communityController.setEmail(widget.email);
    communityController.getCommunityAndUser(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.community != null) {
    //   print(['community', widget.community!.title]);
    // }
    return DefaultTabController(
      length: 3,
      initialIndex: widget.communityTab,
      child: Scaffold(
        backgroundColor: const Color(0x3ff0c0d11),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Community',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: const Color(0x3ff0c0d11),
          // backgroundColor: Colors.red,
        ),
        body: Column(
          children: [
            TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4,
              indicatorColor: const Color(0x3ffff0000),
              tabs: [
                Tab(
                  child: Text(
                    'Search',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Tab(
                  child: Text(
                    'For You',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Events',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SearchTabs(
                    email: widget.email,
                  ),
                  AnimatedBuilder(
                    animation: communityController,
                    builder: (context, snapshot) {
                      if (communityController.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (communityController.community == null) {
                        return const Center(
                          child: Text('No community found.'),
                        );
                      }
                      // ignore: unnecessary_null_comparison
                      // if (communityController.community == null) {
                      //   return const Center(
                      //     child: Text('No community found.'),
                      //   );
                      // }
                      // if(communityController.community.isEmpty){
                      //   return const Center(
                      //     child: Text('No Community'),
                      //   );
                      // }
                      return ForYouTabs(
                        email: widget.email,
                        community: communityController.community,
                        // user: userController,
                        // community: communityController,
                        // communityPosted: widget.communityPosted,
                        // userPosted: widget.userPosted,
                        // userUse: widget.userUse,
                        // community: widget.community,
                      );
                    },
                  ),
                  EventsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
