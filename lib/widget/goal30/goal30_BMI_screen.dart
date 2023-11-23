import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
import 'package:ta_rides/widget/goal30/goal30_Category.dart';

class Goal30BmiScreen extends StatefulWidget {
  const Goal30BmiScreen({
    super.key,
    required this.user,
    required this.email,
    required this.check,
  });

  final Users user;
  final String email;
  final bool check;

  @override
  State<Goal30BmiScreen> createState() => _Goal30BmiScreenState();
}

class _Goal30BmiScreenState extends State<Goal30BmiScreen> {
  final _ageController = TextEditingController();

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  String? result;
  String? bmicategory;
  double? bmi;

  void startGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('startDate', DateTime.now().toIso8601String());

    // Rest of your code to start the goal...
  }

  void _calculateBMI() async {
    double height = double.tryParse(_heightController.text) ?? 0.0;
    double weight = double.tryParse(_weightController.text) ?? 0.0;

    if (height > 0 && weight > 0) {
      double bmi = (weight / (height * height) * 10000);
      setState(() {
        result = '${bmi.toStringAsFixed(1)}';
        if (bmi < 18.5) {
          bmicategory = 'UnderWeight';
        } else if (bmi >= 18.5 && bmi <= 24.9) {
          bmicategory = 'Normal';
        } else if (bmi >= 25 && bmi <= 29.9) {
          bmicategory = 'OverWeight';
        } else if (bmi >= 30) {
          bmicategory = 'Obesity';
        }
      });

      final goalBmi = await FirebaseFirestore.instance
          .collection('goal30')
          .where('userName', isEqualTo: widget.user.username)
          .get();

      await goalBmi.docs.first.reference.update({
        'bmiCategory': bmicategory!,
      });
    } else {
      setState(() {
        result = 'Invalid input.';
        bmicategory = '';
      });
    }
  }

  void _bmiChecker() {
    if (_ageController.text.isNotEmpty &&
        _heightController.text.isNotEmpty &&
        _weightController.text.isNotEmpty &&
        result != null &&
        bmicategory != null) {
      startGoal();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Goal30Category(
            email: widget.email,
            user: widget.user,
            bmi: bmicategory!,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Account'),
          content: const Text('Please Complete the Form'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'Exit',
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Column(
          children: [
            IconButton(
                onPressed: () {
                  if (widget.check) {
                    Navigator.pop(context);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TabsScreen(
                                email: widget.user.email,
                                tabsScreen: 3,
                                communityTabs: 0,
                              )),
                    );
                  }
                },
                icon: const Icon(Icons.arrow_back))
          ],
        ),
        backgroundColor: Color(0x3FFF0C0D11),
        title: Text(
          'Check your BMI',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            color: Colors.white, // Change to your "i" icon
            onPressed: () {
              // Add your logic for the "i" button here
            },
          ),
        ],
      ),
      backgroundColor: Color(0x3FFF0C0D11),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Weight in kg',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                maxLength: 5,
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
                  prefixIcon: const Icon(
                    Icons.scale_sharp,
                    color: Color(0x3fff454545),
                  ),
                  prefixIconColor: const Color(0x3fff454545),
                  suffix: Text(
                    'kg',
                    style: TextStyle(
                      color: Color(0x3fff454545),
                    ),
                  ),
                  labelText: 'Weight',
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Your Age',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                maxLength: 3,
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
                  prefixIcon: const Icon(
                    Icons.calendar_month,
                    color: Color(0x3fff454545),
                  ),
                  prefixIconColor: const Color(0x3fff454545),
                  suffix: Text(
                    'yrs',
                    style: TextStyle(
                      color: Color(0x3fff454545),
                    ),
                  ),
                  labelText: 'Age',
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Your Height in cm',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                maxLength: 5,
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
                  prefixIcon: const Icon(
                    Icons.height,
                    color: Color(0x3fff454545),
                  ),
                  prefixIconColor: const Color(0x3fff454545),
                  suffix: Text(
                    'cm',
                    style: TextStyle(
                      color: Color(0x3fff454545),
                    ),
                  ),
                  labelText: 'Height',
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            'YOUR BMI:',
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    result == null ? '' : '$result',
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    bmicategory == null ? '' : '$bmicategory',
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25,
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
                    onPressed: _calculateBMI,
                    child: Text(
                      'Compute BMI',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  if (widget.check)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromHeight(60),
                        maximumSize: const Size.fromWidth(350),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide.none,
                        ),
                        backgroundColor: const Color(0x3FFF0C0D11),
                      ),
                      onPressed: _bmiChecker,
                      child: Text(
                        'Proceed',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
