import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Goal30_1stTab extends StatelessWidget {
  const Goal30_1stTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: Color(0x3fff0c0d11),
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: AssetImage('assets/images/goal30/goal30BG.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome to Goal ',
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '30',
                    style: GoogleFonts.montserrat(
                        color: Color(0x3ffFF0000),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' the starting point for transformation!\n\n',
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "You'll set out on a journey to\nrediscover a healthier, more\nenergetic you over the course of\nthe following ",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: '30',
                    style: GoogleFonts.montserrat(
                      color: Color(0x3ffFF0000),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: ' days\n\n\n',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: 'ARE YOU PREPARED TO TAKE\nACTION NOW?',
                    style: GoogleFonts.montserrat(
                        color: Color(0x3fffE8AA0A),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
  
  // Expanded(
    //         child: Container(
    //           margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
    //           height: 700,
    //           color: Color(0x3fff0c0d11),
    //           child: Image.asset(
    //             'assets/images/goal30BG.png',
    //             fit: BoxFit.fitWidth,
    //           ),
    //         ),
    //       ),
//background
  