import 'package:flutter/material.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/community/private_condition_screen.dart';
import 'package:ta_rides/screen/community/view_community_screen.dart';
import 'package:ta_rides/widget/all_controller/private_community_controller.dart';
import 'package:ta_rides/widget/all_controller/search_controller.dart';

class RecentSearch extends StatefulWidget {
  const RecentSearch({
    super.key,
    // required this.community,
    // required this.onTapRecentSearch,
    // required this.orderRecentSearch,
    // required this.user,
    // required this.post,
    // required this.onClickPrivateGroup,
    // required this.onPublicGroup,
    // required this.userUse,
    required this.email,
    required this.community,
  });
  final Community community;
  final String email;

  @override
  State<RecentSearch> createState() => _RecentSearchState();
}

class _RecentSearchState extends State<RecentSearch> {
  PrivateCommunityController privateController = PrivateCommunityController();

  @override
  void initState() {
    privateController.getPrivate(widget.community.id);
    super.initState();
  }

  // final void Function(Community community) orderRecentSearch;
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => ViewCommunityScreen(
                  community: widget.community,
                  email: widget.email,
                ),
              ));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 52,
              width: 52,
              padding: const EdgeInsets.fromLTRB(8, 10, 4, 4),
              child: ClipOval(
                child: Image.network(
                  widget.community.coverImage,
                  fit: BoxFit.cover,
                ),
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
                      widget.community.title,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Text(
                    widget.community.description,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: const Color(0x3ff797979),
                        fontWeight: FontWeight.bold,
                        fontSize: 9),
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
