import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/screen/auth/forgotPassword2.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0x3fff0C0D11),
      appBar: AppBar(
        flexibleSpace: Container(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: Image.asset('assets/images/log_in/1stPage.png'),
        ),
        backgroundColor: const Color(0x3fff0C0D11),
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
                  'Forgot',
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
              'Opps! It happens to the best of us. Input\nyour email address to fix the issue.',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextField(
              style: GoogleFonts.inter(
                color: const Color(0x3fff454545),
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
                prefixIcon: const Icon(Icons.email),
                prefixIconColor: const Color(0x3fff808080),
                labelText: 'Email address',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPassword2(),
                    ),
                  );
                },
                child: Text(
                  'Submit',
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
