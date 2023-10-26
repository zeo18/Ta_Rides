import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/post_community/comment.dart';

class CommunityController extends ChangeNotifier {
  late final String communityId;
  late final String email;

  late List<Community> communities = <Community>[];
  late List<Comment> comment = <Comment>[];
  late Users user;

  late Post post;
  late Community community;
  bool isLoading = false;
  // late List<Users> users;
  late final userPost = <Users>[];
  // late List<Users> userPost = [];
  // late List<Post> posts;

  void setCommunityId(String communityId) {
    this.communityId = communityId;
  }

  void setEmail(String email) {
    this.email = email;
    print('unsa mani oy');
  }

  void getCommunityAndUser(String email) async {
    print('naka sud bas community?');
    isLoading = true;
    notifyListeners();

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('User not found');
    }

    final documentSnapshot = querySnapshot.docs.first;
    user = Users.fromDocument(documentSnapshot);

    isLoading = false;
    notifyListeners();

    final communityQuerySnapshot = await FirebaseFirestore.instance
        .collection('community')
        .where('id', isEqualTo: user.communityId)
        .get();

    if (communityQuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('Community not found');
    }

    final communityDocumentSnapshot = communityQuerySnapshot.docs.first;
    community = Community.fromDocument(communityDocumentSnapshot);

    isLoading = false;
    notifyListeners();

    print(["user", user.communityId]);
    print(["community", community.id]);

    // if (community.id == user.communityId) {
    //   communityInformation.add(community);
    // }

    isLoading = true;
    notifyListeners();

    final postQuerySnapshot = await FirebaseFirestore.instance
        .collection('post')
        .where('communityId', isEqualTo: community.id)
        .get();

    if (postQuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('Post not found');
    }

    final postDocumentSnapshot = postQuerySnapshot.docs.first;
    post = Post.fromDocument(postDocumentSnapshot);

    isLoading = false;
    notifyListeners();

    print(["post", post.communityId]);
    print(["community", community.id]);

    if (post.communityId == community.id) {
      PostCommunity.add(post);
    }

    // try {
    //   final communityQuerySnapshot = await FirebaseFirestore.instance
    //       .collection('community')
    //       .doc(user.communityId)
    //       .get();

    //   if (!communityQuerySnapshot.exists) {
    //     throw Exception('Community not found');
    //   }

    //   community = Community.fromDocument(communityQuerySnapshot);
    // } catch (e) {
    //   isLoading = false;
    //   notifyListeners();
    //   throw Exception(e);
    // }

// get all community

    // final communitiesQuerySnapshot =
    //     await FirebaseFirestore.instance.collection('community').get();

    // if (communitiesQuerySnapshot.docs.isEmpty) {
    //   isLoading = false;
    //   notifyListeners();
    //   throw Exception('No communities found');
    // }

    // communities = communitiesQuerySnapshot.docs.map((documentSnapshot) {
    //   return Community.fromDocument(documentSnapshot);
    // }).toList();

    // isLoading = false;
    // notifyListeners();
    // print(["communities lenght", communities.length]);
    // for (var i = 0; i < communities.length; i++) {
    //   print(["communities", communities[i].id]);
    // }
  }

  void getAllCommunity() async {
    final communitiesQuerySnapshot =
        await FirebaseFirestore.instance.collection('community').get();

    if (communitiesQuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('No communities found');
    }

    communities = communitiesQuerySnapshot.docs.map((documentSnapshot) {
      return Community.fromDocument(documentSnapshot);
    }).toList();

    isLoading = false;
    notifyListeners();
    print(["communities lenght", communities.length]);
    for (var i = 0; i < communities.length; i++) {
      print(["communities", communities[i].id]);
    }
  }

  void getComment(String postId) async {
    final commentQuerySnapshot = await FirebaseFirestore.instance
        .collection('comment')
        .where('postId', isEqualTo: postId)
        .get();

    if (commentQuerySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('No comment found');
    }

    comment = commentQuerySnapshot.docs.map((commentDocumentSnapshot) {
      return Comment.fromDocument(commentDocumentSnapshot);
    }).toList();

    comment.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    isLoading = true;
    notifyListeners();
  }

  // Future<List<Post>> getAllPost() async {

  //   return posts;
  // }
// Future<List<Community>> getAllCommunity() async {

//   return communities;
// }

}
    // }



        // for (int i = 2; i < posts.length; i++) {
    // print('naka sud bas users?');
    // final usersQuerySnapshot = await FirebaseFirestore.instance
    //     .collection('users')
    //     .where('username',
    //         whereIn: posts.map((posts) => posts.usersName).toList())
    //     .get();

    // for (int i = 0; i < posts.length; i++) {
    //   // if (posts[i].usersName == users[i].username) {
    //   //   print(["post name", posts[i].usersName]);
    //   //   print(["users name", users[i].username]);
    //   // }
    //   print('naka sud bas users?');
    // }

    // print(["post name", post.usersName]);











 // final List<Users> users =
    //     userQuerySnapshot.docs.map((userDocumentSnapshot) {
    //   return Users.fromDocument(userDocumentSnapshot);
    // }).toList();

    // final Users currentUser = users.firstWhere(
    //   (user) => user.id == 'currentUserId',
    // );

    // if (currentUser == null) {
    //   isLoading = false;
    //   notifyListeners();
    //   throw Exception('User not found');
    // }

    // if (currentUser.communityId == community.id) {
    //   isLoading = false;
    //   notifyListeners();
    //   throw Exception('User is not a member of this community');
    // }













    //  final postsQuerySnapshot = await FirebaseFirestore.instance
    //     .collection('post')
    //     .where('communityId', isEqualTo: community.id)
    //     .orderBy('timestamp', descending: true)
    //     .get();

    // if (postsQuerySnapshot.docs.isEmpty) {
    //   isLoading = false;
    //   notifyListeners();
    //   throw Exception('No posts found');
    // }

    // posts = postsQuerySnapshot.docs.map((postDocumentSnapshot) {
    //   return Post.fromDocument(postDocumentSnapshot);
    // }).toList();
    // isLoading = false;
    // notifyListeners();

    // final usersQuerySnapshot = await FirebaseFirestore.instance
    //     .collection('users')
    //     .where('username',
    //         whereIn: posts.map((post) => post.usersName).toList())
    //     .get();

    // if (usersQuerySnapshot.docs.isEmpty) {
    //   isLoading = false;
    //   notifyListeners();
    //   throw Exception('No users1 found');
    // }

    // final users = usersQuerySnapshot.docs.map((usersDocumentSnapshot) {
    //   return Users.fromDocument(usersDocumentSnapshot);
    // }).toList();

    // isLoading = true;
    // notifyListeners();
    // for (final post in posts) {
    //   print(["post", post.usersName]);
    // }

    // for (final post in posts) {
    //   for (final user in users) {
    //     if (post.usersName == user.username) {
    //       userPost.add(user);
    //       notifyListeners();
    //       print('Match found!');
    //     }
    //   }
    // }

    // print(["posts lenght", posts.length]);
    // print(["userPost lenght", userPost.length]);
    // print(["users lenght", users.length]);

    // // for (int i = 0; i < users.length; i++) {
    // //   print(["user name", users[i].username]);
    // // }

    // for (int i = 0; i < posts.length; i++) {
    //   print(["post name", posts[i].usersName]);
    // }
    // for (int i = 0; i < userPost.length; i++) {
    //   print(["userPost name", userPost[i].username]);
    // }