import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddOption extends StatefulWidget {
  const AddOption({
    super.key,
    required this.addWidgetOption,
  });

  final Widget? addWidgetOption;

  @override
  State<AddOption> createState() => _AddOptionState();
}

class _AddOptionState extends State<AddOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                onPressed: () {},
                icon: Image.asset(
                    'assets/images/create_group_community/Icon.png')),
            hintText: 'Add Options',
            hintStyle: GoogleFonts.inter(
              color: const Color(0x3ffE89B05),
              fontSize: 15,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2.0,
                color: Color(0x3ff454545),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
