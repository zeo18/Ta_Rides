import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/screen/auth/logInPage.dart';

class ForgotPassword3 extends StatefulWidget {
  const ForgotPassword3({super.key});

  @override
  State<ForgotPassword3> createState() {
    return _ForgotPassword3State();
  }
}

class _ForgotPassword3State extends State<ForgotPassword3> {
  bool _obscureText = true;
  bool _obscureText2 = true;

  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();

  @override
  void dispose() {
    newPassword.dispose();
    confirmNewPassword.dispose();
    super.dispose();
  }

  void forgotPassword3Checker() {
    if (newPassword.text.trim().isEmpty ||
        confirmNewPassword.text.trim().isEmpty) {
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
     if (newPassword.text != confirmNewPassword.text) {
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
    }else {
      _showDialog();
    }
  }

  void _showDialog() {
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 1,
                    sigmaY: 1,
                  ),
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide.none,
                    ),
                    title: Column(
                      children: [
                        const SizedBox(
                          height: 115,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Password Recovery',
                              style: GoogleFonts.montserrat(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: const Color(0x3fff060606),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Successful',
                          style: GoogleFonts.montserrat(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: const Color(0x3fff060606),
                          ),
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        Text(
                          'Never lose access to your account again - recover your password quickly and securely',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(60),
                            maximumSize: const Size.fromWidth(350),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide.none,
                            ),
                            backgroundColor: const Color(0x3ffFF0000),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Return to Login',
                            style: GoogleFonts.montserrat(
                                color: const Color(0x3fffFFFFF0),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 85,
                  right: 0,
                  left: 0,
                  child: Image.asset('assets/images/log_in/success.png'),
                ),
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x3fff0C0D11),
      appBar: AppBar(
        flexibleSpace: Container(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: Image.asset('assets/images/log_in/3rdPage.png'),
        ),
        backgroundColor: const Color(0x3fff0C0D11),
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
                    'Set New',
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
                      color: const Color(0x3ffFF0000),
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
                'Stay protected by setting a new\npassword that is strong and unique -\nchoose one that only you can remember.',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(
                height: 45.0,
              ),
             Form(child: Column(children: [ TextFormField(
                controller: newPassword,
                obscureText: _obscureText,
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
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: const Color(0x3fff808080),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                  ),
                  suffixIconColor: const Color(0x3fff808080),
                  labelText: 'New Password',
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              TextFormField(
                controller: confirmNewPassword,
                obscureText: _obscureText2,
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
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: const Color(0x3fff808080),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText2 = !_obscureText2;
                      });
                    },
                    child: Icon(_obscureText2
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  suffixIconColor: const Color(0x3fff808080),
                  labelText: 'Confirm Password',
                ),
              ),],),),
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
                    forgotPassword3Checker();
                  },
                  child: Text(
                    'Submit Password',
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
