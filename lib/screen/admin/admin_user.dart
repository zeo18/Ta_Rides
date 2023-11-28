import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ta_rides/screen/admin/communities.dart';
import 'package:ta_rides/screen/admin/events.dart';
import 'package:ta_rides/screen/admin/tab_bar_admin.dart';
import 'package:ta_rides/screen/admin/users.dart';
import 'package:ta_rides/screen/auth/logInPage.dart';

class SuperAdminScreen extends StatefulWidget {
  const SuperAdminScreen({super.key});

  @override
  State<SuperAdminScreen> createState() => _SuperAdminScreenState();
}

class _SuperAdminScreenState extends State<SuperAdminScreen> {
  List<PageTabItemModel> lstPages = <PageTabItemModel>[];
  final TabPageController _controller = TabPageController();
  @override
  void initState() {
    super.initState();
    lstPages.add(
      PageTabItemModel(
        title: "Users",
        page: const User(),
      ),
    );
    lstPages.add(
      PageTabItemModel(
        title: "Communities",
        page: const Communities(),
      ),
    );
    lstPages.add(
      PageTabItemModel(
        title: "Events",
        page: const Events(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 13, 17),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 12, 13, 17),
        title: Row(
          children: [
            Text(
              "Super_Admin",
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/admin_images/notif-icon.png', // Replace with the correct path to your button image
              width: 23,
              height: 23,
            ),
            onPressed: () {
              // Add the functionality for the button here
            },
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/admin_images/logout.png',
              width: 23,
              height: 23,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: TabBarPage(
              controller: _controller,
              pages: lstPages,
              isSwipable: true,
              tabBackgroundColor: const Color.fromARGB(255, 12, 13, 17),
              tabitemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _controller.onTabTap(index);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / lstPages.length,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Center(
                          child: Text(
                            lstPages[index].title ?? "",
                            style: TextStyle(
                                fontWeight: _controller.currentIndex == index
                                    ? FontWeight.w900
                                    : FontWeight.w400,
                                color: _controller.currentIndex == index
                                    ? const Color.fromARGB(255, 255, 0, 0)
                                    : const Color.fromARGB(255, 102, 102, 102),
                                fontSize: 16),
                          ),
                        ),
                        Container(
                            height: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: _controller.currentIndex == index
                                    ? const Color.fromARGB(255, 255, 0, 0)
                                    : Colors.transparent)),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
