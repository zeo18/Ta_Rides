import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/screen/admin/user-display.dart';
import 'package:ta_rides/widget/all_controller/user_controller.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UsersState();
}

class _UsersState extends State<User> {
  late FocusNode _focusNode;
  // late UserController userController;
  UserController userController = UserController();

// UsersControler diri ibutang ang mga function

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    userController.getAllUsers();

    // UsersControler.gettallusers diri ibutang ang mga function
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All users',
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // Refactor ang Expanded
        AnimatedBuilder(
          animation: userController,
          builder: (context, snapshot) {
            if (userController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Expanded(
              child: GridView(
                padding: const EdgeInsets.all(2),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      4, // decrease this value to reduce the number of columns
                  childAspectRatio:
                      0.6, // increase this value to make the cells taller
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                // Controller.users.length replace to Example1data.length
                children: [
                  for (var i = 0; i < userController.users.length; i++)
                    UserDisplay(
                      users: userController.users[i],
                    )
                  // user: userController.users[i], nya e erase ang Example1data[i], Example2data[i]
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}



//     GridView.builder(
//   itemCount: 1,
//   gridDelegate:
//       const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
//   itemBuilder: (context, index) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(200),
//         child: Container(
//           height: 50,
//           width: 50,
//           color: Colors.blue,
//           child: Center(
//             child: Text(
//.               'Item $index',
//               style: GoogleFonts.montserrat(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   },
