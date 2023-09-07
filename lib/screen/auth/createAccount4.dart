import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/auth/finishedCreatingAccount.dart';

class CreateAccount4 extends StatefulWidget {
  const CreateAccount4(
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
  final Function(Users user) addUser;

  @override
  State<CreateAccount4> createState() => _CreateAccount4State();
}

class _CreateAccount4State extends State<CreateAccount4> {
  var checking = true;
  var checking2 = true;

  void _isChecking() {
    setState(() {
      checking = false;
    });
  }

  void _isChecking2() {
    setState(() {
      checking = true;
    });
  }

  void _isChecking3() {
    setState(() {
      checking2 = false;
    });
  }

  void _isChecking4() {
    setState(() {
      checking2 = true;
    });
  }

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  void step4Checker() {
    if (passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
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
    }
    if (passwordController.text != confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Check Password'),
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
            passwordValue: passwordController.text,
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0x3fff0c0d11),
      appBar: AppBar(
        backgroundColor: Color(0x3fff0c0d11),
      ),
      body: Container(
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
                  'Set Up',
                  style: GoogleFonts.montserrat(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  ' Password',
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
            const SizedBox(
              height: 30.0,
            ),
            Text(
              'Your password must be at least 8\ncharacters long and should not include\ncommon words or personal information.',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 44.0,
            ),
            if (checking == true)
              TextFormField(
                controller: passwordController,
                obscureText: true,
                style: GoogleFonts.inter(
                  color: const Color(0x3fff454545),
                ),
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x3ffffffff0),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x3ffffffff0),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  labelStyle: GoogleFonts.montserrat(
                    color: const Color(0x3fff454545),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: Color(0x3fff808080),
                  suffixIcon: IconButton(
                    onPressed: _isChecking,
                    icon: const Icon(Icons.remove_red_eye),
                  ),
                  suffixIconColor: Color(0x3fff808080),
                  labelText: 'Password',
                ),
              )
            else
              TextFormField(
                controller: passwordController,
                obscureText: false,
                style: GoogleFonts.inter(
                  color: const Color(0x3fff454545),
                ),
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x3ffffffff0),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x3ffffffff0),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  labelStyle: GoogleFonts.montserrat(
                    color: const Color(0x3fff454545),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  prefixIconColor: Color(0x3fff808080),
                  suffixIcon: IconButton(
                    onPressed: _isChecking2,
                    icon: Icon(Icons.remove_red_eye),
                  ),
                  suffixIconColor: Color(0x3fff808080),
                  labelText: 'Password',
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '     Must be at least 8 characters.',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            if (checking2 == true)
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                style: GoogleFonts.inter(
                  color: Color(0x3fff454545),
                ),
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x3ffffffff0),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x3ffffffff0),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  labelStyle: GoogleFonts.montserrat(
                    color: Color(0x3fff454545),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  prefixIconColor: Color(0x3fff808080),
                  suffixIcon: IconButton(
                    onPressed: _isChecking3,
                    icon: Icon(Icons.remove_red_eye),
                  ),
                  suffixIconColor: Color(0x3fff808080),
                  labelText: 'Confirm Password',
                ),
              )
            else
              TextFormField(
                controller: confirmPasswordController,
                obscureText: false,
                style: GoogleFonts.inter(
                  color: Color(0x3fff454545),
                ),
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x3ffffffff0),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x3ffffffff0),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  labelStyle: GoogleFonts.montserrat(
                    color: Color(0x3fff454545),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  prefixIconColor: Color(0x3fff808080),
                  suffixIcon: IconButton(
                    onPressed: _isChecking4,
                    icon: Icon(Icons.remove_red_eye),
                  ),
                  suffixIconColor: Color(0x3fff808080),
                  labelText: 'Confirm Password',
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '     Must be at least 8 characters.',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 16,
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
                  backgroundColor: const Color(0x3ffff0000),
                ),
                onPressed: () {
                  step4Checker();
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
    );
  }
}
