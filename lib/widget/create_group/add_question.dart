import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';
import 'package:ta_rides/widget/create_group/create_group_screen.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({
    super.key,
    // required this.user,
    // required this.onAddCommunity,
    // required this.onAddPost,
    required this.onAddPrivateCommunity,
    required this.email,
    required this.user,
    required this.idCommunity,
  });
  final String idCommunity;
  final String email;
  final UserController user;
  final Function(IfPrivate private) onAddPrivateCommunity;
  // final Function(Community community) onAddCommunity;
  // final Function(Post post) onAddPost;
  // final Users user;

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  var selectTab = 1;
  // int idCommunity =
  //     CommunityInformation[CommunityInformation.length - 1].id + 1;
  bool iconChanged = false;
  final _multipleChoiceQuestionController = TextEditingController();
  final _answerController = TextEditingController();
  final _choiceAnswerController = TextEditingController();
  List<String> checkAnswer = [];
  var listOption = <Widget>[];
  var listCheck = <Widget>[];

  void onAddPrivateQuestion() {
    if (selectTab == 1) {
      setState(() {
        widget.onAddPrivateCommunity(
          IfPrivate(
            privateCommunityId: widget.idCommunity,
            choiceQuestion: _multipleChoiceQuestionController.text,
            choicesAnswer: _choiceAnswerController.text,
            choices: addChoiceQuestion,
            cheboxesQuestion: '',
            cheboxes: [],
            cheboxesAnswer: [],
            writtenQuestion: '',
            writtenAnswer: '',
            writeRules: '',
            detailsRules: '',
          ),
        );
      });
    }
    if (selectTab == 2) {
      setState(() {
        widget.onAddPrivateCommunity(
          IfPrivate(
            privateCommunityId: widget.idCommunity,
            choiceQuestion: '',
            choices: [],
            choicesAnswer: '',
            cheboxesQuestion: _multipleChoiceQuestionController.text,
            cheboxes: addCheckBoxQuestion,
            cheboxesAnswer: checkAnswer,
            writtenQuestion: '',
            writtenAnswer: '',
            writeRules: '',
            detailsRules: '',
          ),
        );
      });
    }
    if (selectTab == 3) {
      setState(() {
        widget.onAddPrivateCommunity(
          IfPrivate(
            privateCommunityId: widget.idCommunity,
            choiceQuestion: '',
            choices: [],
            choicesAnswer: '',
            cheboxesQuestion: '',
            cheboxes: [],
            cheboxesAnswer: [],
            writtenQuestion: _multipleChoiceQuestionController.text,
            writtenAnswer: _answerController.text,
            writeRules: '',
            detailsRules: '',
          ),
        );
      });
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => CreateGroup(
            email: widget.email,
            user: widget.user,
            onSelectedPrivacy: 1,
            idCommunity: widget.idCommunity,
          ),
          // onSelectedPrivacy: onSelectedPrivacy,
          // user: widget.user,
          // onAddCommunity: widget.onAddCommunity,
          // onAddPost: widget.onAddPost),
        ));
  }

  void selectedTab() {
    switch (selectTab) {
      case 1:
        setState(() {
          Image.asset('assets/images/create_group_community/iconSelected1.png');
        });

        print('ffffffffffffffffffffff');

        break;
      case 2:
        setState(() {
          Image.asset('assets/images/create_group_community/iconSelected2.png');
        });

        print('ssssssssssssssssssss');

        break;
      case 3:
        setState(() {
          Image.asset('assets/images/create_group_community/iconSelected3.png');
        });

        print('eeeeeeeeeeeeeeeeeeeeeeeeee');
        break;
    }
  }

  // int onSelectedPrivacy = 1;
  // void goToFirstScreen() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (ctx) => CreateGroup(
  //         email: ,
  //         user: ,
  //     ),
  //   );
  // }

  List<String> addChoiceQuestion = [];

  List<TextEditingController> optionControllers = [];
  void addOption() {
    var choiceQuestionController = TextEditingController();
    optionControllers.add(choiceQuestionController);

    addChoiceQuestion.clear();

    print('addChoiceQuestion: $addChoiceQuestion');
    setState(() {
      listOption.add(
        TextField(
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          controller: choiceQuestionController,
          textInputAction: TextInputAction.done,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            prefixIcon: IconButton(
              onPressed: addOption,
              icon: Image.asset(
                  'assets/images/create_group_community/afterInputTextIcon.png'),
            ),
            hintText: 'Add Options',
            hintStyle: GoogleFonts.inter(
              color: const Color(0x3ffE89B05),
              fontSize: 15,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2.0,
                color: const Color(0x3ff454545),
              ),
            ),
          ),
        ),
      );
    });

    // Add the text from the controller to addChoiceQuestion
  }

  List<String> addCheckBoxQuestion = [];
  List<TextEditingController> optionCheckBoxControllers = [];
  bool _onCorrectAnswer = false;

  void _toggleCorrectAnswer() {
    setState(() {
      _onCorrectAnswer = !_onCorrectAnswer;
    });
  }

  void addCheck() {
    var checkBoxController = TextEditingController();
    optionCheckBoxControllers.add(checkBoxController);
    addCheckBoxQuestion.clear();

    print('addCheckBoxQuestion: $addCheckBoxQuestion');

    setState(() {
      listCheck.add(
        Column(
          children: [
            TextField(
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              controller: checkBoxController,
              textInputAction: TextInputAction.done,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: addCheck,
                  icon: Image.asset(
                      'assets/images/create_group_community/checkedIcon.png'), // Default icon
                ),

                //
                hintText: 'Add Checkbox',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0x3ffE89B05),
                  fontSize: 15,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: const Color(0x3ff454545),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (_onCorrectAnswer == false)
              IconButton(
                onPressed: () {
                  _toggleCorrectAnswer();
                  print('_onCorrectAnswer: $_onCorrectAnswer');

                  // checkAnswer.add(checkBoxController.text);

                  for (var i = 0; i < checkAnswer.length; i++) {
                    if (checkAnswer[i] == checkBoxController.text) {
                      setState(() {
                        checkAnswer.remove(checkBoxController.text);
                        print('gwapo ko');
                        print('object: ${checkAnswer[i]}');
                      });
                    }
                  }
                  checkAnswer.add(checkBoxController.text);
                },
                icon: _onCorrectAnswer == false
                    ? const Icon(
                        Icons.check,
                        color: Colors.yellow,
                      )
                    : Icon(Icons.access_time),
              ),
            if (_onCorrectAnswer == true) Text('data')
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        title: Text(
          'Customize Question',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: const Color(0x3ff0C0D11),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                //controller: ,
                textInputAction: TextInputAction.done,
                controller: _multipleChoiceQuestionController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Ask Question',
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
                maxLines: 6,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Question type',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (selectTab == 1)
                    InkWell(
                      onTap: () {
                        selectTab = 1;
                        selectedTab();
                        setState(() {
                          listCheck = [];
                        });
                      },
                      child: Image.asset(
                          'assets/images/create_group_community/iconSelected1.png'),
                    )
                  else
                    InkWell(
                      onTap: () {
                        selectTab = 1;
                        selectedTab();
                        setState(() {
                          listCheck = [];
                        });
                      },
                      child: Image.asset(
                          'assets/images/create_group_community/iconSelect1.png'),
                    ),
                  const SizedBox(
                    width: 8,
                  ),
                  if (selectTab == 2)
                    InkWell(
                      onTap: () {
                        selectTab = 2;
                        selectedTab();
                        setState(() {
                          listOption = [];
                        });
                      },
                      child: Image.asset(
                          'assets/images/create_group_community/iconSelected2.png'),
                    )
                  else
                    InkWell(
                      onTap: () {
                        selectTab = 2;
                        selectedTab();
                        setState(() {
                          listOption = [];
                        });
                      },
                      child: Image.asset(
                          'assets/images/create_group_community/iconSelect2.png'),
                    ),
                  const SizedBox(
                    width: 8,
                  ),
                  if (selectTab == 3)
                    InkWell(
                      onTap: () {
                        selectTab = 3;
                        selectedTab();
                        setState(() {
                          listOption = [];
                        });
                      },
                      child: Image.asset(
                          'assets/images/create_group_community/iconSelected3.png'),
                    )
                  else
                    InkWell(
                      onTap: () {
                        selectTab = 3;
                        selectedTab();
                      },
                      child: Image.asset(
                          'assets/images/create_group_community/iconSelect3.png'),
                    ),
                ],
              ),
              Stack(
                children: [
                  const SizedBox(
                    height: 500,
                    width: 440,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      if (selectTab == 1)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              controller: _choiceAnswerController,
                              textInputAction: TextInputAction.done,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.question_answer,
                                  color: Color(0x3ffE89B05),
                                ),
                                hintText: 'Answer',
                                hintStyle: GoogleFonts.inter(
                                  color: const Color(0x3ffE89B05),
                                  fontSize: 15,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: const Color(0x3ff454545),
                                  ),
                                ),
                              ),
                            ),
                            if (listOption.isNotEmpty) ...listOption,
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    addOption();
                                  },
                                  icon: Image.asset(
                                      'assets/images/create_group_community/Icon.png'),
                                ),
                                Text(
                                  'Add Options',
                                  style: GoogleFonts.inter(
                                    color: const Color(0x3ffE89B05),
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Color(0x3ff797979),
                              thickness: 0.8,
                              indent: 0,
                              endIndent: 245,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      if (selectTab == 2)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (listCheck.isNotEmpty) ...listCheck,
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: addCheck,
                                  icon: Image.asset(
                                      'assets/images/create_group_community/checkIcon.png'),
                                ),
                                Text(
                                  'Add Checkbox',
                                  style: GoogleFonts.inter(
                                    color: const Color(0x3ffE89B05),
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Color(0x3ff797979),
                              thickness: 1,
                              indent: 0,
                              endIndent: 245,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            for (var i = 0; i < checkAnswer.length; i++)
                              Text(
                                'Answers: ${checkAnswer[i]}',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      if (selectTab == 3)
                        TextField(
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          controller: _answerController,
                          textInputAction: TextInputAction.done,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Answer',
                            hintStyle: GoogleFonts.inter(
                              color: const Color(0x3ffE89B05),
                              fontSize: 15,
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.8,
                                color: const Color(0x3ff454545),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0x3ffFF0000),
                          minimumSize: const Size(
                            390,
                            45,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          if (selectTab == 1) {
                            for (var i = 0; i < optionControllers.length; i++) {
                              addChoiceQuestion.add(optionControllers[i].text);
                            }
                          }
                          if (selectTab == 2) {
                            for (var i = 0;
                                i < optionCheckBoxControllers.length;
                                i++) {
                              addCheckBoxQuestion
                                  .add(optionCheckBoxControllers[i].text);
                            }
                          }

                          onAddPrivateQuestion();
                        },
                        child: Text(
                          'Continue',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  // Positioned(
                  //   top: 410,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Color(0x3ffFF0000),
                  //       minimumSize: const Size(
                  //         390,
                  //         45,
                  //       ),
                  //       elevation: 0,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       if (selectTab == 1) {
                  //         for (var i = 0; i < optionControllers.length; i++) {
                  //           addChoiceQuestion.add(optionControllers[i].text);
                  //         }
                  //       }
                  //       if (selectTab == 2) {
                  //         for (var i = 0;
                  //             i < optionCheckBoxControllers.length;
                  //             i++) {
                  //           addCheckBoxQuestion
                  //               .add(optionCheckBoxControllers[i].text);
                  //         }
                  //       }

                  //       onAddPrivateQuestion();
                  //     },
                  //     child: Text(
                  //       'Continue',
                  //       style:
                  //           Theme.of(context).textTheme.titleMedium!.copyWith(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.w900,
                  //                 fontSize: 14,
                  //               ),
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
