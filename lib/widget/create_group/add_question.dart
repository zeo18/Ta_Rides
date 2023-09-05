import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/widget/create_group/add_option.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({super.key});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  var selectTab = 1;
  bool isTextEntered = false;
  bool isTextEntered1 = false;
  bool iconChanged = false;

  var listOption = <Widget>[];

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

  void addOption() {
    if (isTextEntered1) {
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
            onChanged: (text) {
              setState(() {
                isTextEntered = text.isNotEmpty;
              });
            },
            decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: () {},
                icon: isTextEntered
                    ? Image.asset(
                        'assets/images/create_group_community/afterInputTextIcon.png') // Change the icon when text is entered
                    : Image.asset(
                        'assets/images/create_group_community/Icon.png'), // Default icon
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
    } else {
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
            onChanged: (text) {
              setState(() {
                isTextEntered = text.isNotEmpty;
              });
            },
            decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: addOption,
                icon: isTextEntered
                    ? Image.asset(
                        'assets/images/create_group_community/afterInputTextIcon.png') // Change the icon when text is entered
                    : Image.asset(
                        'assets/images/create_group_community/Icon.png'), // Default icon
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
                      },
                      child: Image.asset(
                          'assets/images/create_group_community/iconSelected1.png'),
                    )
                  else
                    InkWell(
                      onTap: () {
                        selectTab = 1;
                        selectedTab();
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
                      },
                      child: Image.asset(
                          'assets/images/create_group_community/iconSelected2.png'),
                    )
                  else
                    InkWell(
                      onTap: () {
                        selectTab = 2;
                        selectedTab();
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
              const SizedBox(
                height: 15,
              ),
              if (selectTab == 1)
                Column(
                  children: [
                    TextField(
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      //controller: _captionPostController,
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.white,
                      onChanged: (text) {
                        setState(() {
                          isTextEntered = text.isNotEmpty;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: addOption,
                          icon: isTextEntered
                              ? Image.asset(
                                  'assets/images/create_group_community/afterInputTextIcon.png') // Change the icon when text is entered
                              : Image.asset(
                                  'assets/images/create_group_community/Icon.png'), // Default icon
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
                    const SizedBox(
                      height: 15,
                    ),
                    if (listOption.isNotEmpty) ...listOption,
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
