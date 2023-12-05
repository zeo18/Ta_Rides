import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';
import 'package:ta_rides/widget/create_group/create_group_screen.dart';

class AddRules extends StatefulWidget {
  const AddRules({
    super.key,

    // required this.onAddCommunity,
    // required this.user,
    // required this.onAddPost,
    // required this.onAddPrivateRules,
    required this.onAddPrivateCommunity,
    required this.email,
    required this.user,
    required this.idCommunity,
  });
  final String idCommunity;
  final String email;
  final UserController user;
  final Function(IfPrivate private) onAddPrivateCommunity;
  // final Function(IfPrivate private) onAddPrivateRules;
  // final Function(Community community) onAddCommunity;
  // final Function(Post post) onAddPost;
  // final Users user;

  @override
  State<AddRules> createState() => _AddRulesState();
}

class _AddRulesState extends State<AddRules> {
  int onSelectedPrivacy = 1;
  final rulesController = TextEditingController();
  final addDetailsController = TextEditingController();

  void addRulesCommunity() {
    setState(() {
      widget.onAddPrivateCommunity(
        IfPrivate(
          privateCommunityId: widget.idCommunity,
          choiceQuestion: '',
          choices: [],
          choicesAnswer: '',
          cheboxesQuestion: '',
          cheboxesAnswer: [],
          cheboxes: [],
          writtenQuestion: '',
          writtenAnswer: '',
          writeRules: rulesController.text,
          detailsRules: addDetailsController.text,
        ),
      );
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => CreateGroup(
          email: widget.email,
          idCommunity: widget.idCommunity,
          onSelectedPrivacy: 1,
          user: widget.user,
        ),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                minLines: 1,
                maxLines: 10,
                controller: rulesController,
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
                controller: addDetailsController,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.white,
                minLines: 5,
                maxLines: 10,
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
                height: 30,
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
                onPressed: () {
                  addRulesCommunity();
                  print(['rules', rulesController.text]);
                },
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
      ),
    );
  }
}
