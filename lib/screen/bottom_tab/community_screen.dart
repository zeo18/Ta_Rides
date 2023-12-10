import 'package:flutter/material.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
import 'package:ta_rides/screen/community/view_member_request.dart';
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
  });
  final String email;
  final int communityTab;

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int selectedTab = 0;

  CommunityController communityController = CommunityController();

  @override
  void initState() {
    communityController.setEmail(widget.email);
    communityController.getCommunityAndUser(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'User does not have community yet.',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const CircularProgressIndicator(),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff282828),
                                  minimumSize: const Size(
                                    45,
                                    45,
                                  ),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => TabsScreen(
                                        email: widget.email,
                                        tabsScreen: 0,
                                        communityTabs: 0,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Search for community',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ForYouTabs(
                        email: widget.email,
                        community: communityController.community,
                      );
                    },
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
                          return Center(
                            child: Text(
                              'User does not have community yet.',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          );
                        }
                        return EventsTab(
                          community: communityController.community,
                          email: widget.email,
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
