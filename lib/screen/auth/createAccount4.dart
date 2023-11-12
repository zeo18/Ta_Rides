import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/auth/createAccount5.dart';
import 'package:ta_rides/widget/a_reused%20_imagepicker/image_picker.dart';

class CreateAccount4 extends StatefulWidget {
  const CreateAccount4(
      {super.key,
      required this.countryValue,
      required this.emailValue,
      required this.firstNameValue,
      required this.genderValue,
      required this.lastNameValue,
      required this.middleNameValue,
      required this.phoneNumberValue,
      required this.selectedDateValue,
      required this.usernameValue,
      required this.addUser});

  final String lastNameValue;
  final String firstNameValue;
  final String middleNameValue;

  final DateTime selectedDateValue;
  final Gender genderValue;
  final String phoneNumberValue;

  final String usernameValue;
  final String emailValue;
  final String countryValue;
  final Function(Users user) addUser;

  @override
  State<CreateAccount4> createState() => _CreateAccount4State();
}

class _CreateAccount4State extends State<CreateAccount4> {
  // Uint8List? selectUserImage;
  File? selectUserImage;

  @override
  void dispose() {
    super.dispose();
  }

  // pickImage(ImageSource source) async {
  //   final ImagePicker _imagePicker = ImagePicker();
  //   XFile? _file = await _imagePicker.pickImage(source: source);
  //   if (_file != null) {
  //     return await _file.readAsBytes();
  //   }
  //   print('No image selected.');
  // }

  // void selectedImage() async {
  //   Uint8List? img = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     selectUserImage = img;
  //   });
  // }

  void step4Checker() {
    if (selectUserImage == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please Complete the Form'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'Exit',
              ),
            ),
          ],
        ),
      );
      return;
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateAccount5(
            countryValue: widget.countryValue,
            emailValue: widget.emailValue,
            usernameValue: widget.usernameValue,
            firstNameValue: widget.firstNameValue,
            genderValue: widget.genderValue,
            lastNameValue: widget.lastNameValue,
            middleNameValue: widget.middleNameValue,
            phoneNumberValue: widget.phoneNumberValue,
            selectedDateValue: widget.selectedDateValue,
            addUser: widget.addUser,
            selectUserImageValue: selectUserImage!,
          ),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x3fff0c0d11),
      appBar: AppBar(
        flexibleSpace: Container(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: Image.asset('assets/images/log_in/CreateAccount4thPage.png'),
        ),
        backgroundColor: Color(0x3fff0c0d11),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Create A',
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    ' New Account',
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0x3ffff0000),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                'Please enter your information below to \ncreate a new account',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Text(
                'STEP 4',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    'Upload your best picture.',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: PickerImage(onImagePick: (File pickedImage) {
                  setState(() {
                    selectUserImage = pickedImage;
                  });
                }),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(60),
                    maximumSize: const Size.fromWidth(350),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide.none,
                    ),
                    backgroundColor: Color(0x3ffFF0000),
                  ),
                  onPressed: () {
                    step4Checker();
                  },
                  child: Text(
                    'Continue',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
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
