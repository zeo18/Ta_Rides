import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';

class PrivateConditionScreen extends StatelessWidget {
  const PrivateConditionScreen({
    super.key,
    required this.community,
  });

  final Community community;

  @override
  Widget build(BuildContext context) {
    String titleBold = community.title;

    void _title() {
      Text(
        'titleBold',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 13,
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        title: Text(
          'Community Rules and Terms',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
        ),
        backgroundColor: const Color(0x3ff0C0D11),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome to ',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  TextSpan(
                    text: '${community.title}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        '! Before you become a part of our vibrant biking community, we kindly ask you to review and agree to the following terms and conditions.',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Color(0x3ff797979),
              thickness: 1.0,
              indent: 0,
              endIndent: 0,
            ),
          ],
        ),
      ),
    );
  }
}
