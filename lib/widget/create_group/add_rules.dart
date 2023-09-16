import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/create_group/create_group_screen.dart';

class AddRules extends StatefulWidget {
  const AddRules({
    super.key,
    required this.onAddCommunity,
    required this.user,
    required this.onAddPost,
    required this.onAddPrivateRules,
  });

  final Function(IfPrivate private) onAddPrivateRules;
  final Function(Community community) onAddCommunity;
  final Function(Post post) onAddPost;
  final Users user;

  @override
  State<AddRules> createState() => _AddRulesState();
}

class _AddRulesState extends State<AddRules> {
  int onSelectedPrivacy = 1;
  final rulesController = TextEditingController();
  final addDetailsController = TextEditingController();
  int idCommunity =
      CommunityInformation[CommunityInformation.length - 1].id + 1;

  void addRulesCommunity() {
    setState(() {
      widget.onAddPrivateRules(
        IfPrivate(
          privateCommunityId: idCommunity,
          choiceQuestion: '',
          choices: [],
          cheboxesQuestion: '',
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
