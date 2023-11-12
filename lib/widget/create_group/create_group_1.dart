import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/a_reused%20_imagepicker/image_picker.dart';
import 'package:ta_rides/widget/create_group/create_group_2.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';

class CreateGroup1 extends StatefulWidget {
  const CreateGroup1({
    super.key,
    required this.user,
    required this.isPrivate,
    required this.titleText,
    required this.email,
    required this.idCommunity,
  });
  final bool isPrivate;
  final String titleText;
  final UserController user;
  final String email;
  final String idCommunity;

  @override
  State<CreateGroup1> createState() => _CreateGroup1State();
}

class _CreateGroup1State extends State<CreateGroup1> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionCommunityController = TextEditingController();
  File? _image;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 100, maxWidth: 400);
    if (pickedImage == null) {
      return;
    }

    setState(() {
      _image = File(pickedImage.path);
    });
  }

  @override
  void dispose() {
    _descriptionCommunityController.dispose();
    super.dispose();
  }

  void onThirdPage() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an image'),
          ),
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => CreateGroup2(
                  user: widget.user,
                  coverImage: _image,
                  description: _descriptionCommunityController.text,
                  isPrivate: widget.isPrivate,
                  titleText: widget.titleText,
                  email: widget.email,
                  idCommunity: widget.idCommunity,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(["private", widget.isPrivate]);
    return Scaffold(
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        backgroundColor: const Color(0x3ff0C0D11),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add your Cover Photo',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Display the skills of your squad',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: const Color(0x3ff797979),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Cover photo',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: const Color(0x3ff797979),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                Stack(
                  children: [
                    if (_image != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          File(_image!.path),
                          width: 395,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Container(
                        width: 395,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0x3ff222227),
                        ),
                      ),
                    if (_image == null)
                      Positioned(
                        top: 50,
                        left: 105,
                        child: InkWell(
                          onTap: _pickImage,
                          child: Image.asset(
                              'assets/images/community_images/uploadImage.png'),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'Add a Brief Description',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Inform the public of the expected outcome',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: const Color(0x3ff797979),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _descriptionCommunityController.text = value!;
                  },
                  controller: _descriptionCommunityController,
                  textInputAction: TextInputAction.done,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Describe your Group',
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
                  height: 120,
                ),
                Center(
                  child: Column(
                    children: [
                      Image.asset('assets/images/community_images/second.png'),
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
                        onPressed: onThirdPage,
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
      ),
    );
  }
}
