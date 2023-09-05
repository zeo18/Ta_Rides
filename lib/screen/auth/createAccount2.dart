import 'dart:ui';
//import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/screen/auth/createAccount3.dart';

class CreateAccount2 extends StatefulWidget {
  const CreateAccount2({super.key});

  @override
  State<CreateAccount2> createState() => _CreateAccount2State();
}

class _CreateAccount2State extends State<CreateAccount2> {
  TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Color(0x3ffFF0000),
              onPrimary: Colors.white,
            ),
            textTheme: TextTheme(),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      String formattedDate = DateFormat('MM/dd/yyyy').format(picked);
      setState(() {
        dateController.text = formattedDate;
      });
    }
  }

  var gender;

  final phoneNumberController = TextEditingController();

  void step2Checker() {
    final phoneNumInvalid = double.tryParse(phoneNumberController.text);
    final phoneInvalid = phoneNumInvalid == null;
    if (dateController.text.trim().isEmpty ||
        // gender  == null||
        phoneInvalid) {
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
          builder: (context) => const CreateAccount3(),
        ),
      );
    }
  }

  // final countryPicker = const FlCountryCodePicker();
  // CountryCode? countryCode;
  @override
  void initState() {
    super.initState();
    phoneNumberController.addListener(onListen);
    dateController.addListener(onListen);
  }

  void onListen() => setState(() {});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0x3fff0C0D11),
      appBar: AppBar(
        flexibleSpace: Container(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: Image.asset('assets/images/log_in/2ndPage.png'),
        ),
        backgroundColor: Color(0x3fff0C0D11),
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
                  'Create A',
                  style: GoogleFonts.montserrat(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  ' New Account',
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0x3ffFF0000),
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
              'Please enter your information below to \ncreate a new account',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Text(
              'STEP 2',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextField(
              controller: dateController,
              onTap: () {
                _selectDate(context);
              },
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 69, 69, 69),
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
                prefixIcon: const Icon(Icons.calendar_today),
                prefixIconColor: Color(0x3fff454545),
                suffixIcon: dateController.text.isEmpty
                    ? Container(width: 0)
                    : IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => dateController.clear(),
                      ),
                labelText: 'Birthday',
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            DropdownButtonFormField(
              value: gender,
              items: [
                DropdownMenuItem(
                  value: -1,
                  child: Text(
                    'Select Gender',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text(
                    'Male',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Color(0x3fff454545),
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text(
                    'Female',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0x3fff454545),
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text(
                    'Others',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Color(0x3fff454545),
                    ),
                  ),
                ),
              ],
              onChanged: (gender) {},
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
                  color: Color(0x3fff454545),
                ),
                prefixIcon: Icon(Icons.person_search_sharp),
                prefixIconColor: Color(0x3fff454545),
                labelText: 'Gender',
              ),
            ),
            SizedBox(
              height: 21,
            ),
            TextFormField(
              // onTap: () async {
              //   final code = await countryPicker.showPicker(context: context);
              //   setState(() {
              //     countryCode = code;
              //   });
              // },
              style: GoogleFonts.inter(
                color: Color(0x3fff454545),
              ),
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              maxLines: 1,
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
                // prefixIcon: countryCode != null
                //     ? Container(
                //         padding: EdgeInsets.all(10),
                //         child: countryCode!.flagImage,
                //       )
                //     : Icon(Icons.phone),
                prefixIconColor: Color(0x3fff454545),
                labelStyle: GoogleFonts.montserrat(
                  color: Color(0x3fff454545),
                ),
                suffixIcon: phoneNumberController.text.isEmpty
                    ? Container(width: 0)
                    : IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => phoneNumberController.clear(),
                      ),
                // labelText: (countryCode?.dialCode ?? ' Phone Number'),
              ),
            ),
            const SizedBox(
              height: 40.0,
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
                  step2Checker();
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
