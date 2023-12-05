import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';
import 'package:ta_rides/widget/all_controller/private_community_controller.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';

class ChoiceItem {
  String choiceText;
  bool isSelected;

  ChoiceItem(this.choiceText, this.isSelected);
}

class PrivateConditionScreen extends StatefulWidget {
  const PrivateConditionScreen({
    super.key,
    required this.community,
    required this.email,
    required this.private,
  });

  final PrivateCommunityController private;
  final Community community;
  final String email;

  @override
  State<PrivateConditionScreen> createState() => _PrivateConditionScreenState();
}

class _PrivateConditionScreenState extends State<PrivateConditionScreen> {
  List<IfPrivate> choicePrivates = [];
  List<IfPrivate> cheboxesPrivates = [];
  List<IfPrivate> writtenPrivates = [];
  // Set<String> selectedChoices = {};
  Map<String, String> selectedChoices = {};
  Map<String, Set<String>> selectedCheckBox = {};
  // String? selectedChoice;
  TextEditingController writtenUser = TextEditingController();
  bool? isChecked = false;
  UserController userController = UserController();

  // List<ChoiceItem> selecteChoice = [
  //   // ChoiceItem("Choice 1", false),
  // ];

  @override
  void initState() {
    userController.setEmail(widget.email);
    userController.getUser(widget.email);

    for (var i = 0; i < widget.private.private.length; i++) {
      if (widget.private.private[i].choiceQuestion.isNotEmpty) {
        choicePrivates.add(widget.private.private[i]);
      }
    }

    for (var i = 0; i < widget.private.private.length; i++) {
      if (widget.private.private[i].cheboxesQuestion.isNotEmpty) {
        cheboxesPrivates.add(widget.private.private[i]);
      }
    }

    for (var i = 0; i < widget.private.private.length; i++) {
      if (widget.private.private[i].writtenQuestion.isNotEmpty) {
        writtenPrivates.add(widget.private.private[i]);
      }
    }

    super.initState();
  }
  // void _handleCircleTap(ChoiceItem selectedChoice) {
  //   setState(() {
  //     // Toggle the isSelected property for the selectedChoice
  //     selectedChoice.isSelected = !selectedChoice.isSelected;

  //     // Unselect all other choices
  //     for (var choice in selecteChoice) {
  //       if (choice != selectedChoice) {
  //         choice.isSelected = false;
  //       }
  //     }
  //   });
  // }
  // for (var private in privateCommunity) {
  //   if (private.privateCommunityId == widget.community.id) {
  //     if (private.choices.isNotEmpty) {
  //       for (var i = 0; i < private.choices.length; i++) {
  //         selecteChoice.add(ChoiceItem(private.choices[i], false));
  //       }

  //       // selecteChoice.add(ChoiceItem(private.choices[private], false));
  //     }
  //   }
  // }
  // for(var)
  // print(['selecteChoice', selecteChoice[0].choiceText]);

  @override
  Widget build(BuildContext context) {
    // String titleBold = widget.community.title;

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        text: '${widget.community.title}',
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
                const SizedBox(
                  height: 5,
                ),
                if (choicePrivates.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Questions',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Please answer the following questions to join the community.',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                if (choicePrivates.isNotEmpty)
                  for (var private in choicePrivates)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          private.choiceQuestion,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        for (var choice in private.choices)
                          Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (selectedChoices[
                                                private.choiceQuestion] ==
                                            choice) {
                                          selectedChoices
                                              .remove(private.choiceQuestion);
                                        } else {
                                          selectedChoices[
                                              private.choiceQuestion] = choice;
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 25.0,
                                          height: 25.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                            color: selectedChoices[private
                                                        .choiceQuestion] ==
                                                    choice
                                                ? Colors.white
                                                : Colors.transparent,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          choice.toString(),
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                      ],
                    ),
                if (cheboxesPrivates.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Color(0x3ff797979),
                        thickness: 1.0,
                        indent: 0,
                        endIndent: 0,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Check Boxes',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Please answer the following questions to join the community.',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                if (cheboxesPrivates.isNotEmpty)
                  for (var private in cheboxesPrivates)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          private.cheboxesQuestion,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                        for (var checkbox in private.cheboxes)
                          Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        final checkboxList =
                                            selectedCheckBox.putIfAbsent(
                                                private.cheboxesQuestion,
                                                () => {});
                                        if (checkboxList.contains(checkbox)) {
                                          checkboxList.remove(checkbox);
                                        } else {
                                          checkboxList.add(checkbox);
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 25.0,
                                          height: 25.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                            color: selectedCheckBox[private
                                                            .cheboxesQuestion]
                                                        ?.contains(checkbox) ??
                                                    false
                                                ? Colors.white
                                                : Colors.transparent,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          checkbox.toString(),
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                      ],
                    ),
                if (writtenPrivates.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Color(0x3ff797979),
                        thickness: 1.0,
                        indent: 0,
                        endIndent: 0,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Written Answer',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Please answer the following questions to join the community.',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                if (writtenPrivates.isNotEmpty)
                  for (var privates in writtenPrivates)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          privates.writtenQuestion,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.white,
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
                          textInputAction: TextInputAction.done,
                          cursorColor: Colors.white,
                          controller: writtenUser,
                          decoration: InputDecoration(
                            hintText: 'Answer',
                            hintStyle: GoogleFonts.inter(
                              color: const Color(0x3ff454545),
                              fontSize: 15,
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.4,
                                color: const Color(0x3ff454545),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
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
                  onPressed: () async {
                    List<bool> isCorrectChoice = [];
                    List<bool> isCorrectCheckBox = [];
                    List<bool> isCorrectWritten = [];
                    List<bool> isallCorrect = [];

                    if (selectedChoices.isNotEmpty) {
                      for (var i = 0; i < choicePrivates.length; i++) {
                        if (choicePrivates[i].choicesAnswer ==
                            selectedChoices.values.elementAt(i)) {
                          print('correcttt');
                          print([
                            choicePrivates[i].choicesAnswer,
                            selectedChoices.values.elementAt(i)
                          ]);
                          isCorrectChoice.add(true);
                        } else {
                          print('incorrecttt');
                          isCorrectChoice.add(false);
                        }
                      }
                      print(['isCorrect', isCorrectChoice]);
                      if (isCorrectChoice.contains(false)) {
                        print('incorrect');
                        isallCorrect.add(false);
                      } else {
                        isallCorrect.add(true);
                        print('correct');
                      }
                    }

                    List<List<String>> selectedCheckBoxList = selectedCheckBox
                        .values
                        .map((set) => set.toList())
                        .toList();

                    List<String> flattenedList =
                        selectedCheckBoxList.expand((i) => i).toList();

                    if (selectedCheckBox.isNotEmpty) {
                      for (var i = 0; i < flattenedList.length; i++) {
                        print([
                          "checkbox answer: ",
                          cheboxesPrivates[0].cheboxesAnswer[i]
                        ]);
                        // print(cheboxesPrivates[0].cheboxesAnswer.length);
                        print(["user answer: ", flattenedList[i]]);
                        // print(flattenedList.length);

                        if (flattenedList.any((list) => list
                            .contains(cheboxesPrivates[0].cheboxesAnswer[i]))) {
                          isCorrectCheckBox.add(true);
                        } else {
                          isCorrectCheckBox.add(false);
                        }
                      }
                      print(['isCorrect', isCorrectCheckBox]);
                      if (isCorrectCheckBox.contains(false)) {
                        print('incorrect');
                        isallCorrect.add(false);
                      } else {
                        isallCorrect.add(true);
                        print('correct');
                      }
                    }

                    if (writtenPrivates.isNotEmpty) {
                      for (var i = 0; i < writtenPrivates.length; i++) {
                        print([
                          "written answer: ",
                          writtenPrivates[i].writtenAnswer
                        ]);
                        print(["user answer: ", writtenUser.text]);
                        if (writtenUser.text ==
                            writtenPrivates[i].writtenAnswer) {
                          isCorrectWritten.add(true);
                        } else {
                          isCorrectWritten.add(false);
                        }
                      }
                      print(['isCorrect', isCorrectWritten]);
                      if (isCorrectWritten.contains(false)) {
                        print('incorrect');
                        isallCorrect.add(false);
                      } else {
                        print('correct');
                        isallCorrect.add(true);
                      }
                    }
                    if (isallCorrect.contains(false) ||
                        selectedChoices.isEmpty ||
                        selectedCheckBox.isEmpty ||
                        writtenUser.text.isEmpty) {
                      print('incorrect111');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please answer all the questions correctly.',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      print('correct Alllllll');

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userController.user.id)
                          .update({
                        'communityId': widget.community.id,
                        'isCommunity': true,
                      });
                      try {
                        final communityDoc = await FirebaseFirestore.instance
                            .collection('community')
                            .where('id', isEqualTo: widget.community.id)
                            .get();

                        await communityDoc.docs.first.reference.update({
                          'members': FieldValue.arrayUnion(
                              [userController.user.username]),
                        });
                      } catch (e) {
                        print('Error updating document: $e');
                      }

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => TabsScreen(
                            email: widget.email,
                            tabsScreen: 0,
                            communityTabs: 1,
                          ),
                        ),
                      );
                    }
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
        ));
  }
}
