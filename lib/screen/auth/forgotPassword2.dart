import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/screen/auth/forgotPassword3.dart';

class ForgotPassword2 extends StatelessWidget {
  const ForgotPassword2({super.key});

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
                  'Get your',
                  style: GoogleFonts.montserrat(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  ' Code',
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0x3ffFF0000),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              'Please enter the verification code sent to\nyour email/phone to complete the\nregistration process.',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 56,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(0x3fff0C0D11),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: TextField(
                    style: GoogleFonts.inter(
                      color: const Color(0x3fff797979),
                      fontSize: 22,
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  height: 56,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(0x3fff0C0D11),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: TextField(
                    style: GoogleFonts.inter(
                      color: const Color(0x3fff797979),
                      fontSize: 22,
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  height: 56,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color(0x3fff0C0D11),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: TextField(
                    style: GoogleFonts.inter(
                      color: const Color(0x3fff797979),
                      fontSize: 22,
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  height: 56,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(0x3fff0C0D11),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: TextField(
                    style: GoogleFonts.inter(
                      color: Color(0x3fff797979),
                      fontSize: 22,
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ],
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
                  backgroundColor: Color(0x3ffFF0000),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPassword3(),
                    ),
                  );
                },
                child: Text(
                  'Verify and Proceed',
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
