import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ta_rides/data/community_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/create_group/add_question.dart';
import 'package:ta_rides/widget/create_group/create_group_1.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({
    super.key,
    required this.user,
    required this.onAddCommunity,
    required this.onAddPost,
  });
  final Function(Community community) onAddCommunity;
  final Function(Post post) onAddPost;
  final Users user;

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final _titleCoummunityController = TextEditingController();
  int onSelectPrivacy = 0;
  late bool selectedPrivacy = false;

  @override
  void dispose() {
    _titleCoummunityController.dispose();
    super.dispose();
  }

  void onTapPrivate() {
    setState(() {
      onSelectPrivacy = 1;
      selectedPrivacy = true;
    });
  }

  void onTapPublic() {
    setState(() {
      onSelectPrivacy = 0;
      selectedPrivacy = false;
    });
  }

  void onSecondPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => CreateGroup1(
          user: widget.user,
          onAddCommunity: widget.onAddCommunity,
          isPrivate: selectedPrivacy,
          titleText: _titleCoummunityController.text,
          onAddPost: widget.onAddPost,
        ),
      ),
    );
  }

  void onAddQuestion() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => const AddQuestion()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        backgroundColor: const Color(0x3ff0C0D11),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Group',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 29,
                    ),
              ),
              Text(
                "Discover Your Community's Perfect Name, Ignite Endless Bike Journeys!",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Color(0x3ff797979),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                cursorColor: Colors.white,
                controller: _titleCoummunityController,
                maxLength: 25,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  label: Text(
                    'Name your group',
                    style: GoogleFonts.inter(
                      color: const Color(0x3ff454545),
                      fontSize: 15,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0x3ff454545)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Privacy',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 29,
                    ),
              ),
              Text(
                "Control your group's narrative: choose public or private.",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Color(0x3ff797979),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (onSelectPrivacy == 0)
                InkWell(
                  onTap: onTapPrivate,
                  child: Image.asset(
                    'assets/images/community_images/publicJoin.png',
                    height: 35,
                  ),
                ),
              if (onSelectPrivacy == 1)
                InkWell(
                  onTap: onTapPublic,
                  child: Image.asset(
                    'assets/images/community_images/privateJoin.png',
                    height: 35,
                  ),
                ),
              if (onSelectPrivacy == 1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Questions',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'As soon as a potential member applies to join your group, ask them up to three questions. The responses will only be visible to administrators and moderators.',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Color(0x3ff797979),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0x3ffFF0000),
                          minimumSize: const Size(
                            375,
                            45,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: onAddQuestion,
                        child: Text(
                          'Add Questions',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Questions Rules',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Make group guidelines and request acceptance from prospective members.',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Color(0x3ff797979),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0x3ffFF0000),
                          minimumSize: const Size(
                            375,
                            45,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Create Rules',
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
                ),
              if (onSelectPrivacy == 0)
                const SizedBox(
                  height: 330,
                )
              else
                const SizedBox(
                  height: 40,
                ),
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/community_images/first.png'),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0x3ffFF0000),
                        minimumSize: const Size(
                          375,
                          45,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: onSecondPage,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
