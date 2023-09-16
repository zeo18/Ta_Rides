import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/data/user_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';

import 'package:ta_rides/screen/auth/createAccount.dart';
import 'package:ta_rides/screen/auth/forgotPassword.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var checking = true;

  void _isChecking() {
    setState(() {
      checking = false;
    });
  }

  void _isChecking2() {
    setState(() {
      checking = true;
    });
  }

  void homePage() {
    final List<Community> communities = CommunityInformation;
    final List<Users> users = UserInformation;
    int selectButtom = 2;
    var select = 0;
    Community? communityUser;
    List<Users>? userPost = [];
    Achievements? userAchievements;

    // late Community communityUser;

    print('hello');
    for (var community in communities) {
      print('hello2');
      if (users[0].communityId == community.id) {
        communityUser = community;
        print(['correct2', communityUser.title]);
        break;
      }
    }
    List<Post> communityPost = [];
    if (communityUser != null) {
      if (users[0].isCommunity) {
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

    for (var achieve in achievementsInformation) {
      if (achieve.userName == users[0].username) {
        //////////////////////////////
        userAchievements = achieve;
      }
    }

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => TabsScreen(
            user: users[5], ///////////////////////////////
            community: communityUser,
            communityPosted: communityPost,
            selectTab: select,
            userPosted: userPost,
            achievements: userAchievements,
            selectButtomTab: selectButtom,
          ),
        ));
  }

  void addUser(Users user) {
    setState(() {
      UserInformation.add(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(['UserID', UserInformation[6].id]);
    // print(['UserName', UserInformation[6].username]);

    return Scaffold(
      backgroundColor: const Color(0xfff0C0D11),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ta',
                      style: GoogleFonts.montserrat(
                        color: const Color(0x3fffffff0),
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      'RIDES',
                      style: GoogleFonts.montserrat(
                        color: const Color(0x3fffFF0000),
                        fontSize: 53.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                TextField(
                  style: GoogleFonts.inter(
                    color: const Color(0x3fff454545),
                  ),
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x3fffFFFFF0),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x3fffFFFFF0),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    labelStyle: GoogleFonts.montserrat(
                      color: const Color(0x3fff454545),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    prefixIconColor: const Color(0x3fff454545),
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                if (checking == true)
                  TextField(
                    obscureText: true,
                    style: GoogleFonts.inter(
                      color: const Color(0x3fff454545),
                    ),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x3fffFFFFF0),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x3fffFFFFF0),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      labelStyle: GoogleFonts.montserrat(
                        color: const Color(0x3fff454545),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      prefixIconColor: const Color(0x3fff808080),
                      suffixIcon: IconButton(
                        onPressed: _isChecking,
                        icon: const Icon(Icons.remove_red_eye),
                      ),
                      suffixIconColor: const Color(0x3fff808080),
                      labelText: 'Password',
                    ),
                  )
                else
                  TextField(
                    obscureText: false,
                    style: GoogleFonts.inter(
                      color: const Color(0x3fff454545),
                    ),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x3fffFFFFF0),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x3fffFFFFF0),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      labelStyle: GoogleFonts.montserrat(
                        color: const Color(0x3fff454545),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      prefixIconColor: const Color(0x3fff808080),
                      suffixIcon: IconButton(
                        onPressed: _isChecking2,
                        icon: const Icon(Icons.remove_red_eye),
                      ),
                      suffixIconColor: const Color(0x3fff808080),
                      labelText: 'Password',
                    ),
                  ),
                const SizedBox(
                  height: 21,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreateAccount(addUser: addUser),
                            ),
                          );
                        },
                        child: Text(
                          'Create an Account',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 21,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(60),
                    maximumSize: const Size.fromWidth(350),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide.none,
                    ),
                    backgroundColor: const Color(0x3ffFF0000),
                  ),
                  onPressed: homePage,
                  child: Text(
                    'LOGIN',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset('assets/images/log_in/circle.png'),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset('assets/images/log_in/bike.png'),
          ),
        ],
      ),
    );
  }
}
