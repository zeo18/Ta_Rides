import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ta_rides/data/user_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';

class UserController extends ChangeNotifier {
  late final String email;

  late Users user;
  late List<Users> users = <Users>[];
  late Achievements achievement;
  bool isLoading = false;

  void setEmail(String email) {
    this.email = email;
  }

  void getUser(String email) async {
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
  }

  void getAchievement(String email) async {
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

    final achievementSnapshot = await FirebaseFirestore.instance
        .collection('achievement')
        .where('userName', isEqualTo: user.username)
        .get();

    if (achievementSnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('Achievements not found');
    }

    final achievementDoc = achievementSnapshot.docs.first;
    achievement = Achievements.fromDocument(achievementDoc);

    isLoading = false;
    notifyListeners();

    print('User: ${user.username}');
    print(' newbie: ${achievement.userName}');
    print('Achievement: ${achievement.legendary}');

    print('hello3');
  }

  void getAllUsers() async {
    isLoading = true;
    notifyListeners();

    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    if (querySnapshot.docs.isEmpty) {
      isLoading = false;
      notifyListeners();
      throw Exception('Users not found');
    }

    users = querySnapshot.docs.map((snapshot) {
      return Users.fromDocument(snapshot);
    }).toList();

    isLoading = false;
    notifyListeners();
  }
}


















   /////////////////////////
    // final communityQuerySnapshot = await FirebaseFirestore.instance
    //     .collection('community')
    //     .where('id', isEqualTo: user.communityId)
    //     .get();

    // if (communityQuerySnapshot.docs.isEmpty) {
    //   isLoading = false;
    //   notifyListeners();
    //   throw Exception('Community not found');
    // }

    // final communityDocumentSnapshot = communityQuerySnapshot.docs.first;
    // community = Community.fromDocument(communityDocumentSnapshot);

    // final postQuerySnapshot = await FirebaseFirestore.instance
    //     .collection('post')
    //     .where('communityId', isEqualTo: user.communityId)
    //     .get();

    // if (postQuerySnapshot.docs.isEmpty) {
    //   isLoading = false;
    //   notifyListeners();
    //   throw Exception('Post not found');
    // }

    // final postDocumentSnapshot = postQuerySnapshot.docs.first;
    // post = Post.fromDocument(postDocumentSnapshot);