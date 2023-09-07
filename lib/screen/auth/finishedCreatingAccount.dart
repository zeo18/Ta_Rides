import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/data/user_data.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/auth/logInPage.dart';

class FinishedCreatingAccount extends StatefulWidget {
  const FinishedCreatingAccount(
      {super.key,
      required this.passwordValue,
      required this.countryValue,
      required this.emailValue,
      required this.firstNameValue,
      required this.genderValue,
      required this.lastNameValue,
      required this.middleNameValue,
      required this.phoneNumberValue,
      required this.selectedDateValue,
      required this.usernameValue,
      required this.addUser});
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
  final Function(Users user) addUser;

  @override
  State<FinishedCreatingAccount> createState() =>
      _FinishedCreatingAccountState();
}

class _FinishedCreatingAccountState extends State<FinishedCreatingAccount> {
  int userID = UserInformation[UserInformation.length - 1].id + 1;
  void addUser() {
    widget.addUser(Users(
        id: userID,
        userImage: '',
        username: widget.usernameValue,
        password: widget.passwordValue,
        firstName: widget.firstNameValue,
        lastName: widget.lastNameValue,
        email: widget.emailValue,
        birthdate: widget.selectedDateValue,
        gender: widget.genderValue,
        location: widget.countryValue,
        phoneNumber: widget.phoneNumberValue,
        followers: 0,
        following: 0,
        isCommunity: false,
        communityId: 0,
        isAchievement: false,
        chooseUserImage: Uint8List.fromList([])));

    Navigator.push(context, MaterialPageRoute(builder: (ctx) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    print(['middleNameValue', widget.middleNameValue]);
    print(['firstNameValue', widget.firstNameValue]);
    print(['lasttNameValue', widget.lastNameValue]);

    print(['selectDateValue', widget.selectedDateValue]);
    print(['selectPhoneNum', widget.phoneNumberValue]);
    print(['selectGender', widget.genderValue]);

    print(['emailValue', widget.emailValue]);
    print(['location Value', widget.countryValue]);
    print(['usernameValue', widget.usernameValue]);
    print(['password', widget.passwordValue]);
    print(['userID', userID]);
    return Scaffold(
      body: Container(
        color: const Color(0x3fff0C0D11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                  'Congratulations!',
                  style: GoogleFonts.montserrat(
                    fontSize: 38.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0x3fffFFFFF0),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Text(
                'Your account has been successfully\n created. Click proceed to access your\n profile',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: Color(0x3fffFFFFF0),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
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
                onPressed: addUser,
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
      ),
    );
  }
}
