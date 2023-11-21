import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
import 'package:ta_rides/widget/goal30/goal30_Home.dart';

class Goal30Category extends StatefulWidget {
  const Goal30Category({
    super.key,
    required this.user,
    required this.bmi,
    required this.email,
  });

  final Users user;
  final String bmi;
  final String email;

  @override
  State<Goal30Category> createState() => _Goal30CategoryState();
}

class _Goal30CategoryState extends State<Goal30Category> {
  void goal30Selected() async {
    final goal30Doc = await FirebaseFirestore.instance
        .collection('goal30')
        .where('userName', isEqualTo: widget.user.username)
        .get();

    await goal30Doc.docs.first.reference.update({
      'userData': true,
      'goalLenght': 30,
      'category': 'Goal30',
      'bmiCategory': widget.bmi,
      'timestamp': DateTime.now(),
    }).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TabsScreen(
            email: widget.email,
            tabsScreen: 3,
            communityTabs: 0,
          ),
        ),
      );
    });
  }

  void goal60Selected() async {
    final goal60Doc = await FirebaseFirestore.instance
        .collection('goal30')
        .where('userName', isEqualTo: widget.user.username)
        .get();

    await goal60Doc.docs.first.reference.update({
      'userData': true,
      'goalLenght': 60,
      'category': 'Goal60',
      'bmiCategory': widget.bmi,
      'timestamp': DateTime.now(),
    }).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TabsScreen(
            email: widget.email,
            tabsScreen: 3,
            communityTabs: 0,
          ),
        ),
      );
    });
  }

  void goal90Selected() async {
    final goal90Doc = await FirebaseFirestore.instance
        .collection('goal30')
        .where('userName', isEqualTo: widget.user.username)
        .get();

    await goal90Doc.docs.first.reference.update({
      'userData': true,
      'goalLenght': 90,
      'category': 'Goal90',
      'bmiCategory': widget.bmi,
      'timestamp': DateTime.now(),
    }).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TabsScreen(
            email: widget.email,
            tabsScreen: 3,
            communityTabs: 0,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0D11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0D11),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CHOOSE YOUR GOAL',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: const Color(0x3ffE89B05),
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
            ),
            Text(
              '             Greetings, user! Here are our objectives: Goal 30, Goal 60, and Goal 90. Each presents a unique level of difficulty, allowing you to test and elevate your skills. Take on the challenge now to become an exceptional biker.',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Goal 30',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: const Color(0x3ffE89B05),
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
            ),
            Text(
              '             Goal 30 is tailored for beginners, featuring a comfortable distance of easy kilometers to help you ease into the challenge.',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromHeight(60),
                  maximumSize: const Size.fromWidth(350),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide.none,
                  ),
                  backgroundColor: const Color(0x3ffFF0000),
                ),
                onPressed: goal30Selected,
                child: Text(
                  'GOAL 30',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Goal 60',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: const Color(0x3ffE89B05),
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
            ),
            Text(
              '               Goal 60 is designed for riders at an intermediate level, offering a moderate distance with normal kilometers that will provide a fulfilling and achievable challenge.',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromHeight(60),
                  maximumSize: const Size.fromWidth(350),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide.none,
                  ),
                  backgroundColor: const Color(0x3ffFF0000),
                ),
                onPressed: goal60Selected,
                child: Text(
                  'GOAL 60',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Goal 90',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: const Color(0x3ffE89B05),
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
            ),
            Text(
              '           Goal 90 is crafted for seasoned and expert bikers, pushing the limits with a substantial distance that involves tackling a significant number of kilometers. Are you ready for the ultimate biking challenge?',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromHeight(60),
                  maximumSize: const Size.fromWidth(350),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide.none,
                  ),
                  backgroundColor: const Color(0x3ffFF0000),
                ),
                onPressed: goal90Selected,
                child: Text(
                  'GOAL 90',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
