import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Goal30_2ndTab extends StatelessWidget {
  const Goal30_2ndTab({super.key});

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
                    text: 'Imagine yourself ',
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '30 days\n',
                    style: GoogleFonts.montserrat(
                        color: Color(0x3ffFF0000),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'from now,\n',
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Stronger,',
                    style: GoogleFonts.montserrat(
                        color: Color(0x3ffFF0000),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Healthier,',
                    style: GoogleFonts.montserrat(
                        color: Color(0x3fffE8AA0A),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'and,\n',
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Confident\n\n',
                    style: GoogleFonts.montserrat(
                        color: Color(0x3fffE8AA0A),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "With Goal ",
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
                    text:
                        ", you'll set and\nconquer inspiring daily challenges.\n\n\n",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        "It's a fun and adventurous that will\nkeep you motivated every step of\nthe way.",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
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
