import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/auth/createAccount4.dart';

class CreateAccount3 extends StatefulWidget {
  const CreateAccount3(
      {super.key,
      required this.selectedDateValue,
      required this.genderValue,
      required this.phoneNumberValue,
      required this.lastNameValue,
      required this.firstNameValue,
      required this.middleNameValue,
      required this.addUser});

  final String lastNameValue;
  final String firstNameValue;
  final String middleNameValue;

  final DateTime selectedDateValue;
  final Gender genderValue;
  final String phoneNumberValue;
  final Function(Users user) addUser;

  @override
  State<CreateAccount3> createState() => _CreateAccount3State();
}

class _CreateAccount3State extends State<CreateAccount3> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    countryController.dispose();
    super.dispose();
  }

  String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return 'Your Username is required';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    userNameController.addListener(onListen);
    emailController.addListener(onListen);
    countryController.addListener(onListen);
  }

  void onListen() => setState(() {});

  void step3Checker() {
    if (userNameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        countryController.text.trim().isEmpty) {
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
          builder: (context) => CreateAccount4(
            countryValue: countryController.text,
            emailValue: emailController.text,
            usernameValue: userNameController.text,
            firstNameValue: widget.firstNameValue,
            genderValue: widget.genderValue,
            lastNameValue: widget.lastNameValue,
            middleNameValue: widget.middleNameValue,
            phoneNumberValue: widget.phoneNumberValue,
            selectedDateValue: widget.selectedDateValue,
            addUser: widget.addUser,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(['selectDateValue', widget.selectedDateValue]);
    print(['selectPhoneNum', widget.phoneNumberValue]);
    print(['selectGender', widget.genderValue]);
    return Scaffold(
      backgroundColor: Color(0x3fff0c0d11),
      appBar: AppBar(
        flexibleSpace: Container(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: Image.asset('assets/images/log_in/CreateAccount3rdPage.png'),
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
                  SizedBox(
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
                'STEP 3',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: userNameController,
                      validator: validateUsername,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x3ffffffff0),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x3ffffffff0),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        labelStyle: GoogleFonts.montserrat(
                          color: Color(0x3fff454545),
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Color(0x3fff454545),
                        ),
                        prefixIconColor: Color(0x3fff454545),
                        suffixIcon: userNameController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                                icon: Icon(
                                  Icons.close,
                                ),
                                onPressed: () => userNameController.clear(),
                              ),
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x3ffffffff0),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x3ffffffff0),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        labelStyle: GoogleFonts.montserrat(
                          color: Color(0x3fff454545),
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Color(0x3fff454545),
                        ),
                        prefixIconColor: const Color(
                          0x3fff454545,
                        ),
                        suffixIcon: emailController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => emailController.clear(),
                              ),
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    TextFormField(
                      controller: countryController,
                      validator: validateUsername,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x3ffffffff0),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x3ffffffff0),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        labelStyle: GoogleFonts.montserrat(
                          color: Color(0x3fff454545),
                        ),
                        prefixIcon: const Icon(
                          Icons.location_on,
                          color: Color(0x3fff454545),
                        ),
                        prefixIconColor: Color(0x3fff454545),
                        suffixIcon: countryController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => countryController.clear(),
                              ),
                        labelText: 'Country',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromHeight(60),
                    maximumSize: Size.fromWidth(350),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide.none,
                    ),
                    backgroundColor: Color(0x3ffff0000),
                  ),
                  onPressed: () {
                    step3Checker();
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
