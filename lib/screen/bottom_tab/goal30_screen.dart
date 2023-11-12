import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ta_rides/widget/goal30/goal30_1stTab.dart';
import 'package:ta_rides/widget/goal30/goal30_2ndTab.dart';
import 'package:ta_rides/widget/goal30/goal30_3rdTab.dart';

class Goal30Screen extends StatefulWidget {
  const Goal30Screen({super.key});

  @override
  State<Goal30Screen> createState() => _Goal30ScreenState();
}

final _goal30PageController = PageController();

class _Goal30ScreenState extends State<Goal30Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x3fff0C0D11),
      appBar: AppBar(
        backgroundColor: const Color(0x3fff0C0D11),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text(
                '   GOAL 30',
                style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: PageView(
              controller: _goal30PageController,
              children: const [
                Goal30_1stTab(),
                Goal30_2ndTab(),
                Goal30_3rdTab(),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _goal30PageController,
            count: 3,
            effect: const JumpingDotEffect(
              activeDotColor: Colors.white,
              dotHeight: 3,
              dotWidth: 30,
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
