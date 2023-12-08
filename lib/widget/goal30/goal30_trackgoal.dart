import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ta_rides/data/goal30_data.dart';
import 'package:ta_rides/models/goal30_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/all_controller/goal30_controller.dart';
import 'package:ta_rides/widget/goal30/goal30_BMI_screen.dart';
import 'package:ta_rides/widget/goal30/goal30_Start.dart';
import 'package:ta_rides/widget/goal30/goal30_googlemap.dart';

class Goal30TrackGoal extends StatefulWidget {
  const Goal30TrackGoal({
    super.key,
    required this.user,
    required this.goal30,
  });

  final Users user;
  final Goal30 goal30;

  @override
  State<Goal30TrackGoal> createState() => _Goal30TrackGoalState();
}

class _Goal30TrackGoalState extends State<Goal30TrackGoal> {
  LocationData? _locationData;
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  final goal30PinController = TextEditingController();
  Goal30Controller goal30Controller = Goal30Controller();
  ScrollController scrollController = ScrollController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final keys = List<GlobalKey>.generate(90, (index) => GlobalKey());
  int goalDay = 1;

  int dateDay = DateTime.now().day;
  List<bool> dayDone = [];
  int day = 0;
  late DateTime startDate;
  bool click = false;
  late Goal30 goals30;

  List<int> goalsssDone = [];

  void refreshData() {
    setState(() {
      goalsssDone = goalsssDone;
      goalDay = goalDay;
    });
  }

  void daySet() async {
    for (var i = 1; i < 90; i++) {
      final days = await FirebaseFirestore.instance
          .collection('goal30')
          .where('userName', isEqualTo: widget.user.username)
          .where('day$i', isEqualTo: false)
          .get();

      if (days.docs.isEmpty) {
        print('no day found');
        goalsssDone.add(i);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    daySet();
    initializeGoalDay();
    initializeLocation();
    goal30Controller.getUserGoal30(widget.user.username);
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

    if (mounted) {
      setState(() {
        _locationData = _locationData;
      });
    }
  }

  void loadGoalDay() async {
    final goal30QuerySnapshot = await FirebaseFirestore.instance
        .collection('goal30')
        .where('userName', isEqualTo: widget.user.username)
        .get();

    if (goal30QuerySnapshot.docs.isEmpty) {
      throw Exception('No goal30 found');
    }

    final goal30DocumentSnapshot = goal30QuerySnapshot.docs.first;
    goals30 = Goal30.fromDocument(goal30DocumentSnapshot);

    SharedPreferences.getInstance().then((prefs) {
      startDate = DateTime.parse(
          prefs.getString('startDate') ?? DateTime.now().toIso8601String());

      DateTime goalDate = goals30.timestamp.toDate();

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

        // if(goalDay )
      });
    });
    for (var i = 0; i < goals30.goalLenght; i++) {
      if (goals30.goalLenght == goal30.length) {
        if (goalDay - 1 > i && goal30[i].kmGoal.toString() == '0.0') {
          await goal30QuerySnapshot.docs.first.reference.update({
            'day${i + 1}': true,
          });
        }
      }
    }
    for (var i = 0; i < goals30.goalLenght; i++) {
      if (goals30.goalLenght == goal60.length) {
        if (goalDay - 1 > i && goal60[i].kmGoal.toString() == '0.0') {
          await goal30QuerySnapshot.docs.first.reference.update({
            'day${i + 1}': true,
          });
        }
      }
    }
    for (var i = 0; i < goals30.goalLenght; i++) {
      if (goals30.goalLenght == goal90.length) {
        if (goalDay - 1 > i && goal90[i].kmGoal.toString() == '0.0') {
          await goal30QuerySnapshot.docs.first.reference.update({
            'day${i + 1}': true,
          });
        }
      }
    }
    // for (var i = 0; i < goal30.length; i++) {
    //   if (goalDay > i && goal60[i].kmGoal.toString() == '0.0') {
    //     await goal30QuerySnapshot.docs.first.reference.update({
    //       'day${i + 1}': true,
    //     });
    //   }
    // }
    // for (var i = 0; i < goal30.length; i++) {
    //   if (goalDay > i && goal90[i].kmGoal.toString() == '0.0') {
    //     await goal30QuerySnapshot.docs.first.reference.update({
    //       'day${i + 1}': true,
    //     });
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    print(goalDay);

    // for (var goal in goalDone) {
    //   goal.days.forEach((day, value) {
    //     if (value == true) {
    //       print('Day $day is done');
    //     }
    //   });
    // }
    print(["goalDoneee", goalsssDone.length]);
    for (var i = 0; i < goalsssDone.length; i++) {
      print(['goalsssDone', goalsssDone[i]]);
    }

    Widget buildCard(BMI item, int dateDay, GlobalKey key) => ClipRRect(
          key: key,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: () {
              refreshData();
              setState(() {
                day = item.day;
                click = true;
              });
            },
            child: AnimatedBuilder(
                animation: goal30Controller,
                builder: (context, snapshot) {
                  if (goal30Controller.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 100,
                          color: day == item.day
                              ? const Color.fromARGB(255, 55, 60, 71)
                              : goalsssDone.contains(item.day)
                                  ? Colors.red
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
                                  item.day.toString(),
                                  style: GoogleFonts.montserrat(
                                    color: goalsssDone.contains(item.day) &&
                                            goalDay == item.day
                                        ? Color.fromARGB(255, 15, 16, 65)
                                        : goalDay == item.day
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
                  );
                }),
          ),
        );

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
                    final itemKey = GlobalKey();
                    if (goal30Controller.goal30.goalLenght == 30) {
                      final itemKey = GlobalKey();
                      final item = goal30[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: buildCard(item, dateDay, itemKey),
                      );
                    }
                    if (goal30Controller.goal30.goalLenght == 60) {
                      final itemKey = GlobalKey();
                      final item = goal60[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: buildCard(item, dateDay, itemKey),
                      );
                    }
                    if (goal30Controller.goal30.goalLenght == 90) {
                      final itemKey = GlobalKey();
                      final item = goal90[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: buildCard(item, dateDay, itemKey),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: buildCard(goal30[index], dateDay, keys[index]),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (click == false)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text(
                    'click on the day to see your goal',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                  ),
                ),
              for (var i = 0; i < goal30.length; i++)
                if (goal30[i].yourCategory == goal30Controller.goal30.category)
                  if (goal30[i].day == day)
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
                                    text: goal30[i].kmGoal.toString() == '0.0'
                                        ? 'REST DAY'
                                        : goal30[i].kmGoal.toString() + ' km',
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
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Your BMI: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                    ),
                              ),
                              Text(
                                goal30Controller.goal30.bmiCategory,
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
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size.fromHeight(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide.none,
                                  ),
                                  backgroundColor: Color(0x3ffFF0000)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => Goal30BmiScreen(
                                      user: widget.user,
                                      email: widget.user.email,
                                      check: false,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Check your BMI again',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (day == 30)
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size.fromHeight(60),
                                  maximumSize: const Size.fromWidth(380),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide.none,
                                  ),
                                  backgroundColor: goalDay == 30
                                      ? Colors.red
                                      : Color(0x3ff797979),
                                ),
                                onPressed: () async {
                                  var checkGoal = 1;
                                  if (goalDay != 30) {
                                    print('hellooowre');
                                    return;
                                  }
                                  if (goalDay == 30) {
                                    FutureBuilder<QuerySnapshot>(
                                      future: FirebaseFirestore.instance
                                          .collection('goal30')
                                          .where('userName',
                                              isEqualTo: widget.user.username)
                                          .get(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          for (var i = 1;
                                              i < widget.goal30.goalLenght;
                                              i++) {
                                            final achieve = snapshot.data?.docs
                                                .where((doc) =>
                                                    doc['day$i'] == true);
                                            if (achieve!.isNotEmpty) {
                                              setState(() {
                                                checkGoal++;
                                              });
                                            }
                                          }
                                          return Container(); // Return an empty container when no loading is shown
                                        }
                                      },
                                    );
                                  }
                                  print(['checkGoal', checkGoal]);
                                  if (checkGoal == 30) {
                                    final achiever = await FirebaseFirestore
                                        .instance
                                        .collection('achievement')
                                        .where('userName',
                                            isEqualTo: widget.user.username)
                                        .get();

                                    if (achiever.docs.isNotEmpty) {
                                      achiever.docs.first.reference.update({
                                        'flawlessGoal30': true,
                                      }).then((value) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Congratulations!'),
                                              content: const Text(
                                                  'You received the Flawless Rider Badge Goal 30.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    } else {
                                      print('No achievement documents found');
                                    }
                                  }

                                  if (checkGoal <= 30 && checkGoal >= 25) {
                                    print('gwapo lukeeeeeeeeeee');
                                    final achiever = await FirebaseFirestore
                                        .instance
                                        .collection('achievement')
                                        .where('userName',
                                            isEqualTo: widget.user.username)
                                        .get();

                                    if (achiever.docs.isNotEmpty) {
                                      achiever.docs.first.reference.update({
                                        'consistentGoal30': true,
                                      }).then((value) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Congratulations!'),
                                              content: const Text(
                                                  'You received the Consistent Rider Badge Goal 30.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    } else {
                                      print('No achievement documents found');
                                    }
                                  }

                                  if (checkGoal < 25) {
                                    print('gwapo luke');
                                    final achiever = await FirebaseFirestore
                                        .instance
                                        .collection('achievement')
                                        .where('userName',
                                            isEqualTo: widget.user.username)
                                        .get();

                                    if (achiever.docs.isNotEmpty) {
                                      achiever.docs.first.reference.update({
                                        'resilientgoal30': true,
                                      }).then((value) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Congratulations!'),
                                              content: const Text(
                                                  'You received the Resilient Rider Badge Goal 30.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    } else {
                                      print('No achievement documents found');
                                    }
                                  }
                                },
                                child: Text(
                                  'Challenge Completed!',
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
              for (var i = 0; i < goal60.length; i++)
                if (goal60[i].yourCategory == goal30Controller.goal30.category)
                  if (goal60[i].day == day)
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
                                    text: goal60[i].kmGoal.toString() == '0.0'
                                        ? 'REST DAY'
                                        : goal60[i].kmGoal.toString() + ' km',
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
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Your BMI: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                    ),
                              ),
                              Text(
                                goal30Controller.goal30.bmiCategory,
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
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size.fromHeight(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide.none,
                                  ),
                                  backgroundColor: Color(0x3ffFF0000)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => Goal30BmiScreen(
                                      user: widget.user,
                                      email: widget.user.email,
                                      check: false,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Check your BMI again',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (day == 60)
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size.fromHeight(60),
                                  maximumSize: const Size.fromWidth(380),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide.none,
                                  ),
                                  backgroundColor: goalDay == 60
                                      ? Colors.red
                                      : Color(0x3ff797979),
                                ),
                                onPressed: () async {
                                  var checkGoal = 1;
                                  if (goalDay != 60) {
                                    print('hellooowre');
                                    return;
                                  }
                                  if (goalDay == 60) {
                                    FutureBuilder<QuerySnapshot>(
                                      future: FirebaseFirestore.instance
                                          .collection('goal30')
                                          .where('userName',
                                              isEqualTo: widget.user.username)
                                          .get(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          for (var i = 1;
                                              i < widget.goal30.goalLenght;
                                              i++) {
                                            final achieve = snapshot.data?.docs
                                                .where((doc) =>
                                                    doc['day$i'] == true);
                                            if (achieve!.isNotEmpty) {
                                              setState(() {
                                                checkGoal++;
                                              });
                                            }
                                          }
                                          return Container(); // Return an empty container when no loading is shown
                                        }
                                      },
                                    );
                                  }
                                  print(['checkGoal', checkGoal]);
                                  if (checkGoal == 60) {
                                    final achiever = await FirebaseFirestore
                                        .instance
                                        .collection('achievement')
                                        .where('userName',
                                            isEqualTo: widget.user.username)
                                        .get();

                                    if (achiever.docs.isNotEmpty) {
                                      achiever.docs.first.reference.update({
                                        'flawlessGoal60': true,
                                      }).then((value) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Congratulations!'),
                                              content: const Text(
                                                  'You received the Flawless Rider Badge Goal 60.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    } else {
                                      print('No achievement documents found');
                                    }
                                  }

                                  if (checkGoal <= 60 && checkGoal >= 55) {
                                    print('gwapo lukeeeeeeeeeee');
                                    final achiever = await FirebaseFirestore
                                        .instance
                                        .collection('achievement')
                                        .where('userName',
                                            isEqualTo: widget.user.username)
                                        .get();

                                    if (achiever.docs.isNotEmpty) {
                                      achiever.docs.first.reference.update({
                                        'consistentGoal60': true,
                                      }).then((value) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Congratulations!'),
                                              content: const Text(
                                                  'You received the Consistent Rider Badge Goal 60.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    } else {
                                      print('No achievement documents found');
                                    }
                                  }

                                  if (checkGoal < 55) {
                                    print('gwapo luke');
                                    final achiever = await FirebaseFirestore
                                        .instance
                                        .collection('achievement')
                                        .where('userName',
                                            isEqualTo: widget.user.username)
                                        .get();

                                    if (achiever.docs.isNotEmpty) {
                                      achiever.docs.first.reference.update({
                                        'resilientgoal60': true,
                                      }).then((value) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Congratulations!'),
                                              content: const Text(
                                                  'You received the Resilient Rider Badge Goal 60.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    } else {
                                      print('No achievement documents found');
                                    }
                                  }
                                },
                                child: Text(
                                  'Challenge Completed!',
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
              for (var i = 0; i < goal90.length; i++)
                if (goal90[i].yourCategory == goal30Controller.goal30.category)
                  if (goal90[i].day == day)
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
                                    text: goal90[i].kmGoal.toString() == '0.0'
                                        ? 'REST DAY'
                                        : goal90[i].kmGoal.toString() + ' km',
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
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Your BMI: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                    ),
                              ),
                              Text(
                                goal30Controller.goal30.bmiCategory,
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
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size.fromHeight(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide.none,
                                  ),
                                  backgroundColor: Color(0x3ffFF0000)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => Goal30BmiScreen(
                                      user: widget.user,
                                      email: widget.user.email,
                                      check: false,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Check your BMI again',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (day == 90)
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size.fromHeight(60),
                                  maximumSize: const Size.fromWidth(380),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide.none,
                                  ),
                                  backgroundColor: goalDay == 90
                                      ? Colors.red
                                      : Color(0x3ff797979),
                                ),
                                onPressed: () async {
                                  var checkGoal = 1;
                                  if (goalDay != 90) {
                                    print('hellooowre');
                                    return;
                                  }
                                  if (goalDay == 90) {
                                    FutureBuilder<QuerySnapshot>(
                                      future: FirebaseFirestore.instance
                                          .collection('goal30')
                                          .where('userName',
                                              isEqualTo: widget.user.username)
                                          .get(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          for (var i = 1;
                                              i < widget.goal30.goalLenght;
                                              i++) {
                                            final achieve = snapshot.data?.docs
                                                .where((doc) =>
                                                    doc['day$i'] == true);
                                            if (achieve!.isNotEmpty) {
                                              setState(() {
                                                checkGoal++;
                                              });
                                            }
                                          }
                                          return Container(); // Return an empty container when no loading is shown
                                        }
                                      },
                                    );
                                  }
                                  print(['checkGoal', checkGoal]);
                                  if (checkGoal == 90) {
                                    final achiever = await FirebaseFirestore
                                        .instance
                                        .collection('achievement')
                                        .where('userName',
                                            isEqualTo: widget.user.username)
                                        .get();

                                    if (achiever.docs.isNotEmpty) {
                                      achiever.docs.first.reference.update({
                                        'flawlessGoal90': true,
                                      }).then((value) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Congratulations!'),
                                              content: const Text(
                                                  'You received the Flawless Rider Badge Goal 90.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    } else {
                                      print('No achievement documents found');
                                    }
                                  }

                                  if (checkGoal <= 90 && checkGoal >= 85) {
                                    print('gwapo lukeeeeeeeeeee');
                                    final achiever = await FirebaseFirestore
                                        .instance
                                        .collection('achievement')
                                        .where('userName',
                                            isEqualTo: widget.user.username)
                                        .get();

                                    if (achiever.docs.isNotEmpty) {
                                      achiever.docs.first.reference.update({
                                        'consistentGoal90': true,
                                      }).then((value) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Congratulations!'),
                                              content: const Text(
                                                  'You received the Consistent Rider Badge Goal 90.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    } else {
                                      print('No achievement documents found');
                                    }
                                  }

                                  if (checkGoal < 85) {
                                    print('gwapo luke');
                                    final achiever = await FirebaseFirestore
                                        .instance
                                        .collection('achievement')
                                        .where('userName',
                                            isEqualTo: widget.user.username)
                                        .get();

                                    if (achiever.docs.isNotEmpty) {
                                      achiever.docs.first.reference.update({
                                        'resilientgoal90': true,
                                      }).then((value) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Congratulations!'),
                                              content: const Text(
                                                  'You received the Resilient Rider Badge Goal 90.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    } else {
                                      print('No achievement documents found');
                                    }
                                  }
                                },
                                child: Text(
                                  'Challenge Completed!',
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
              const SizedBox(
                height: 10,
              ),
              for (var i = 0; i < goal30.length; i++)
                if (goal30Controller.goal30.goalLenght == goal30.length)
                  if (goal30[i].day == day)
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(60),
                          maximumSize: const Size.fromWidth(380),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide.none,
                          ),
                          backgroundColor: goalsssDone.contains(goal30[i].day)
                              ? Color(0x3ff797979)
                              : goal30[i].kmGoal.toString() == '0.0'
                                  ? Color(0x3ff797979)
                                  : Colors.red,
                        ),
                        onPressed: () {
                          if (goalsssDone.contains(goal30[i].day)) {
                            return null;
                          } else if (goal30[i].kmGoal.toString() != '0.0') {
                            print(goalDay);
                            loadGoalDay();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => _locationData != null
                                    ? Goal30GoogleMap(
                                        locationData: _locationData!,
                                        user: widget.user,
                                        goalDay: goalDay,
                                        goal30: goal30Controller.goal30,
                                        day: day,
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                              ),
                            );
                          }
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
              for (var i = 0; i < goal60.length; i++)
                if (goal30Controller.goal30.goalLenght == goal60.length)
                  if (goal60[i].day == day)
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(60),
                          maximumSize: const Size.fromWidth(380),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide.none,
                          ),
                          backgroundColor: goalsssDone.contains(goal60[i].day)
                              ? Color(0x3ff797979)
                              : goal60[i].kmGoal.toString() == '0.0'
                                  ? Color(0x3ff797979)
                                  : Colors.red,
                        ),
                        onPressed: () {
                          if (goalsssDone.contains(goal60[i].day)) {
                            return null;
                          } else if (goal60[i].kmGoal.toString() != '0.0') {
                            print(goalDay);
                            loadGoalDay();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => _locationData != null
                                    ? Goal30GoogleMap(
                                        locationData: _locationData!,
                                        user: widget.user,
                                        goalDay: goalDay,
                                        goal30: goal30Controller.goal30,
                                        day: day,
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                              ),
                            );
                          }
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
              for (var i = 0; i < goal90.length; i++)
                if (goal30Controller.goal30.goalLenght == goal90.length)
                  if (goal90[i].day == day)
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(60),
                          maximumSize: const Size.fromWidth(380),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide.none,
                          ),
                          backgroundColor: goalsssDone.contains(goal90[i].day)
                              ? Color(0x3ff797979)
                              : goal90[i].kmGoal.toString() == '0.0'
                                  ? Color(0x3ff797979)
                                  : Colors.red,
                        ),
                        onPressed: () {
                          if (goalsssDone.contains(goal90[i].day)) {
                            return null;
                          } else if (goal90[i].kmGoal.toString() != '0.0') {
                            print(goalDay);
                            loadGoalDay();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => _locationData != null
                                    ? Goal30GoogleMap(
                                        locationData: _locationData!,
                                        user: widget.user,
                                        goalDay: goalDay,
                                        goal30: goal30Controller.goal30,
                                        day: day,
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                              ),
                            );
                          }
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
}
