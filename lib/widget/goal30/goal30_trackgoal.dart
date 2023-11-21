import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ta_rides/data/goal30_data.dart';
import 'package:ta_rides/models/goal30_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/all_controller/goal30_controller.dart';
import 'package:ta_rides/widget/goal30/goal30_Start.dart';

class Goal30TrackGoal extends StatefulWidget {
  const Goal30TrackGoal({super.key, required this.user});

  final Users user;

  @override
  State<Goal30TrackGoal> createState() => _Goal30TrackGoalState();
}

class _Goal30TrackGoalState extends State<Goal30TrackGoal> {
  final goal30PinController = TextEditingController();
  Goal30Controller goal30Controller = Goal30Controller();
  ScrollController scrollController = ScrollController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final keys = List<GlobalKey>.generate(90, (index) => GlobalKey());
  int goalDay = 1;
  // late int dateDay;
  int dateDay = DateTime.now().day;
  int day = 0;
  late DateTime startDate;

  @override
  void initState() {
    super.initState();
    initializeGoalDay();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadGoalDay();
  }

  void initializeGoalDay() async {
    await goal30Controller.getUserGoal30(widget.user.username);
    loadGoalDay();
  }

  void loadGoalDay() {
    SharedPreferences.getInstance().then((prefs) {
      startDate = DateTime.parse(
          prefs.getString('startDate') ?? DateTime.now().toIso8601String());

      DateTime goalDate = goal30Controller.goal30.timestamp.toDate();

      // Set the time of both dates to midnight
      startDate = DateTime(startDate.year, startDate.month, startDate.day);
      goalDate = DateTime(goalDate.year, goalDate.month, goalDate.day);

      setState(() {
        goalDay = goalDate.difference(startDate).inDays.abs() + 1;
        print(['hey', goalDate]);
        print(goalDate.difference(startDate).inDays);
        print(['daysssss', goalDay]);

        if (goalDay != 1 && goalDay != 2 && goalDay != 3) {
          Future.delayed(Duration(milliseconds: 500), () {
            itemScrollController.scrollTo(
              index: goalDay,
              alignment: 0.5,
              duration: Duration(seconds: 3), // to center the item
            );
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(goalDay);
    return AnimatedBuilder(
        animation: goal30Controller,
        builder: (context, snapshot) {
          if (goal30Controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                height: 100,
                child: ScrollablePositionedList.builder(
                  itemScrollController: itemScrollController,
                  itemCount: goal30Controller.goal30.goalLenght,
                  itemBuilder: (context, index) {
                    final itemKey = keys[index];
                    if (goal30Controller.goal30.goalLenght == 30) {
                      final itemKey = keys[index];
                      final item = goal30[index];
                      return Row(
                        children: [
                          buildCard(item, dateDay, itemKey),
                          const SizedBox(width: 10)
                        ],
                      );
                    }
                    if (goal30Controller.goal30.goalLenght == 60) {
                      final itemKey = keys[index];
                      final item = goal60[index];
                      return Row(
                        children: [
                          buildCard(item, dateDay, itemKey),
                          const SizedBox(width: 10)
                        ],
                      );
                    }
                    if (goal30Controller.goal30.goalLenght == 90) {
                      final itemKey = keys[index];
                      final item = goal90[index];
                      return Row(
                        children: [
                          buildCard(item, dateDay, itemKey),
                          const SizedBox(width: 10)
                        ],
                      );
                    }
                    return Row(
                      children: [
                        buildCard(goal30[index], dateDay, keys[index]),
                        const SizedBox(
                            width: 10), // add a SizedBox after each item
                      ],
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              for (var i = 0; i < goal30.length; i++)
                if (goal30[i].yourCategory == goal30Controller.goal30.category)
                  if (goal30[i].day == day.toString())
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Your Category:  ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                  ),
                                  TextSpan(
                                    text: goal30[i].yourCategory,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: const Color(0x3FFFE8AA0A),
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Today's Goal:  ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                  ),
                                  TextSpan(
                                    text: goal30[i].kmGoal.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: const Color(0x3FFFE8AA0A),
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              for (var i = 0; i < goal60.length; i++)
                if (goal60[i].yourCategory == goal30Controller.goal30.category)
                  if (goal60[i].day == day.toString())
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Your Category:  ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                  ),
                                  TextSpan(
                                    text: goal60[i].yourCategory,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: const Color(0x3FFFE8AA0A),
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Today's Goal:  ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                  ),
                                  TextSpan(
                                    text: goal60[i].kmGoal.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: const Color(0x3FFFE8AA0A),
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              for (var i = 0; i < goal90.length; i++)
                if (goal90[i].yourCategory == goal30Controller.goal30.category)
                  if (goal90[i].day == day.toString())
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Your Category:  ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                  ),
                                  TextSpan(
                                    text: goal90[i].yourCategory,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: const Color(0x3FFFE8AA0A),
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Today's Goal:  ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                  ),
                                  TextSpan(
                                    text: goal90[i].kmGoal.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: const Color(0x3FFFE8AA0A),
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              Container(
                margin: const EdgeInsets.all(15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: const Color(0x3FFF181A20),
                    height: 150,
                    child: Form(
                      // key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 13, 0, 0),
                            child: Text(
                              'Pin your point location!',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: goal30PinController,
                              style: GoogleFonts.inter(
                                color: Colors.white,
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
                                prefixIcon: const Icon(Icons.pin_drop),
                                prefixIconColor: const Color(0x3fffE8AA0A),
                                labelText: '1st Pin Point',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(60),
                    maximumSize: const Size.fromWidth(380),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide.none,
                    ),
                    backgroundColor: const Color(0x3ffFF0000),
                  ),
                  onPressed: () {
                    print(goalDay);
                    loadGoalDay();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Goal30Start(
                          goal30PinController: goal30PinController.text,
                          locationData: null,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Proceed',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget buildCard(BMI item, int dateDay, GlobalKey key) => ClipRRect(
        key: key,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            setState(() {
              day = int.parse(item.day);
            });
          },
          child: Column(
            children: [
              Container(
                width: 80,
                height: 100,
                color: day == int.parse(item.day)
                    ? const Color.fromARGB(255, 55, 60, 71)
                    : const Color(0xFF181A20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Day',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        item.day,
                        style: GoogleFonts.montserrat(
                          color: goalDay.toString() == item.day
                              ? Colors.red
                              : Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}