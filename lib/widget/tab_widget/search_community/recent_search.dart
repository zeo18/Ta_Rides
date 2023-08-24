import 'package:flutter/material.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';

class RecentSearch extends StatelessWidget {
  const RecentSearch(
      {super.key,
      required this.community,
      required this.onTapRecentSearch,
      required this.orderRecentSearch,
      required this.user,
      required this.post,
      required this.onClickPrivateGroup,
      required this.onPublicGroup,
      required this.userUse});

  final void Function(Community community) orderRecentSearch;
  final Community community;
  final void Function(Community community, List<Users> user, List<Post> post)
      onTapRecentSearch;
  final void Function(Community community) onClickPrivateGroup;
  final void Function(Community community, Users userUse, List<Users> users,
      List<Post> posts) onPublicGroup;
  final List<Users> user;
  final List<Post> post;
  final Users userUse;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff282828),
      margin: const EdgeInsets.symmetric(horizontal: 0.1, vertical: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 10,
      child: InkWell(
        onTap: () {
          onTapRecentSearch(community, user, post);
          orderRecentSearch(community);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(8, 10, 4, 4),
              child: Image(
                image: AssetImage(community.image),
                height: 38,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 2, 3),
                    child: Text(
                      community.title,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Text(
                    community.description,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: const Color(0x3ff797979),
                        fontWeight: FontWeight.bold,
                        fontSize: 9),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          0, 0, 3, 0), // Adjusted padding
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: () {
                            if (community.private) {
                              onClickPrivateGroup(community);
                            } else {
                              onPublicGroup(community, userUse, user, post);
                            }
                          },
                          icon: Image.asset(
                            'assets/images/joinGroup.png',
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
