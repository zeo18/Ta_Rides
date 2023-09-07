import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/create_group/create_group_screen.dart';

class AddRules extends StatefulWidget {
  const AddRules({
    super.key,
    required this.onAddCommunity,
    required this.user,
    required this.onAddPost,
  });

  final Function(Community community) onAddCommunity;
  final Function(Post post) onAddPost;
  final Users user;

  @override
  State<AddRules> createState() => _AddRulesState();
}

class _AddRulesState extends State<AddRules> {
  int onSelectedPrivacy = 1;

  void goToFirstScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => CreateGroup(
            onSelectedPrivacy: onSelectedPrivacy,
            user: widget.user,
            onAddCommunity: widget.onAddCommunity,
            onAddPost: widget.onAddPost),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        title: Text(
          'Create Rules',
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
            TextField(
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              //controller: ,
              textInputAction: TextInputAction.done,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Write the rule',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0x3ff454545),
                  fontSize: 15,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0x3ff454545)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              //controller: ,
              textInputAction: TextInputAction.done,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Add Details',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0x3ff454545),
                  fontSize: 15,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0x3ff454545)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(
              height: 550,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0x3ffFF0000),
                minimumSize: const Size(
                  395,
                  45,
                ),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: goToFirstScreen,
              child: Text(
                'Continue',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
