import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/auth/createAccount2.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key, required this.addUser});

  final Function(Users user) addUser;

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final lastNameController = TextEditingController();

  final firstNameController = TextEditingController();

  final middleNameController = TextEditingController();

  @override
  void dispose() {
    lastNameController.dispose();
    firstNameController.dispose();
    middleNameController.dispose();
    super.dispose();
  }

  void step1Checker() {
    if (lastNameController.text.trim().isEmpty ||
        firstNameController.text.trim().isEmpty ||
        middleNameController.text.trim().isEmpty) {
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
          builder: (context) => CreateAccount2(
            firstNameValue: firstNameController.text,
            lastNameValue: lastNameController.text,
            middleNameValue: middleNameController.text,
            addUser: widget.addUser,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    lastNameController.addListener(onListen);
    firstNameController.addListener(onListen);
    middleNameController.addListener(onListen);
  }

  void onListen() => setState(() {});

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x3fff0C0D11),
      appBar: AppBar(
        flexibleSpace: Container(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: Image.asset('assets/images/log_in/CreateAccount1stPage.png'),
        ),
        backgroundColor: const Color(0x3fff0C0D11),
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
                      color: Color(0x3ffFF0000),
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
                'STEP 1',
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
                      controller: lastNameController,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x3fffFFFFF0),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x3fffFFFFF0),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        labelStyle: GoogleFonts.montserrat(
                          color: const Color(0x3fff454545),
                        ),
                        prefixIcon: const Icon(Icons.person,
                            color: const Color(0x3fff454545)),
                        prefixIconColor: const Color(0x3fff454545),
                        suffixIcon: lastNameController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => lastNameController.clear(),
                              ),
                        labelText: 'Last Name',
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    TextFormField(
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x3fffFFFFF0),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x3fffFFFFF0),
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
                          color: const Color(0x3fff454545),
                        ),
                        prefixIconColor: const Color(0x3fff454545),
                        suffixIcon: firstNameController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => firstNameController.clear(),
                              ),
                        labelText: 'First Name',
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    TextFormField(
                      controller: middleNameController,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x3fffFFFFF0),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x3fffFFFFF0),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        labelStyle: GoogleFonts.montserrat(
                          color: const Color(0x3fff454545),
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: const Color(0x3fff454545),
                        ),
                        prefixIconColor: Color(0x3fff454545),
                        suffixIcon: middleNameController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => middleNameController.clear(),
                              ),
                        labelText: 'Middle Name',
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
                    fixedSize: const Size.fromHeight(60),
                    maximumSize: const Size.fromWidth(350),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide.none,
                    ),
                    backgroundColor: Color(0x3ffFF0000),
                  ),
                  onPressed: () {
                    step1Checker();
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
