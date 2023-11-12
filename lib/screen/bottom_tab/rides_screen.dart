import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/widget/all_controller/community_controller.dart';
import 'package:ta_rides/widget/all_controller/rides_controller.dart';
import 'package:ta_rides/widget/all_controller/search_controller.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';
import 'package:ta_rides/widget/rides/community_list.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({
    super.key,
    required this.email,
  });

  final String email;
  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  CommunityController communityController = CommunityController();
  UserController userController = UserController();
  final _searchController = TextEditingController();
  var isChecked = false;
  String searchQuery = '';
  late SearchController searchController;
  RidesController ridesController = RidesController();

  @override
  void initState() {
    userController.getUser(widget.email);
    communityController.getCommunityAndUser(widget.email);
    communityController.getAllCommunity();
    searchController = SearchController();
    // ridesController.getUserRide(rideId);
    super.initState();
  }

  void onClickSearch() {
    // inig click sa search
    print('hello');
    setState(() {
      isChecked = true;
    });
  }

  void searchCommunity(String query) {
    if (query.isEmpty) {
      setState(() {
        searchQuery = '';
        communityController.getCommunityAndUser(widget.email);
      });
      return;
    }
    final suggestions = communityController.communities.where((commu) {
      final communityTitle = commu.title.toLowerCase();
      final input = query.toLowerCase();
      return communityTitle.contains(input);
    }).toList();
    setState(() {
      searchQuery = query;
      communityController.communities = suggestions;
    });
  }

  void closeKeyboard() {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    if (!isKeyboardVisible) {
      setState(() {
        isChecked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Rides',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: const Color(0x3ff0C0D11),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Engage in a wide range of challenges and activities to earn valuable achievements and rewards!',
              style: GoogleFonts.inter(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              cursorColor: Colors.white,
              onTap: onClickSearch,
              onChanged: searchCommunity,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                _searchController.clear();
                closeKeyboard();
              },
              controller: _searchController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  icon: Image.asset(
                    'assets/images/iconSearch.png',
                    height: 45,
                    width: 45,
                  ),
                ),
                label: Text(
                  '   Search',
                  style: GoogleFonts.inter(
                    color: const Color(0x3ff454545),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0x3ffe89b05)),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            if (isChecked)
              AnimatedBuilder(
                animation: communityController,
                builder: (context, snapshot) {
                  if (communityController.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: communityController.communities.length,
                      itemBuilder: (context, index) => RidesCommunityList(
                        community: communityController.communities[index],
                        email: widget.email,
                        searchController: searchController,
                      ),
                    ),
                  );
                },
              ),
            if (isChecked == false)
              AnimatedBuilder(
                  animation: userController,
                  builder: (context, snapshot) {
                    if (userController.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Your Team',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Container(
                          height: 150,
                          width: 500,
                          child: Card(
                            color: const Color(0xff282828),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            clipBehavior: Clip.hardEdge,
                            elevation: 10,
                            child: Container(
                              margin: const EdgeInsets.all(25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedBuilder(
                                      animation: communityController,
                                      builder: (context, snapshot) {
                                        if (communityController.isLoading) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (communityController.community ==
                                            null) {
                                          return Text(
                                            'You are not in a community yet.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          );
                                        }
                                        return Text(
                                          communityController
                                                  .community!.title.isEmpty
                                              ? 'You are not in a community yet.'
                                              : communityController
                                                  .community!.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        );
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      ClipOval(
                                        child: Image.network(
                                          userController.user.userImage,
                                          height: 45,
                                          width: 45,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${userController.user.firstName.replaceRange(0, 1, userController.user.firstName[0].toUpperCase())} ${userController.user.lastName.replaceRange(0, 1, userController.user.lastName[0].toUpperCase())}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 14,
                                                    ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Icon(Icons.verified,
                                                  color: Colors.green, size: 15)
                                            ],
                                          ),
                                          Text(
                                            '@${userController.user.username}',
                                            style: GoogleFonts.inter(
                                              fontSize: 15,
                                              color: Color(0x3ff797979),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Enemy Team',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        AnimatedBuilder(
                            animation: ridesController,
                            builder: (context, snapshot) {
                              if (ridesController.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return SizedBox();
                              // return Column(
                              //   children: [
                              //     if (ridesController.ride.isEnemy == true)
                              //       Container(
                              //         height: 150,
                              //         width: 500,
                              //         child: Card(
                              //           color: const Color(0xff282828),
                              //           shape: RoundedRectangleBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(15),
                              //           ),
                              //           clipBehavior: Clip.hardEdge,
                              //           elevation: 10,
                              //           child: Container(
                              //             margin: const EdgeInsets.all(25),
                              //             child: Column(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: [
                              //                 Text(
                              //                   ridesController
                              //                       .ride.enemyCommunityTitle,
                              //                   style: Theme.of(context)
                              //                       .textTheme
                              //                       .bodyLarge!
                              //                       .copyWith(
                              //                         color: Colors.white,
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                       ),
                              //                 ),
                              //                 const SizedBox(
                              //                   height: 10,
                              //                 ),
                              //                 Row(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   children: [
                              //                     const SizedBox(
                              //                       width: 10,
                              //                     ),
                              //                     ClipOval(
                              //                       child: Image.network(
                              //                         ridesController
                              //                             .ride.enemyImage,
                              //                         height: 45,
                              //                         width: 45,
                              //                         fit: BoxFit.cover,
                              //                       ),
                              //                     ),
                              //                     const SizedBox(
                              //                       width: 10,
                              //                     ),
                              //                     Column(
                              //                       crossAxisAlignment:
                              //                           CrossAxisAlignment
                              //                               .start,
                              //                       children: [
                              //                         Row(
                              //                           children: [
                              //                             Text(
                              //                               "${ridesController.ride.enemyFirstname.replaceRange(0, 1, ridesController.ride.enemyFirstname[0].toUpperCase())} ${ridesController.ride.enemyLastname.replaceRange(0, 1, ridesController.ride.enemyLastname[0].toUpperCase())}",
                              //                               style: Theme.of(
                              //                                       context)
                              //                                   .textTheme
                              //                                   .titleMedium!
                              //                                   .copyWith(
                              //                                     color: Colors
                              //                                         .white,
                              //                                     fontWeight:
                              //                                         FontWeight
                              //                                             .w900,
                              //                                     fontSize: 14,
                              //                                   ),
                              //                             ),
                              //                             const SizedBox(
                              //                               width: 5,
                              //                             ),
                              //                             const Icon(
                              //                                 Icons.verified,
                              //                                 color:
                              //                                     Colors.green,
                              //                                 size: 15)
                              //                           ],
                              //                         ),
                              //                         Text(
                              //                           '@${ridesController.ride.enemyUsername}',
                              //                           style:
                              //                               GoogleFonts.inter(
                              //                             fontSize: 15,
                              //                             color: Color(
                              //                                 0x3ff797979),
                              //                             fontWeight:
                              //                                 FontWeight.w500,
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //       )
                              //     else
                              //       Center(
                              //         child: Column(
                              //           children: [
                              //             const SizedBox(
                              //               height: 100,
                              //             ),
                              //             Text(
                              //               'No Compitetor',
                              //               style: Theme.of(context)
                              //                   .textTheme
                              //                   .titleMedium!
                              //                   .copyWith(
                              //                     color: Colors.white,
                              //                     fontWeight: FontWeight.w900,
                              //                     fontSize: 14,
                              //                   ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //   ],
                              // );
                            }),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0x3ffFF0000),
                            minimumSize: const Size(
                              375,
                              45,
                            ),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Pick a Route',
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
                        const SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0x3ffFF0000),
                            minimumSize: const Size(
                              375,
                              45,
                            ),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Start',
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
                    );
                  })
          ],
        ),
      ),
    );
  }
}
