import 'package:flutter/material.dart';
import 'package:ta_rides/data/community_date.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/bottom_tab/pedal_screen.dart';
import 'package:ta_rides/screen/bottom_tab/profile_dart.dart';
import 'package:ta_rides/screen/bottom_tab/rides_screen.dart';
import 'package:ta_rides/data/user_data.dart';
import 'package:ta_rides/models/community_info.dart';

import 'community_screen.dart';
import 'goal30_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({
    super.key,
  });

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    print(_selectedPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    final List<Users> users = UserInformation;
    final List<Post> post = PostCommunity;
    Widget activePage = CommunityScreen(
      user: users[0],
    );

    //var activePageTitle = 'Community';

    if (_selectedPageIndex == 1) {
      activePage = const RidesScreen();
      //    activePageTitle = 'Rides';
    }
    if (_selectedPageIndex == 2) {
      activePage = const PedalScreen();
      //   activePageTitle = 'Pedal';
    }
    if (_selectedPageIndex == 3) {
      activePage = const Goal30Screen();
      //   activePageTitle = 'Goal30';
    }
    if (_selectedPageIndex == 4) {
      activePage = ProfileScreen(
        user: users[0],
      );
      //   activePageTitle = 'You';
    }

    return Scaffold(
      // appBar: AppBar(
      //  title: Text(
      //    activePageTitle,
      //    style: Theme.of(context).textTheme.headline6!.copyWith(
      //          color: Colors.white,
      //         fontWeight: FontWeight.bold,
      //         ),
      //   ),
      //backgroundColor: const Color(0x3ff0C0D11),
      //),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0x3ff0C0D11),
        onTap: selectedPage,
        currentIndex: _selectedPageIndex,
        fixedColor: const Color(0x3ffFF0000),
        items: [
          if (_selectedPageIndex == 0)
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/community.png',
                height: 30,
                width: 30,
                color: Color(0x3FFFF0000),
              ),
              label: 'Community',
              backgroundColor: const Color(0x3ff0C0D11),
            )
          else
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/community.png',
                height: 30,
                width: 30,
              ),
              label: 'Community',
              backgroundColor: const Color(0x3ff0C0D11),
            ),
          if (_selectedPageIndex == 1)
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/rides.png',
                height: 30,
                width: 30,
                color: Color(0x3FFFF0000),
              ),
              label: 'Rides',
              backgroundColor: const Color(0x3ff0C0D11),
            )
          else
            BottomNavigationBarItem(
              icon:
                  Image.asset('assets/images/rides.png', height: 30, width: 30),
              label: 'Rides',
              backgroundColor: const Color(0x3ff0C0D11),
            ),
          if (_selectedPageIndex == 2)
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/pedal.png',
                height: 30,
                width: 30,
                color: Color(0x3FFFF0000),
              ),
              label: 'Pedal',
              backgroundColor: const Color(0x3ff0C0D11),
            )
          else
            BottomNavigationBarItem(
              icon:
                  Image.asset('assets/images/pedal.png', height: 30, width: 30),
              label: 'Pedal',
              backgroundColor: const Color(0x3ff0C0D11),
            ),
          if (_selectedPageIndex == 3)
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/goal30.png',
                height: 30,
                width: 30,
                color: Color(0x3FFFF0000),
              ),
              label: 'Goal 30',
              backgroundColor: const Color(0x3ff0C0D11),
            )
          else
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/goal30.png',
                  height: 30, width: 30),
              label: 'Goal 30',
              backgroundColor: const Color(0x3ff0C0D11),
            ),
          if (_selectedPageIndex == 4)
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/profile.png',
                height: 30,
                width: 30,
                color: Color(0x3FFFF0000),
              ),
              label: 'You',
              backgroundColor: const Color(0x3ff0C0D11),
            )
          else
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/profile.png',
                height: 30,
                width: 30,
              ),
              label: 'You',
              backgroundColor: const Color(0x3ff0C0D11),
            ),
        ],
      ),
    );
  }
}
