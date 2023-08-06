import 'package:flutter/material.dart';
import 'package:ta_rides/widget/tab_widget/events.dart';
import 'package:ta_rides/widget/tab_widget/for_you.dart';
import 'package:ta_rides/widget/tab_widget/search.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() {
    return _CommunityScreenState();
  }
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0x3ff0C0D11),
        appBar: AppBar(
          title: Text(
            'Community',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: const Color(0x3ff0C0D11),
        ),
        body: Column(
          children: [
            TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4,
              indicatorColor: Colors.red,
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
            const Expanded(
              child: TabBarView(children: [
                SearchTab(),
                ForYouTabs(),
                EventsTab(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
