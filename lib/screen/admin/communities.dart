import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/screen/admin/community-display.dart';
import 'package:ta_rides/widget/all_controller/community_controller.dart';

class Communities extends StatefulWidget {
  const Communities({super.key});

  @override
  State<Communities> createState() => _CommunitiesState();
}

class _CommunitiesState extends State<Communities> {
  late FocusNode _focusNode;
  CommunityController communityController = CommunityController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    communityController.getAllCommunity();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All groups',
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        AnimatedBuilder(
          animation: communityController,
          builder: (context, snapshot) {
            if (communityController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Expanded(
              child: GridView(
                padding: const EdgeInsets.all(2),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing:
                      4, // Decrease this value to reduce the horizontal space between the items
                  mainAxisSpacing:
                      4, // Decrease this value to reduce the vertical space between the items
                ),
                children: [
                  for (var i = 0;
                      i < communityController.communities.length;
                      i++)
                    CommunityDisplay(
                      community: communityController.communities[i],
                    )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
