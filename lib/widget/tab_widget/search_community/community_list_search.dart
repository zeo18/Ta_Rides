import 'package:flutter/material.dart';
import 'package:ta_rides/data/community_date.dart';

import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';

class CommunityListSearch extends StatelessWidget {
  const CommunityListSearch({
    super.key,
    required this.community,
    required this.onSelectedCommunity,
    required this.onRecentSearch,
    required this.orderRecentSearch,
    required this.user,
    required this.post,
  });
  final void Function(Community community) orderRecentSearch;
  final List<Community> onRecentSearch;
  final Community community;
  final void Function(Community community, Users user, Post post)
      onSelectedCommunity;
  final Users user;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff282828),
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 10,
      child: InkWell(
        onTap: () {
          onSelectedCommunity(community, user, post);
          onRecentSearch.add(community);
          orderRecentSearch(community);
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Image(
                image: AssetImage(community.image),
                height: 50,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    community.title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    community.description,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: const Color(0x3ff797979),
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
