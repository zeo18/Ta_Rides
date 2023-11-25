import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/screen/auth/createAccount.dart';
import 'package:ta_rides/widget/all_controller/community_controller.dart';
import 'package:ta_rides/widget/all_controller/search_controller.dart';
import 'package:ta_rides/widget/create_group/create_group_screen.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';
import 'package:ta_rides/widget/tab_widget/search_community/community_list_search.dart';
import 'package:ta_rides/widget/tab_widget/search_community/recent_search.dart';

class SearchTabs extends StatefulWidget {
  const SearchTabs({
    super.key,
    required this.email,
  });

  final String email;
  @override
  State<SearchTabs> createState() => _SearchTabsState();
}

class _SearchTabsState extends State<SearchTabs> {
  final _searchController = TextEditingController();
  UserController userController = UserController();
  CommunityController communityController = CommunityController();
  var isChecked = false;
  String searchQuery = '';
  late SearchController searchController;

  @override
  void initState() {
    userController.getUser(widget.email);
    communityController.getCommunityAndUser(widget.email);
    communityController.getAllCommunity();
    searchController = SearchController();
    super.initState();
  }

  void closeKeyboard() {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    if (!isKeyboardVisible) {
      setState(() {
        isChecked = false;
      });
    }
  }

  void onClickSearch() {
    // inig click sa search
    print('hello');
    setState(() {
      isChecked = true;
    });
  }

  void createGroup() {
    final idCommunity =
        FirebaseFirestore.instance.collection('community').doc().id;
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => CreateGroup(
                user: userController,
                email: widget.email,
                onSelectedPrivacy: 0,
                idCommunity: idCommunity,
              )),
    );
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

  //   void searchCommunity(String query) {
  //   final suggestions = CommunityInformation.where((commu) {
  //     final communityTitle = commu.title.toLowerCase();
  //     final input = query.toLowerCase();
  //     return communityTitle.contains(input);
  //   }).toList();
  //   setState(() {
  //     community = suggestions;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: TextField(
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
        ),
        if (isChecked)
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
            child: Text(
              'Suggested Search',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
                    itemBuilder: (context, index) => CommunityListSearch(
                      community: communityController.communities[index],
                      email: widget.email,
                      searchController: searchController,

                      // orderRecentSearch: (community) {
                      //   orderRecentSearchCommunity(context, community);
                      // },
                      // community: community[index],
                      // onSelectedCommunity: (community, user, post) {
                      //   selectCommunity(context, community, user, post);
                      // },
                      // onRecentSearch: _recentSearchCommunity,
                      // user: UserInformation,
                      // post: PostCommunity,
                    ),
                  ),
                );
              }),
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
                children: [
                  if (userController.user.isCommunity == false)
                    Container(
                      padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                      child: IconButton(
                        onPressed: createGroup,
                        icon: Image.asset(
                          'assets/images/createGroup.png',
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        if (isChecked == false)
          Row(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                child: Text(
                  'Recent Searches',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(140, 0, 0, 8),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      searchController.clear();
                    });
                  },
                  child: Text(
                    'Clear searches',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color(0x3ff454545),
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.right,
                  ),
                ),
              )
            ],
          ),
        if (isChecked == false)
          Expanded(
            child: GridView(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 3,
              ),
              children: [
                for (var i = 0; i < searchController.recentSearches.length; i++)
                  RecentSearch(
                    community: searchController.recentSearches[i],
                    email: widget.email,

                    // searchController: searchController,
                    // orderRecentSearch: (community) {
                    //   orderRecentSearchGridView(context, community);
                    // },
                    // community: communityRecentSearch,
                    // onTapRecentSearch: (community, user, post) {
                    //   selectCommunity(
                    //       context, community, UserInformation, PostCommunity);
                    // },
                    // user: UserInformation,
                    // post: PostCommunity,
                    // onClickPrivateGroup: (community) {
                    //   privateGroup(context, community);
                    // },
                    // onPublicGroup: (community, userUse, users, post) {
                    //   publicGroup(context, community, userUse, users, post);
                    // },
                    // userUse: widget.userUse,
                  )
              ],
            ),
          ),
      ],
    );
  }
}





































// class SearchTab extends StatefulWidget {
//   const SearchTab({
//     super.key,
//     // required this.userUse,
//     // required this.achievements,
//   });

//   // final Users userUse;
//   // final Achievements? achievements;

//   @override
//   State<SearchTab> createState() => _SearchTabState();
// }

// class _SearchTabState extends State<SearchTab> {
//   final _searchController = TextEditingController();
//   List<Community> community = CommunityInformation;
//   List<Post> post = PostCommunity;
//   // List<Users> users = UserInformation;

//   var isChecked = false;
//   var isOrderChecked = false;

//   final List<Community> _recentSearchCommunity = [];
//   List<Community> _OrderRecentSearch = [];

//   void orderRecentSearchCommunity(BuildContext context, Community community) {
//     setState(() {
//       _OrderRecentSearch.removeWhere((c) => c.title == community.title);

//       _OrderRecentSearch.insert(0, community);

//       if (_OrderRecentSearch.length > 10) {
//         _OrderRecentSearch.removeLast();
//       }
//     });
//   }

//   void orderRecentSearchGridView(BuildContext context, Community community) {
//     _OrderRecentSearch.remove(community);

//     var i = 0;

//     var orderCheck = false;
//     setState(() {
//       if (orderCheck == false) {
//         _OrderRecentSearch.insert(i, community);
//         print('i = $i');
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void selectCommunity(BuildContext context, Community community,
//       List<Users> user, List<Post> post) {
//     final communityPost = PostCommunity.where(
//             (post) => post.communityId.toString() == community.id.toString())
//         .toList();

//     List<Users> userPost = [];
//     for (var post in communityPost) {
//       for (var user in UserInformation) {
//         if (post.usersName == user.username) {
//           print([post.usersName.toString(), user.username.toString()]);
//           userPost.add(user);
//         }
//       }
//     }
//     // final userPost = UserInformation.where((user) =>
//     //     user.username.toString() ==
//     //     post.where((element) =>
//     //         element.usersName.toString() == user.username.toString())).toList();
//     // print(['user length', user.length]);
//     // print(['communityPost', communityPost]);
//     // print(['userPost', userPost]);

//     //   Navigator.of(context).push(
//     //     MaterialPageRoute(
//     //       builder: (ctx) => ViewCommunityScreen(
//     //         post: communityPost,
//     //         user: userPost,
//     //         community: community,
//     //         onClickPrivateGroup: (community) {
//     //           privateGroup(context, community);
//     //         },
//     //         // onPublicGroup: (community, userUse, users, post) {
//     //         //   publicGroup(context, community, userUse, users, post);
//     //         // },
//     //         userUse: widget.userUse,
//     //         users: user,
//     //         posts: post,
//     //       ),
//     //     ),
//     //   );
//     // }

//     // void searchCommunity(String query) {
//     //   final suggestions = CommunityInformation.where((commu) {
//     //     final communityTitle = commu.title.toLowerCase();
//     //     final input = query.toLowerCase();
//     //     return communityTitle.contains(input);
//     //   }).toList();
//     //   setState(() {
//     //     community = suggestions;
//     //   });
//     // }

//     void onClickSearch() {
//       // inig click sa search
//       print('hello');
//       setState(() {
//         isChecked = true;
//       });
//     }

//     // int onSelectPrivacy = 0;
//     // void createGroup() {
//     //   Navigator.of(context).push(
//     //     MaterialPageRoute(
//     //       builder: (ctx) => CreateGroup(
//     //         user: widget.userUse,
//     //         onAddCommunity: _addCommunity,
//     //         onAddPost: _addPosting,
//     //         onSelectedPrivacy: onSelectPrivacy,
//     //       ),
//     //     ),
//     //   );
//     // }

//     void joinGroup(BuildContext context, Community community) {
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (ctx) => JoinGroupScreen(community: community),
//         ),
//       );
//     }

//     void _addPosting(Post post) {
//       setState(() {
//         PostCommunity.insert(0, post);
//       });
//     }

//     // void _addCommunity(Community community) {
//     //   setState(() {
//     //     CommunityInformation.add(community);
//     //     widget.userUse.isCommunity = true;
//     //     widget.userUse.communityId = community.id;
//     //   });
//     // }

//     void submittedSearch() {
//       setState(() {
//         isChecked = false;
//       });
//     }

//     void closeKeyboard() {
//       final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
//       if (!isKeyboardVisible) {
//         submittedSearch();
//       }
//     }

//     void clearRecentSearch() {
//       setState(() {
//         print('fuck chan');
//         _OrderRecentSearch = [];
//       });
//     }

//     void privateGroup(BuildContext context, Community community) {
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (ctx) => PrivateConditionScreen(community: community),
//         ),
//       );
//     }

//     // void publicGroup(BuildContext context, Community community, Users userUse,
//     //     List<Users> users, List<Post> post) {
//     //   userUse.isCommunity = true;
//     //   userUse.communityId = community.id;

//     //   final communityPost = PostCommunity.where(
//     //           (post) => post.communityId.toString() == community.id.toString())
//     //       .toList();

//     //   List<Users> userPost = [];
//     //   for (var post in communityPost) {
//     //     for (var user in UserInformation) {
//     //       if (post.usersName == user.username) {
//     //         print([post.usersName.toString(), user.username.toString()]);
//     //         userPost.add(user);
//     //       }
//     //     }
//     //   }
//     //   int selectButtom = 0;
//     //   int selectTab = 1;
//     //   Navigator.pushReplacement(
//     //     context,
//     //     MaterialPageRoute(
//     //         builder: (ctx) => TabsScreen(
//     //               user: widget.userUse,
//     //               community: community,
//     //               communityPosted: communityPost,
//     //               selectTab: selectTab,
//     //               userPosted: userPost,
//     //               achievements: widget.achievements,
//     //               selectButtomTab: selectButtom,
//     //             )),
//     //   );
//     // }

//     // void postCommunity() {
//     //   ListView.builder(itemBuilder: (ctx, index) => PostCommunityScreen());
//     // }

//     @override
//     Widget build(BuildContext context) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
//             child: TextField(
//               style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//               cursorColor: Colors.white,
//               onTap: onClickSearch,
//               // onChanged: searchCommunity,
//               textInputAction: TextInputAction.done,
//               onSubmitted: (value) {
//                 _searchController.clear();
//                 closeKeyboard();
//               },
//               controller: _searchController,
//               decoration: InputDecoration(
//                 suffixIcon: IconButton(
//                   onPressed: () {
//                     FocusScope.of(context).unfocus();
//                   },
//                   icon: Image.asset(
//                     'assets/images/iconSearch.png',
//                     height: 45,
//                     width: 45,
//                   ),
//                 ),
//                 label: Text(
//                   '   Search',
//                   style: GoogleFonts.inter(
//                     color: const Color(0x3ff454545),
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Color(0x3ffe89b05)),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.white),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//           ),
//           if (isChecked)
//             Container(
//               padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
//               child: Text(
//                 'Suggested Search',
//                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//             ),
//           // if (isChecked)
//           // Expanded(
//           //   child: ListView.builder(
//           //       itemCount: community.length,
//           //       itemBuilder: (context, index) {
//           //         final commu = CommunityListSearch(
//           //           orderRecentSearch: (community) {
//           //             orderRecentSearchCommunity(context, community);
//           //           },
//           //           community: community[index],
//           //           onSelectedCommunity: (community, user, post) {
//           //             selectCommunity(context, community, user, post);
//           //           },
//           //           onRecentSearch: _recentSearchCommunity,
//           //           user: UserInformation,
//           //           post: PostCommunity,
//           //         );

//           //         return commu;
//           //       }),
//           // ),
//           if (isChecked == false)
//             Container(
//               padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
//               // child: IconButton(
//               //   // onPressed: createGroup,
//               //   icon: Image.asset(
//               //     'assets/images/createGroup.png',
//               //     height: 40,
//               //     fit: BoxFit.cover,
//               //   ),
//               // ),
//             ),
//           if (isChecked == false)
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
//                   child: Text(
//                     'Recent Searches',
//                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(140, 0, 0, 8),
//                   child: TextButton(
//                     onPressed: clearRecentSearch,
//                     child: Text(
//                       'Clear searches',
//                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             color: const Color(0x3ff454545),
//                             fontWeight: FontWeight.bold,
//                           ),
//                       textAlign: TextAlign.right,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           // if (isChecked == false)
//           // Expanded(
//           //   child: GridView(
//           //     padding: const EdgeInsets.all(15),
//           //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           //       crossAxisCount: 2,
//           //       childAspectRatio: 1.3,
//           //       crossAxisSpacing: 8,
//           //       mainAxisSpacing: 3,
//           //     ),
//           //     children: [
//           //       for (final communityRecentSearch in _OrderRecentSearch)
//           //         RecentSearch(
//           //           orderRecentSearch: (community) {
//           //             orderRecentSearchGridView(context, community);
//           //           },
//           //           community: communityRecentSearch,
//           //           onTapRecentSearch: (community, user, post) {
//           //             selectCommunity(
//           //                 context, community, UserInformation, PostCommunity);
//           //           },
//           //           user: UserInformation,
//           //           post: PostCommunity,
//           //           onClickPrivateGroup: (community) {
//           //             privateGroup(context, community);
//           //           },
//           //           onPublicGroup: (community, userUse, users, post) {
//           //             publicGroup(context, community, userUse, users, post);
//           //           },
//           //           userUse: widget.userUse,
//           //         )
//           //     ],
//           //   ),
//           // ),
//         ],
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ta_rides/data/community_data.dart';
// import 'package:ta_rides/data/user_data.dart';
// import 'package:ta_rides/models/community_info.dart';
// import 'package:ta_rides/models/user_info.dart';
// import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
// import 'package:ta_rides/screen/community/join_group_screen.dart';
// import 'package:ta_rides/screen/community/private_condition_screen.dart';
// import 'package:ta_rides/screen/community/view_community_screen.dart';
// import 'package:ta_rides/widget/tab_widget/search_community/community_list_search.dart';
// import 'package:ta_rides/widget/tab_widget/search_community/recent_search.dart';

// import '../create_group/create_group_screen.dart';
