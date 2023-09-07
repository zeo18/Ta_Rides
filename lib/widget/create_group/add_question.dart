import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/create_group/create_group_screen.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({
    super.key,
    required this.user,
    required this.onAddCommunity,
    required this.onAddPost,
  });

  final Function(Community community) onAddCommunity;
  final Function(Post post) onAddPost;
  final Users user;

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  var selectTab = 1;

  bool iconChanged = false;

  var listOption = <Widget>[];
  var listCheck = <Widget>[];

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

  void addOption() {
    setState(() {
      listOption.add(
        TextField(
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          //controller: _captionPostController,
          textInputAction: TextInputAction.done,
          cursorColor: Colors.white,

          decoration: InputDecoration(
            prefixIcon: IconButton(
              onPressed: addOption,
              icon: Image.asset(
                  'assets/images/create_group_community/afterInputTextIcon.png'), // Default icon
            ),

            //
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
  }

  void addCheck() {
    setState(() {
      listCheck.add(
        TextField(
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          //controller: _captionPostController,
          textInputAction: TextInputAction.done,
          cursorColor: Colors.white,

          decoration: InputDecoration(
            prefixIcon: IconButton(
              onPressed: addOption,
              icon: Image.asset(
                  'assets/images/create_group_community/checkedIcon.png'), // Default icon
            ),

            //
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
                            if (listOption.isNotEmpty) ...listOption,
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: addOption,
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
                              thickness: 1,
                              indent: 0,
                              endIndent: 245,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      if (selectTab == 3)
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
                    ],
                  ),
                  Positioned(
                    top: 410,
                    child: ElevatedButton(
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
                      onPressed: goToFirstScreen,
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
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
