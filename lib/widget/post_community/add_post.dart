// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ta_rides/data/community_data.dart';
// import 'package:ta_rides/models/community_info.dart';
// import 'package:ta_rides/models/user_info.dart';

// class AddPostCommunity extends StatefulWidget {
//   const AddPostCommunity({
//     super.key,
//     required this.user,
//     required this.onAddPost,
//     required this.community,
//   });

//   final Users user;
//   final Function(Post post) onAddPost;
//   final Community community;

//   @override
//   State<AddPostCommunity> createState() => _AddPostCommunityState();
// }

// class _AddPostCommunityState extends State<AddPostCommunity> {
//   Uint8List? _postImage;
//   final _captionPostController = TextEditingController();
//   bool onClickPostImage = false;

//   void _addPost() {
//     setState(() {
//       if (_postImage != null) {
//         widget.onAddPost(Post(
//           postId: PostCommunity.length + 1,
//           communityId: widget.community.id,
//           userId: widget.user.id,
//           isImage: onClickPostImage,
//           imagePost: '',
//           usersName: widget.user.username,
//           caption: _captionPostController.text,
//           commment: [],
//           commentNumber: 0,
//           heart: 0,
//           ifImage: _postImage!,
//         ));
//       } else {
//         widget.onAddPost(Post(
//           postId: PostCommunity.length + 1,
//           communityId: widget.community.id,
//           userId: widget.user.id,
//           isImage: onClickPostImage,
//           imagePost: '',
//           usersName: widget.user.username,
//           caption: _captionPostController.text,
//           commment: [],
//           commentNumber: 0,
//           heart: 0,
//           ifImage: Uint8List.fromList([]),
//         ));
//       }
//     });

//     Navigator.pop(context);
//   }

//   @override
//   void dispose() {
//     _captionPostController.dispose();
//     super.dispose();
//   }

//   pickImage(ImageSource source) async {
//     final ImagePicker _imagePicker = ImagePicker();
//     XFile? _file = await _imagePicker.pickImage(source: source);
//     if (_file != null) {
//       return await _file.readAsBytes();
//     }
//     print('No image selected.');
//   }

//   void selectedImage() async {
//     Uint8List? img = await pickImage(ImageSource.gallery);
//     setState(() {
//       _postImage = img;
//       onClickPostImage = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0x3ff0C0D11),
//       appBar: AppBar(
//         backgroundColor: const Color(0x3ff0C0D11),
//       ),
//       body: Container(
//         margin: EdgeInsets.all(10),
//         child: Stack(
//           children: [
//             if (_postImage != null)
//               Container(
//                 height: 504,
//                 width: 395,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 2.0,
//                     color: const Color(0x3ff454545),
//                   ),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               )
//             else
//               Container(
//                 height: 293,
//                 width: 395,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 2.0,
//                     color: const Color(0x3ff454545),
//                   ),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//             if (_postImage != null)
//               Positioned(
//                 top: 60,
//                 left: 2.3,
//                 child: Container(
//                   height: 260,
//                   width: 387,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: MemoryImage(_postImage!),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             if (_postImage != null)
//               Container(
//                 margin: const EdgeInsets.fromLTRB(0, 320, 0, 0),
//                 child: TextField(
//                   style: GoogleFonts.inter(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   controller: _captionPostController,
//                   textInputAction: TextInputAction.done,
//                   cursorColor: Colors.white,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Color.fromARGB(113, 69, 69, 69),
//                     hintText: "What’s on your mind?",
//                     hintStyle: GoogleFonts.inter(
//                       color: const Color(0x3ff454545),
//                       fontSize: 15,
//                     ),
//                     focusedBorder: const OutlineInputBorder(
//                         borderSide: const BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(15),
//                             bottomRight: Radius.circular(15))),
//                     enabledBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Color(0x3ff454545)),
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(15),
//                           bottomRight: Radius.circular(15)),
//                     ),
//                   ),
//                   maxLines: 6,
//                 ),
//               )
//             else
//               Container(
//                 margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
//                 child: TextField(
//                   style: GoogleFonts.inter(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   controller: _captionPostController,
//                   textInputAction: TextInputAction.done,
//                   cursorColor: Colors.white,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Color.fromARGB(113, 69, 69, 69),
//                     hintText: "What’s on your mind?",
//                     hintStyle: GoogleFonts.inter(
//                       color: const Color(0x3ff454545),
//                       fontSize: 15,
//                     ),
//                     focusedBorder: const OutlineInputBorder(
//                         borderSide: const BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(15),
//                             bottomRight: Radius.circular(15))),
//                     enabledBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Color(0x3ff454545)),
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(15),
//                           bottomRight: Radius.circular(15)),
//                     ),
//                   ),
//                   maxLines: 8,
//                 ),
//               ),
//             Positioned(
//               bottom: 20,
//               right: 115,
//               child: IconButton(
//                 onPressed: () {
//                   selectedImage();
//                   setState(() {
//                     onClickPostImage = true;
//                   });
//                 },
//                 icon: Image.asset(
//                   'assets/images/community_images/post_community/addImage.png',
//                   height: 30,
//                   width: 30,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 26,
//               right: 20,
//               child: InkWell(
//                 onTap: _addPost, //_addPost,
//                 child: Container(
//                   padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(
//                       color: Colors.white,
//                       width: 1.4,
//                     ),
//                   ),
//                   child: Text(
//                     'Post',
//                     style: Theme.of(context).textTheme.headline6!.copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 10,
//               left: 10,
//               child: Column(
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipOval(
//                         child: Image(
//                           image: AssetImage(widget.user.userImage),
//                           height: 40,
//                           width: 40,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Column(
//                         children: [
//                           Text(
//                             "${widget.user.lastName}, ${widget.user.firstName} ",
//                             style:
//                                 Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                           ),
//                           Text(
//                             'member of this group',
//                             style: GoogleFonts.inter(
//                               fontSize: 12,
//                               color: const Color(0x3ff797979),
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
