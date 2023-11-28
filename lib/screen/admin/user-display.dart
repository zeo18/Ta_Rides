import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/admin/user-informations.dart';

class UserDisplay extends StatefulWidget {
  const UserDisplay({
    super.key,
    required this.users,
  });
// required this.users});

  final Users users;
  @override
  State<UserDisplay> createState() => _UserDisplayState();
}

class _UserDisplayState extends State<UserDisplay> {
// final Users users;
  @override
  Widget build(BuildContext context) {
    // refactor the column to InkWell
    // sud sa inkwell ibutang ang onTap: (){ navigate to the user information}
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserInformation(
                users: widget.users,
              ),
            ),
          );
        },
        child: Column(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: ClipOval(
                child: Image.network(
                  widget.users.userImage,
                  height: 10,
                  width: 10,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Flexible(
                child: Text(
                  "${widget.users.lastName.replaceRange(0, 1, widget.users.lastName[0].toUpperCase())},\n${widget.users.firstName.replaceRange(0, 1, widget.users.firstName[0].toUpperCase())}",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Text(
                '@${widget.users.username}',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: const Color(0x3ff797979),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
