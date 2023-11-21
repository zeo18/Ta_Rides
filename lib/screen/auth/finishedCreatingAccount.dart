import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      required this.addUser,
      required this.selectUserImageValue});

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
  State<FinishedCreatingAccount> createState() =>
      _FinishedCreatingAccountState();
}

class _FinishedCreatingAccountState extends State<FinishedCreatingAccount> {
  // int userID = UserInformation[UserInformation.length - 1].id + 1;

  void addUser() {
    // widget.addUser(
    //   Users(
    //     id: userID,
    //     userImage: '',
    //     username: widget.usernameValue,
    //     password: widget.passwordValue,
    //     firstName: widget.firstNameValue,
    //     lastName: widget.lastNameValue,
    //     email: widget.emailValue,
    //     birthdate: widget.selectedDateValue,
    //     gender: widget.genderValue,
    //     location: widget.countryValue,
    //     phoneNumber: widget.phoneNumberValue,
    //     followers: 0,
    //     following: 0,
    //     isCommunity: false,
    //     communityId: 0,
    //     isAchievement: false,
    //     chooseUserImage: widget.selectUserImageValue,
    //   ),
    // );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => LoginPage(),
      ),
    );
  }

  void submitCreateAccount() async {
    try {
      // Create a new user in Firebase Authentication
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.emailValue,
        password: widget.passwordValue,
      );

      // Get the user's unique ID from Firebase Authentication
      final userId = userCredential.user!.uid;

      // Upload the user image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('$userId.jpg');
      await storageRef.putFile(widget.selectUserImageValue);

      // Get the download URL of the uploaded image
      final imageUrl = await storageRef.getDownloadURL();

      // Store user data in Firestore
      final docRef = FirebaseFirestore.instance.collection('goal30').doc();
      final id = docRef.id;

      await FirebaseFirestore.instance.collection('goal30').add({
        'userName': widget.usernameValue,
        'timestamp': DateTime.now(),
        'category': '',
        'goalLenght': 0,
        'goal30Id': id,
        'userData': false,
        'day1': false,
        'day2': false,
        'day3': false,
        'day4': false,
        'day5': false,
        'day6': false,
        'day7': false,
        'day8': false,
        'day9': false,
        'day10': false,
        'day11': false,
        'day12': false,
        'day13': false,
        'day14': false,
        'day15': false,
        'day16': false,
        'day17': false,
        'day18': false,
        'day19': false,
        'day20': false,
        'day21': false,
        'day22': false,
        'day23': false,
        'day24': false,
        'day25': false,
        'day26': false,
        'day27': false,
        'day28': false,
        'day29': false,
        'day30': false,
        'day31': false,
        'day32': false,
        'day33': false,
        'day34': false,
        'day35': false,
        'day36': false,
        'day37': false,
        'day38': false,
        'day39': false,
        'day40': false,
        'day41': false,
        'day42': false,
        'day43': false,
        'day44': false,
        'day45': false,
        'day46': false,
        'day47': false,
        'day48': false,
        'day49': false,
        'day50': false,
        'day51': false,
        'day52': false,
        'day53': false,
        'day54': false,
        'day55': false,
        'day56': false,
        'day57': false,
        'day58': false,
        'day59': false,
        'day60': false,
        'day61': false,
        'day62': false,
        'day63': false,
        'day64': false,
        'day65': false,
        'day66': false,
        'day67': false,
        'day68': false,
        'day69': false,
        'day70': false,
        'day71': false,
        'day72': false,
        'day73': false,
        'day74': false,
        'day75': false,
        'day76': false,
        'day77': false,
        'day78': false,
        'day79': false,
        'day80': false,
        'day81': false,
        'day82': false,
        'day83': false,
        'day84': false,
        'day85': false,
        'day86': false,
        'day87': false,
        'day88': false,
        'day89': false,
        'day90': false,
      });

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'username': widget.usernameValue,
        'firstName': widget.firstNameValue,
        'lastName': widget.lastNameValue,
        'email': widget.emailValue,
        'password': widget.passwordValue,
        'birthdate': widget.selectedDateValue,
        'gender': widget.genderValue.toString(),
        'phoneNumber': widget.phoneNumberValue,
        'location': widget.countryValue,
        'followers': 0,
        'following': 0,
        'isCommunity': false,
        'communityId': '',
        'isAchievement': false,
        'userImage': imageUrl, // Store the image URL, not the File object
      }).then((value) => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const LoginPage(),
              ),
            )
          });

      print('Account created successfully');
    } catch (error) {
      print('Error creating account: $error');
    }
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
    // print(['userID', userID]);
    print(['picture', widget.selectUserImageValue]);
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
                onPressed: submitCreateAccount,
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
