import 'package:flutter/material.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/community/view_community_screen.dart';
import 'package:ta_rides/widget/all_controller/search_controller.dart';
import 'package:ta_rides/widget/rides/request_challenge.dart';

class RidesCommunityList extends StatelessWidget {
  const RidesCommunityList({
    super.key,
    // required this.community,
    // required this.onSelectedCommunity,
    // required this.onRecentSearch,
    // required this.orderRecentSearch,
    // required this.user,
    // required this.post,
    required this.community,
    required this.email,
    required this.searchController,
  });

  final Community community;
  final String email;
  final SearchController searchController;
  // final void Function(Community community) orderRecentSearch;
  // final List<Community> onRecentSearch;
  // final Community community;
  // final void Function(Community community, List<Users> user, List<Post> post)
  //     onSelectedCommunity;
  // final List<Users> user;
  // final List<Post> post;

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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => RequestChallenge(
                  community: community,
                  email: email,
                ),
              ));
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: ClipOval(
                      child: Image(
                        image: NetworkImage(community.coverImage),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          community.title,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          community.private ? 'Private' : 'Public',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: const Color(0x3ff797979),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                        ),
                        Text(
                          community.description,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: const Color(0x3ff797979),
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
