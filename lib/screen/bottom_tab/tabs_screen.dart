import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/data/user_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/bottom_tab/pedal_screen.dart';
import 'package:ta_rides/screen/bottom_tab/profile_dart.dart';
import 'package:ta_rides/screen/bottom_tab/real_pedal_screen.dart';
import 'package:ta_rides/screen/bottom_tab/rides_screen.dart';
import 'package:ta_rides/widget/all_controller/goal30_controller.dart';
import 'package:ta_rides/widget/all_controller/rides_controller.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';
import 'package:ta_rides/widget/goal30/goal30_BMI_screen.dart';

import 'community_screen.dart';
import 'goal30_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({
    super.key,
    required this.email,
    required this.tabsScreen,
    required this.communityTabs,
    // required this.user,
    // required this.community,
    // required this.communityPosted,
    // required this.selectTab,
    // required this.userPosted,
    // required this.achievements,
    // required this.selectButtomTab,
  });
  final String email;
  final int tabsScreen;
  final int communityTabs;
  // final Users user;
  // final int selectButtomTab;
  // final int selectTab;
  // final List<Users> userPosted;
  // final List<Post> communityPosted;
  // final Community? community;
  // final Achievements? achievements;

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  LocationData? _locationData;
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  UserController userController = UserController();
  RidesController ridesController = RidesController();
  Goal30Controller goal30Controller = Goal30Controller();

  @override
  void initState() {
    super.initState();
    initializeLocation();
    _selectedPageIndex = widget.tabsScreen;
    userController.getUser(widget.email);

    userController.getAllUsers();
  }

  void initializeLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    setState(() {
      _locationData = _locationData;
    });
  }

  void selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    print(_selectedPageIndex);
  }

  void _editProfile(Users newUser) {
    // setState(() {

    //   UserInformation.add(user);
    // });
    setState(() {
      // Find the index of the user to be edited in UserInformation list
      // _selectedPageIndex = widget.selectButtomTab;

      // UserInformation.remove(newUser);
      // UserInformation.add(newUser);
      int index = UserInformation.indexWhere((user) => user.id == newUser.id);

      UserInformation[index] = newUser;
      print(['fuck nasud ba', UserInformation[index].firstName]);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CommunityScreen(
      email: widget.email,
      communityTab: widget.communityTabs,
    );

    if (_selectedPageIndex == 1) {
      activePage = AnimatedBuilder(
          animation: userController,
          builder: (context, snapshot) {
            if (userController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return RidesScreen(
              email: widget.email,
              user: userController.user,
            );
          });
      //    activePageTitle = 'Rides';
    }

    if (_selectedPageIndex == 2) {
      activePage = _locationData != null
          ? AnimatedBuilder(
              animation: userController,
              builder: (context, snapshot) {
                if (userController.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return RealPedalScreen(
                  user: userController.user,
                  locationData: _locationData!,
                );
              })
          : const Center(
              child:
                  CircularProgressIndicator()); // Replace this with your placeholder widget
    }

    if (_selectedPageIndex == 3) {
      activePage = AnimatedBuilder(
          animation: userController,
          builder: (context, snapshot) {
            if (userController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Goal30Screen(
              email: widget.email,
              user: userController.user,
            );
          });

      //   activePageTitle = 'Goal30';
    }
    if (_selectedPageIndex == 4) {
      activePage = ProfileScreen(email: widget.email);
      // activePage = ProfileScreen(
      //   user: widget.user,
      //   community: widget.community,
      //   communityPosted: widget.communityPosted,
      //   userPosted: widget.userPosted,
      //   achievements: widget.achievements,
      //   onEditProfile: _editProfile,
      // );
      // //   activePageTitle = 'You';
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0x3ff0c0d11),
        onTap: selectedPage,
        currentIndex: _selectedPageIndex,
        fixedColor: const Color(0x3ffff0000),
        items: [
          if (_selectedPageIndex == 0)
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/community.png',
                height: 30,
                width: 30,
                color: const Color(0x3ffff0000),
              ),
              label: 'Community',
              backgroundColor: const Color(0x3ff0c0d11),
            )
          else
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/community.png',
                height: 30,
                width: 30,
              ),
              label: 'Community',
              backgroundColor: const Color(0x3ff0c0d11),
            ),
          if (_selectedPageIndex == 1)
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/rides.png',
                height: 30,
                width: 30,
                color: const Color(0x3ffff0000),
              ),
              label: 'Rides',
              backgroundColor: const Color(0x3ff0c0d11),
            )
          else
            BottomNavigationBarItem(
              icon:
                  Image.asset('assets/images/rides.png', height: 30, width: 30),
              label: 'Rides',
              backgroundColor: const Color(0x3ff0c0d11),
            ),
          if (_selectedPageIndex == 2)
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/pedal.png',
                height: 30,
                width: 30,
                color: const Color(0x3ffff0000),
              ),
              label: 'Pedal',
              backgroundColor: const Color(0x3ff0c0d11),
            )
          else
            BottomNavigationBarItem(
              icon:
                  Image.asset('assets/images/pedal.png', height: 30, width: 30),
              label: 'Pedal',
              backgroundColor: const Color(0x3ff0c0d11),
            ),
          if (_selectedPageIndex == 3)
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/goal30.png',
                height: 30,
                width: 30,
                color: const Color(0x3ffff0000),
              ),
              label: 'Goal 30',
              backgroundColor: const Color(0x3ff0c0d11),
            )
          else
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/goal30.png',
                  height: 30, width: 30),
              label: 'Goal 30',
              backgroundColor: const Color(0x3ff0c0d11),
            ),
          if (_selectedPageIndex == 4)
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/profile.png',
                height: 30,
                width: 30,
                color: const Color(0x3ffff0000),
              ),
              label: 'You',
              backgroundColor: const Color(0x3ff0c0d11),
            )
          else
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/profile.png',
                height: 30,
                width: 30,
              ),
              label: 'You',
              backgroundColor: const Color(0x3ff0c0d11),
            ),
        ],
      ),
    );
  }
}
