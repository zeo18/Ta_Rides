import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/auth/finishedCreatingAccount.dart';

class CreateAccount6 extends StatefulWidget {
  const CreateAccount6(
      {super.key,
      required this.countryValue,
      required this.emailValue,
      required this.firstNameValue,
      required this.genderValue,
      required this.lastNameValue,
      required this.middleNameValue,
      required this.phoneNumberValue,
      required this.selectedDateValue,
      required this.usernameValue,
      required this.selectUserImageValue,
      required this.addUser,
      required this.passwordValue});

  final String lastNameValue;
  final String firstNameValue;
  final String middleNameValue;

  final DateTime selectedDateValue;
  final Gender genderValue;
  final String phoneNumberValue;

  final String usernameValue;
  final String emailValue;
  final String countryValue;

  final String passwordValue;

  final File selectUserImageValue;
  final Function(Users user) addUser;

  @override
  State<CreateAccount6> createState() => _CreateAccount6State();
}

class _CreateAccount6State extends State<CreateAccount6> {
  void step6Checker() {
    if (widget.passwordValue != widget.passwordValue) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
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
      return;
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinishedCreatingAccount(
            selectUserImageValue: widget.selectUserImageValue,
            passwordValue: widget.passwordValue,
            countryValue: widget.countryValue,
            emailValue: widget.emailValue,
            firstNameValue: widget.firstNameValue,
            genderValue: widget.genderValue,
            lastNameValue: widget.lastNameValue,
            middleNameValue: widget.middleNameValue,
            phoneNumberValue: widget.phoneNumberValue,
            selectedDateValue: widget.selectedDateValue,
            usernameValue: widget.usernameValue,
            addUser: widget.addUser,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x3fff0c0d11),
      appBar: AppBar(
        backgroundColor: Color(0x3fff0c0d11),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Want to',
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    ' Join A',
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0x3ffff0000),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Community?',
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                'Please enter your information below to \ncreate a new account',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromHeight(60),
                    maximumSize: Size.fromWidth(350),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide.none,
                    ),
                    backgroundColor: Color(0x3fff0c0d11),
                  ),
                  onPressed: () {
                    step6Checker();
                  },
                  child: Text(
                    'TEAM 1',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromHeight(60),
                    maximumSize: Size.fromWidth(350),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide.none,
                    ),
                    backgroundColor: Color(0x3fff0c0d11),
                  ),
                  onPressed: () {
                    step6Checker();
                  },
                  child: Text(
                    'TEAM 2',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromHeight(60),
                    maximumSize: Size.fromWidth(350),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide.none,
                    ),
                    backgroundColor: Color(0x3fff0c0d11),
                  ),
                  onPressed: () {
                    step6Checker();
                  },
                  child: Text(
                    'TEAM 1',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromHeight(60),
                    maximumSize: Size.fromWidth(350),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide.none,
                    ),
                    backgroundColor: Color(0x3fff0c0d11),
                  ),
                  onPressed: () {
                    step6Checker();
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 21.0,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromHeight(60),
                    maximumSize: Size.fromWidth(350),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide.none,
                    ),
                    backgroundColor: Color(0x3ffff0000),
                  ),
                  onPressed: () {
                    step6Checker();
                  },
                  child: Text(
                    'Continue',
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
      ),
    );
  }
}
