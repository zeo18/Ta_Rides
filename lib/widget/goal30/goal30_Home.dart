// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Goal30Home extends StatefulWidget {
  const Goal30Home({Key? key, required this.yourCategory});

  final String yourCategory;

  @override
  _Goal30HomeState createState() => _Goal30HomeState();
}

class BMI {
  final String day;
  final String category;
  final String kmGoal;

  BMI({
    required this.day,
    required this.category,
    required this.kmGoal,
  });
}

final _firstPinController = TextEditingController();

class _Goal30HomeState extends State<Goal30Home> {
  int day = 0;
  int dateDay = DateTime.now().day;

  int goalDay = 1;

  final underWeight = [
    BMI(day: '1', category: 'UnderWeight', kmGoal: '.5 km'),
    BMI(day: '2', category: 'UnderWeight', kmGoal: '.5 km'),
    BMI(day: '3', category: 'UnderWeight', kmGoal: '.5 km'),
    BMI(day: '4', category: 'UnderWeight', kmGoal: '.5 km'),
    BMI(day: '5', category: 'UnderWeight', kmGoal: '1 km'),
    BMI(day: '6', category: 'UnderWeight', kmGoal: '1 km'),
    BMI(day: '7', category: 'UnderWeight', kmGoal: 'REST DAY'),
    BMI(day: '8', category: 'UnderWeight', kmGoal: '.5 km'),
    BMI(day: '9', category: 'UnderWeight', kmGoal: '.5 km'),
    BMI(day: '10', category: 'UnderWeight', kmGoal: '1 km'),
    BMI(day: '11', category: 'UnderWeight', kmGoal: '1 km'),
    BMI(day: '12', category: 'UnderWeight', kmGoal: '1.5 km'),
    BMI(day: '13', category: 'UnderWeight', kmGoal: '1.5 km'),
    BMI(day: '14', category: 'UnderWeight', kmGoal: 'REST DAY'),
    BMI(day: '15', category: 'UnderWeight', kmGoal: '.5 km'),
    BMI(day: '16', category: 'UnderWeight', kmGoal: '.5 km'),
    BMI(day: '17', category: 'UnderWeight', kmGoal: '1.5 km'),
    BMI(day: '18', category: 'UnderWeight', kmGoal: '1.5 km'),
    BMI(day: '19', category: 'UnderWeight', kmGoal: '2 km'),
    BMI(day: '20', category: 'UnderWeight', kmGoal: '2 km'),
    BMI(day: '21', category: 'UnderWeight', kmGoal: 'REST DAY'),
    BMI(day: '22', category: 'UnderWeight', kmGoal: '.5 km'),
    BMI(day: '23', category: 'UnderWeight', kmGoal: '.5 km'),
    BMI(day: '24', category: 'UnderWeight', kmGoal: '1.5 km'),
    BMI(day: '25', category: 'UnderWeight', kmGoal: '1.5 km'),
    BMI(day: '26', category: 'UnderWeight', kmGoal: '2 km'),
    BMI(day: '27', category: 'UnderWeight', kmGoal: '2 km'),
    BMI(day: '28', category: 'UnderWeight', kmGoal: 'REST DAY'),
    BMI(day: '29', category: 'UnderWeight', kmGoal: '1 km'),
    BMI(day: '30', category: 'UnderWeight', kmGoal: '1 km'),
  ];

  final normal = [
    BMI(day: '1', category: 'Normal', kmGoal: '.5 km'),
    BMI(day: '2', category: 'Normal', kmGoal: '.5 km'),
    BMI(day: '3', category: 'Normal', kmGoal: '1 km'),
    BMI(day: '4', category: 'Normal', kmGoal: '1 km'),
    BMI(day: '5', category: 'Normal', kmGoal: '1 km'),
    BMI(day: '6', category: 'Normal', kmGoal: '1 km'),
    BMI(day: '7', category: 'Normal', kmGoal: 'REST DAY'),
    BMI(day: '8', category: 'Normal', kmGoal: '.5 km'),
    BMI(day: '9', category: 'Normal', kmGoal: '.5 km'),
    BMI(day: '10', category: 'Normal', kmGoal: '1 km'),
    BMI(day: '11', category: 'Normal', kmGoal: '1 km'),
    BMI(day: '12', category: 'Normal', kmGoal: '2 km'),
    BMI(day: '13', category: 'Normal', kmGoal: '2 km'),
    BMI(day: '14', category: 'Normal', kmGoal: 'REST DAY'),
    BMI(day: '15', category: 'Normal', kmGoal: '.5 km'),
    BMI(day: '16', category: 'Normal', kmGoal: '.5 km'),
    BMI(day: '17', category: 'Normal', kmGoal: '1.5 km'),
    BMI(day: '18', category: 'Normal', kmGoal: '1.5 km'),
    BMI(day: '19', category: 'Normal', kmGoal: '2 km'),
    BMI(day: '20', category: 'Normal', kmGoal: '2 km'),
    BMI(day: '21', category: 'Normal', kmGoal: 'REST DAY'),
    BMI(day: '22', category: 'Normal', kmGoal: '.5 km'),
    BMI(day: '23', category: 'Normal', kmGoal: '1.5 km'),
    BMI(day: '24', category: 'Normal', kmGoal: '1.5 km'),
    BMI(day: '25', category: 'Normal', kmGoal: '2 km'),
    BMI(day: '26', category: 'Normal', kmGoal: '2 km'),
    BMI(day: '27', category: 'Normal', kmGoal: '2.5 km'),
    BMI(day: '28', category: 'Normal', kmGoal: 'REST DAY'),
    BMI(day: '29', category: 'Normal', kmGoal: '1 km'),
    BMI(day: '30', category: 'Normal', kmGoal: '1 km'),
  ];
  final overWeight = [
    BMI(day: '1', category: 'OverWeight', kmGoal: '1 km'),
    BMI(day: '2', category: 'OverWeight', kmGoal: '1 km'),
    BMI(day: '3', category: 'OverWeight', kmGoal: 'REST DAY'),
    BMI(day: '4', category: 'OverWeight', kmGoal: '1 km'),
    BMI(day: '5', category: 'OverWeight', kmGoal: '1 km'),
    BMI(day: '6', category: 'OverWeight', kmGoal: '1.5 km'),
    BMI(day: '7', category: 'OverWeight', kmGoal: 'REST DAY'),
    BMI(day: '8', category: 'OverWeight', kmGoal: '1 km'),
    BMI(day: '9', category: 'OverWeight', kmGoal: '1 km'),
    BMI(day: '10', category: 'OverWeight', kmGoal: '1 km'),
    BMI(day: '11', category: 'OverWeight', kmGoal: 'REST DAY'),
    BMI(day: '12', category: 'OverWeight', kmGoal: '1 km'),
    BMI(day: '13', category: 'OverWeight', kmGoal: '1.5 km'),
    BMI(day: '14', category: 'OverWeight', kmGoal: '1.5 km'),
    BMI(day: '15', category: 'OverWeight', kmGoal: 'REST DAY'),
    BMI(day: '16', category: 'OverWeight', kmGoal: '1.5 km'),
    BMI(day: '17', category: 'OverWeight', kmGoal: '1.5 km'),
    BMI(day: '18', category: 'OverWeight', kmGoal: '2 km'),
    BMI(day: '19', category: 'OverWeight', kmGoal: '2 km'),
    BMI(day: '20', category: 'OverWeight', kmGoal: '2.5'),
    BMI(day: '21', category: 'OverWeight', kmGoal: 'REST DAY'),
    BMI(day: '22', category: 'OverWeight', kmGoal: '1 km'),
    BMI(day: '23', category: 'OverWeight', kmGoal: '1 km'),
    BMI(day: '24', category: 'OverWeight', kmGoal: '1 km'),
    BMI(day: '25', category: 'OverWeight', kmGoal: '1.5 km'),
    BMI(day: '26', category: 'OverWeight', kmGoal: '2 km'),
    BMI(day: '27', category: 'OverWeight', kmGoal: '2 km'),
    BMI(day: '28', category: 'OverWeight', kmGoal: '2.5 km'),
    BMI(day: '29', category: 'OverWeight', kmGoal: 'REST DAY'),
    BMI(day: '30', category: 'OverWeight', kmGoal: '2.5 km'),
  ];
  final obese = [
    BMI(day: '1', category: 'Obesity', kmGoal: '1 km'),
    BMI(day: '2', category: 'Obesity', kmGoal: '1 km'),
    BMI(day: '3', category: 'Obesity', kmGoal: 'REST DAY'),
    BMI(day: '4', category: 'Obesity', kmGoal: '1 km'),
    BMI(day: '5', category: 'Obesity', kmGoal: '1.5 km'),
    BMI(day: '6', category: 'Obesity', kmGoal: '1.5 km'),
    BMI(day: '7', category: 'Obesity', kmGoal: 'REST DAY'),
    BMI(day: '8', category: 'Obesity', kmGoal: '1 km'),
    BMI(day: '9', category: 'Obesity', kmGoal: '1 km'),
    BMI(day: '10', category: 'Obesity', kmGoal: '1.5 km'),
    BMI(day: '11', category: 'Obesity', kmGoal: 'REST DAY'),
    BMI(day: '12', category: 'Obesity', kmGoal: '1.5 km'),
    BMI(day: '13', category: 'Obesity', kmGoal: '1.5 km'),
    BMI(day: '14', category: 'Obesity', kmGoal: '1.5 km'),
    BMI(day: '15', category: 'Obesity', kmGoal: 'REST DAY'),
    BMI(day: '16', category: 'Obesity', kmGoal: '1 km'),
    BMI(day: '17', category: 'Obesity', kmGoal: '1.5 km'),
    BMI(day: '18', category: 'Obesity', kmGoal: '2 km'),
    BMI(day: '19', category: 'Obesity', kmGoal: '2 km'),
    BMI(day: '20', category: 'Obesity', kmGoal: '2.5 km'),
    BMI(day: '21', category: 'Obesity', kmGoal: 'REST DAY'),
    BMI(day: '22', category: 'Obesity', kmGoal: '1 km'),
    BMI(day: '23', category: 'Obesity', kmGoal: '1 km'),
    BMI(day: '24', category: 'Obesity', kmGoal: '1.5 km'),
    BMI(day: '25', category: 'Obesity', kmGoal: '1.5 km'),
    BMI(day: '26', category: 'Obesity', kmGoal: '2 km'),
    BMI(day: '27', category: 'Obesity', kmGoal: '2 km'),
    BMI(day: '28', category: 'Obesity', kmGoal: '2.5 km'),
    BMI(day: '29', category: 'Obesity', kmGoal: 'REST DAY'),
    BMI(day: '30', category: 'Obesity', kmGoal: '2.5 km'),
  ];

  @override
  void initState() {
    super.initState();
    loadGoalDay(); // Load the goal day when the widget is created
  }

  void loadGoalDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime startDate = DateTime.parse(
        prefs.getString('startDate') ?? DateTime.now().toIso8601String());
    setState(() {
      goalDay = DateTime.now().difference(startDate).inMinutes + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(dateDay);
    print(goalDay);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0D11),
      ),
      backgroundColor: const Color(0xFF0C0D11),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 100,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              itemCount: normal.length,
              itemBuilder: (context, index) {
                final item = normal[index];
                return buildCard(item, dateDay);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          for (var i = 0; i < underWeight.length; i++)
            if (underWeight[i].category == widget.yourCategory)
              if (underWeight[i].day == day.toString())
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Category:',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              text: underWeight[i].category,
                              style: GoogleFonts.montserrat(
                                color: Color(0x3FFFE8AA0A),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Today's Goal:",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                            TextSpan(
                              text: underWeight[i].kmGoal.toString(),
                              style: GoogleFonts.montserrat(
                                color: Color(0x3FFFE8AA0A),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
          for (var i = 0; i < normal.length; i++)
            if (normal[i].category == widget.yourCategory)
              if (normal[i].day == day.toString())
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Category:',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              text: normal[i].category,
                              style: GoogleFonts.montserrat(
                                color: Color(0x3FFFE8AA0A),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Today's Goal:",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                            TextSpan(
                              text: normal[i].kmGoal.toString(),
                              style: GoogleFonts.montserrat(
                                color: Color(0x3FFFE8AA0A),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
          for (var i = 0; i < overWeight.length; i++)
            if (overWeight[i].category == widget.yourCategory)
              if (overWeight[i].day == day.toString())
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Category:',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              text: overWeight[i].category,
                              style: GoogleFonts.montserrat(
                                color: Color(0x3FFFE8AA0A),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Today's Goal:",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                            TextSpan(
                              text: overWeight[i].kmGoal.toString(),
                              style: GoogleFonts.montserrat(
                                color: Color(0x3FFFE8AA0A),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
          for (var i = 0; i < obese.length; i++)
            if (obese[i].category == widget.yourCategory)
              if (obese[i].day == day.toString())
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Category:',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              text: obese[i].category,
                              style: GoogleFonts.montserrat(
                                color: Color(0x3FFFE8AA0A),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Today's Goal:",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                            TextSpan(
                              text: obese[i].kmGoal.toString(),
                              style: GoogleFonts.montserrat(
                                color: Color(0x3FFFE8AA0A),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: 30,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Color(0x3FFF181A20),
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
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _firstPinController,
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
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
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
              onPressed: () {
                print(goalDay);
                loadGoalDay();
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
      ),
    );
  }

  Widget buildCard(BMI item, int dateDay) => ClipRRect(
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
                    ? Color.fromARGB(255, 55, 60, 71)
                    : Color(0xFF181A20),
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
