import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ta_rides/data/goal30_data.dart';
import 'package:ta_rides/models/goal30_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/all_controller/goal30_controller.dart';
import 'package:ta_rides/widget/goal30/goal30_Start.dart';
import 'package:ta_rides/widget/goal30/goal30_trackgoal.dart';

class Goal30Home extends StatefulWidget {
  const Goal30Home({
    super.key,
    required this.yourCategory,
    required this.user,
  });

  final String yourCategory;

  final Users user;

  @override
  _Goal30HomeState createState() => _Goal30HomeState();
}

class _Goal30HomeState extends State<Goal30Home> {
  final goal30PinController = TextEditingController();
  Goal30Controller goal30Controller = Goal30Controller();
  int day = 0;
  int dateDay = DateTime.now().day;

  int goalDay = 1;

  @override
  void initState() {
    super.initState();

    goal30Controller.getUserGoal30(widget.user.username);
  }

  // void loadGoalDay() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   DateTime startDate = DateTime.parse(
  //       prefs.getString('startDate') ?? DateTime.now().toIso8601String());
  //   setState(() {
  //     goalDay = DateTime.now().difference(startDate).inMinutes + 1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print(dateDay);
    print(goalDay);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0D11),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF0C0D11),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedBuilder(
              animation: goal30Controller,
              builder: (context, snapshot) {
                if (goal30Controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  margin: const EdgeInsets.all(15),
                  child: Text(
                    goal30Controller.goal30.category,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                        ),
                  ),
                );
              }),
          Goal30TrackGoal(
            user: widget.user,
          ),
        ],
      ),
    );
  }
}
