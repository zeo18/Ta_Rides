import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/models/community_info.dart';

class ChoiceItem {
  String choiceText;
  bool isSelected;

  ChoiceItem(this.choiceText, this.isSelected);
}

class PrivateConditionScreen extends StatefulWidget {
  const PrivateConditionScreen({
    super.key,
    required this.community,
  });

  final Community community;

  @override
  State<PrivateConditionScreen> createState() => _PrivateConditionScreenState();
}

class _PrivateConditionScreenState extends State<PrivateConditionScreen> {
  @override
  Widget build(BuildContext context) {
    String titleBold = widget.community.title;
    List<IfPrivate> choicePrivates = [];
    List<IfPrivate> cheboxesPrivates = [];
    List<IfPrivate> writtenPrivates = [];
    bool? isChecked = false;

    List<ChoiceItem> selecteChoice = [
      // ChoiceItem("Choice 1", false),
    ];

    for (var private in privateCommunity) {
      if (private.privateCommunityId == widget.community.id) {
        if (private.choices.isNotEmpty) {
          for (var i = 0; i < private.choices.length; i++) {
            selecteChoice.add(ChoiceItem(private.choices[i], false));
          }

          // selecteChoice.add(ChoiceItem(private.choices[private], false));
        }
      }
    }
    // for(var)
    // print(['selecteChoice', selecteChoice[0].choiceText]);

    void _title() {
      Text(
        'titleBold',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 13,
        ),
      );
    }

    for (var private in privateCommunity) {
      if (private.privateCommunityId == widget.community.id) {
        if (private.choiceQuestion.isNotEmpty) {
          choicePrivates.add(private);
          // selecteChoice.add(ChoiceItem(private.choices[private], false));
        }
      }
    }

    for (var private in privateCommunity) {
      if (private.privateCommunityId == widget.community.id) {
        if (private.cheboxesQuestion.isNotEmpty) {
          cheboxesPrivates.add(private);
        }
      }
    }
    for (var private in privateCommunity) {
      if (private.privateCommunityId == widget.community.id) {
        if (private.writtenAnswer.isNotEmpty) {
          writtenPrivates.add(private);
        }
      }
    }

    void _handleCircleTap(ChoiceItem selectedChoice) {
      setState(() {
        // Toggle the isSelected property for the selectedChoice
        selectedChoice.isSelected = !selectedChoice.isSelected;

        // Unselect all other choices
        for (var choice in selecteChoice) {
          if (choice != selectedChoice) {
            choice.isSelected = false;
          }
        }
      });
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
                                  onTap: () {},
                                  child: Container(
                                    width: 25.0, // Adjust the size as needed
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white, // Border color
                                        width: 2.0, // Border width
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  choice,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: Colors.white,
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
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              fillColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              activeColor: Colors.orange,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value;
                                });
                              },
                            ),
                            Text(
                              checkbox,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
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
            ],
          ),
        ),
      ),
    );
  }
}
