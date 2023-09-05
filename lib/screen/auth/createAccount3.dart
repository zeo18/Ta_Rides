import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/screen/auth/createAccount4.dart';

class CreateAccount3 extends StatefulWidget {
  const CreateAccount3({super.key});

  @override
  State<CreateAccount3> createState() => _CreateAccount3State();
}

class _CreateAccount3State extends State<CreateAccount3> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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

  final countryController = TextEditingController();

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
          builder: (context) => const CreateAccount4(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0x3fff0c0d11),
      appBar: AppBar(
        flexibleSpace: Container(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: Image.asset('assets/images/log_in/3rdPage.png'),
        ),
        backgroundColor: Color(0x3fff0c0d11),
      ),
      body: Container(
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
            TextFormField(
              controller: userNameController,
              validator: validateUsername,
              style: GoogleFonts.inter(
                color: Color(0x3fff454545),
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
                prefixIcon: Icon(Icons.person),
                prefixIconColor: Color(0x3fff454545),
                suffixIcon: userNameController.text.isEmpty
                    ? Container(width: 0)
                    : IconButton(
                        icon: Icon(Icons.close),
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
                color: Color(0x3fff454545),
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
                prefixIcon: Icon(Icons.email),
                prefixIconColor: Color(0x3fff454545),
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
                color: const Color(0x3fff454545),
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
                prefixIcon: Icon(Icons.location_on),
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
            const SizedBox(
              height: 40.0,
            ),
            Center(
              child: Form(
                key: formKey,
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
            ),
          ],
        ),
      ),
    );
  }
}
