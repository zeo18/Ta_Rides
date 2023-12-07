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
  Community? community;
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
    print(["community", community!.id]);

    // if (community.id == user.communityId) {
    //   communityInformation.add(community);
    // }

    // isLoading = true;
    // notifyListeners();

    final postQuerySnapshot = await FirebaseFirestore.instance
        .collection('post')
        .where('communityId', isEqualTo: community!.id)
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
    print(["community", community!.id]);

    if (post.communityId == community!.id) {
      PostCommunity.add(post);
    }
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
}
