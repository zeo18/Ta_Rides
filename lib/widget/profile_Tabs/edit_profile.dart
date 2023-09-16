import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/screen/bottom_tab/tabs_screen.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({
    super.key,
    required this.user,
    required this.onEditProfile,
    required this.community,
    required this.userPosted,
    required this.communityPosted,
    required this.achievements,
  });

  final Community? community;
  final List<Users> userPosted;
  final List<Post> communityPosted;
  final Achievements? achievements;
  final Users user;
  final Function(Users users) onEditProfile;

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Uint8List? _selectUserImage;
  Gender? selectedGender;
  DateTime? _SelectedDate;
  final _dateController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final user = {
    'id': 101,
    'userImage': 'assets/images/user_images/jonah.jpg',
    'username': 'jonah101',
    'password': 'jonah123',
    'firstName': 'Jonah',
    'lastName': 'Cornista',
    'email': 'jonahCornista@gmail.com',
    'birthdate': DateTime.now(),
    'gender': 'female',
    'location': 'Pajac, Lapu-Lapu City',
    'phoneNumber': '0923481231',
    'isCommunity': true,
    'communityId': 1102,
    'isAchievement': true,
  };

// Add the user data to the "User" collection
  Future<void> addUser() async {
    try {
      await firestore.collection('User').add(user);
      print('User added successfully!');
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();

    _locationController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void newProfile() {
    setState(() {
      widget.onEditProfile(Users(
        id: widget.user.id,
        userImage: '',
        chooseUserImage: _selectUserImage!,
        username: widget.user.username,
        password: widget.user.password,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        birthdate: _SelectedDate as DateTime,
        gender: selectedGender!,
        location: _locationController.text,
        phoneNumber: _phoneNumberController.text,
        followers: widget.user.followers,
        following: widget.user.following,
        isCommunity: widget.user.isCommunity,
        communityId: widget.user.communityId,
        isAchievement: widget.user.isAchievement,
      ));
    });

    var selectButtomTab = 4;
    var selectTab = 0;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (ctx) => TabsScreen(
                user: widget.user,
                community: widget.community,
                communityPosted: widget.communityPosted,
                selectTab: selectTab,
                userPosted: widget.userPosted,
                achievements: widget.achievements,
                selectButtomTab: selectButtomTab,
              )),
    );
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    print('No image selected.');
  }

  void selectedImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _selectUserImage = img;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Color(0x3ffff0000),
              onPrimary: Colors.white,
            ),
            textTheme: const TextTheme(),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      String formattedDate = DateFormat('MM/dd/yyyy').format(picked);
      setState(() {
        _dateController.text = formattedDate;
        _SelectedDate = picked; // Store the selected date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x3ff0c0d11),
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              width: 125,
            ),
            InkWell(
              onTap: () {
                // newProfile();
                addUser();
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0x3ffff0000),
                  border: Border.all(
                    color: const Color(0x3ffff0000),
                    width: 1.4,
                  ),
                ),
                child: Text(
                  'Done',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0x3ff0c0d11),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              if (_selectUserImage != null)
                Center(
                    child: InkWell(
                  onTap: selectedImage,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3.5,
                      ),
                    ),
                    child: ClipOval(
                      child: Image(
                        image: MemoryImage(_selectUserImage!),
                      ),
                    ),
                  ),
                ))
              else
                Center(
                  child: InkWell(
                    onTap: selectedImage,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3.5,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          widget.user.userImage,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 185,
                    child: TextField(
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textInputAction: TextInputAction.done,
                      controller: _lastNameController,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        hintStyle: GoogleFonts.inter(
                          color: const Color(0x3ff454545),
                          fontSize: 15,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 185,
                    child: TextField(
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.white,
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        hintStyle: GoogleFonts.inter(
                          color: const Color(0x3ff454545),
                          fontSize: 15,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textInputAction: TextInputAction.done,
                controller: _emailController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0x3ff454545),
                    fontSize: 15,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: TextField(
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textInputAction: TextInputAction.done,
                      controller: _phoneNumberController,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: GoogleFonts.inter(
                          color: const Color(0x3ff454545),
                          fontSize: 15,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 125,
                    child: DropdownButtonFormField(
                      value: selectedGender,
                      dropdownColor: const Color(0x3ffff0000),
                      items: Gender.values
                          .map(
                            (gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(
                                gender.name,
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  color: selectedGender == gender
                                      ? Colors.white
                                      : const Color(0x3fff454545),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        print(value);
                        if (value == null) {
                          return;
                        }
                        setState(
                          () {
                            selectedGender = value;
                          },
                        );
                      },
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
                        labelStyle: GoogleFonts.inter(
                          fontSize: 15,
                          color: const Color(0x3fff454545),
                        ),
                        labelText: 'Gender',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _dateController,
                onTap: () {
                  _selectDate(context);
                },
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
                  labelStyle: GoogleFonts.inter(
                    fontSize: 15,
                    color: const Color(0x3fff454545),
                  ),
                  prefixIcon: const Icon(
                    Icons.calendar_today,
                    color: Color(0x3fff454545),
                  ),
                  prefixIconColor: const Color(0x3fff454545),
                  labelText: 'Birthday',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textInputAction: TextInputAction.done,
                controller: _locationController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Location',
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0x3ff454545),
                    fontSize: 15,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15),
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
