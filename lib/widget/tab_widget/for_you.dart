// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ta_rides/data/community_data.dart';
// import 'package:ta_rides/models/community_info.dart';
// import 'package:ta_rides/models/user_info.dart';
// import 'package:ta_rides/widget/post_community/add_post.dart';
// import 'package:ta_rides/widget/post_community/post_comunnity.dart';

// class ForYouTabs extends StatefulWidget {
//   const ForYouTabs({
//     super.key,
//     required this.communityPosted,
//     required this.userPosted,
//     required this.userUse,
//     required this.community,
//   });

//   final Users userUse;
//   final List<Users> userPosted;
//   final List<Post> communityPosted;
//   final Community? community;

//   @override
//   State<ForYouTabs> createState() => _ForYouTabsState();
// }

// class _ForYouTabsState extends State<ForYouTabs> {
//   void addPostCommunity(Post post) {
//     setState(() {
//       PostCommunity.insert(0, post);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0x3ff0C0D11),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (ctx) => AddPostCommunity(
//                         user: widget.userUse,
//                         onAddPost: addPostCommunity,
//                         community: widget.community!,
//                       )));
//         },
//         backgroundColor: Color(0x3ffFF0000),
//         shape: const CircleBorder(),
//         child: const Icon(
//           Icons.add,
//           size: 30,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (widget.userUse.isCommunity)
//               if (widget.community!.ifItsImage.isEmpty)
//                 Image.asset(
//                   widget.community!.coverImage,
//                   height: 180,
//                   width: 450,
//                   fit: BoxFit.cover,
//                 )
//               else if (widget.userUse.isCommunity)
//                 Image(
//                   image: MemoryImage(widget.community!.ifItsImage),
//                   height: 180,
//                   width: 450,
//                   fit: BoxFit.cover,
//                 ),
//             if (widget.userUse.isCommunity)
//               Stack(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.community!.title,
//                           style:
//                               Theme.of(context).textTheme.titleLarge!.copyWith(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                   ),
//                           textAlign: TextAlign.left,
//                         ),
//                         Row(
//                           children: [
//                             if (widget.community!.private)
//                               Text(
//                                 'Private Group',
//                                 style: GoogleFonts.inter(
//                                   fontSize: 14,
//                                   color: const Color(0x3ff808080),
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               )
//                             else
//                               Text(
//                                 'Public Group',
//                                 style: GoogleFonts.inter(
//                                   fontSize: 14,
//                                   color: const Color(0x3ff808080),
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             const SizedBox(
//                               width: 2,
//                             ),
//                             if (widget.community!.private)
//                               const Icon(
//                                 Icons.lock,
//                                 color: Color(0x3ff808080),
//                                 size: 15,
//                               ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             Container(
//                               padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
//                               child: Text(
//                                 '.',
//                                 style: GoogleFonts.inter(
//                                   fontSize: 15,
//                                   color: const Color(0x3ff808080),
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             Text(
//                               widget.community!.membersIndex.toString(),
//                               style: GoogleFonts.inter(
//                                 fontSize: 14,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             Text(
//                               'members',
//                               style: GoogleFonts.inter(
//                                 fontSize: 14,
//                                 color: const Color(0x3ff808080),
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           widget.community!.description,
//                           style: GoogleFonts.inter(
//                             fontSize: 16,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     top: 15,
//                     right: 20,
//                     child: Image.asset(
//                       'assets/images/joinedGroup.png',
//                       height: 35,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ],
//               ),
//             if (widget.userUse.isCommunity)
//               const Divider(
//                 color: Color(0x3ff797979),
//                 thickness: 1.0,
//                 indent: 10,
//                 endIndent: 10,
//               ),
//             if (widget.userUse.isCommunity)
//               Container(
//                 margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: Text(
//                   'Group Post',
//                   style: GoogleFonts.inter(
//                     fontSize: 19,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             if (widget.userUse.isCommunity)
//               for (var i = 0; i < widget.communityPosted.length; i++)
//                 PostCommunityScreen(
//                   post: widget.communityPosted[i],
//                   user: widget.userPosted[i],
//                   community: widget.community!,
//                   realUser: widget.userUse,
//                 ),

//             // Expanded(
//             //   child: ListView.builder(
//             //     itemCount: widget.communityPosted.length,
//             //     itemBuilder: (ctx, index) => PostCommunityScreen(
//             //       post: widget.communityPosted[index],
//             //       user: widget.userPosted[index],
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
