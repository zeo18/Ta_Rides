import 'package:flutter/material.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/tab_widget/events.dart';
import 'package:ta_rides/widget/tab_widget/for_you.dart';
import 'package:ta_rides/widget/tab_widget/search.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({
    super.key,
    required this.user,
  });

  final Users user;

  @override
  Widget build(BuildContext context) {
    List<Post> post = PostCommunity;
    void PassValuePost() {
      List<Post> post = PostCommunity;
      ListView.builder(
        itemCount: post.length,
        itemBuilder: (context, index) => SearchTab(user: user),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0x3ff0c0d11),
        appBar: AppBar(
          title: Text(
            'Community',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: const Color(0x3ff0c0d11),
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
              child: TabBarView(children: [
                SearchTab(user: user),
                ForYouTabs(user: user),
                EventsTab(user: user),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
