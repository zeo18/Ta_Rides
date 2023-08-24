import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/data/user_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.montserratTextTheme(),
);

void main() {
  runApp(const App());
}

//232323
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Community> communities = CommunityInformation;
    final List<Users> users = UserInformation;

    var select = 0;
    Community? communityUser;
    List<Users>? userPost = [];
    // late Community communityUser;

    print('hello');
    for (var community in communities) {
      print('hello2');
      if (users[1].communityId == community.id) {
        communityUser = community;
        print(['correct2', communityUser.title]);
        break;
      }
    }
    List<Post> communityPost = [];
    if (communityUser != null) {
      if (users[5].isCommunity) {
        for (var community in CommunityInformation) {
          for (var post in PostCommunity) {
            if (post.communityId.toString() == community.id.toString()) {
              communityPost.add(post);
            }
          }
        }
      } else {
        for (var post in PostCommunity) {
          if (post.communityId.toString() == communityUser.id.toString()) {
            communityPost.add(post);
          }
        }
      }

      for (var post in communityPost) {
        for (var user in UserInformation) {
          if (post.usersName == user.username) {
            print([post.usersName.toString(), user.username.toString()]);
            userPost.add(user);
          }
        }
      }
    }

    // print(['List<Users> joined', userPost.length]);
    // print(['List<Post> joined', communityPost.length]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: TabsScreen(
        user: users[1],
        community: communityUser,
        communityPosted: communityPost,
        selectTab: select,
        userPosted: userPost,
      ),
    );
  }
}
//testing testing
//testing testing testing 
// noooo\
//okay